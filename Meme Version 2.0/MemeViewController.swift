//
//  MemeViewController.swift
//  Meme Version 2.0
//
//  Created by Souji on 5/3/16.
//  Copyright © 2016 Souji. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
    // Outlets declaration
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
 
    
    var memes: Meme!
    var memeEditIndex: Int!
    
    //Lifecycle Functions
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupTextField(topText, defaultText: "TOP")
        setupTextField(bottomText, defaultText: "BOTTOM")
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        subscribeToKeyboardNotifications()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // Textfields setup Functions
    
    func setupTextField(textField: UITextField, defaultText: String) {
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName:-3.6,
            NSBackgroundColorAttributeName: UIColor.clearColor()
        ]
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.Center
        textField.borderStyle = UITextBorderStyle.None
        textField.delegate = self
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    // Pick an image Functions
    
    func pickAnImageFromSource(source: UIImagePickerControllerSourceType)
    {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func pickAnImage(sender: AnyObject) {
        
        pickAnImageFromSource(.PhotoLibrary)
    }
    
    @IBAction func pickAnImageFomCamera(sender: AnyObject) {
        
        pickAnImageFromSource(.Camera)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            imagePickerView.contentMode = .ScaleAspectFit
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Keyboard Functions
    
    func subscribeToKeyboardNotifications() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:"    , name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:"    , name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if bottomText.isFirstResponder() {
            
            view.frame.origin.y = getKeyboardHeight(notification) * -1
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification){
        
        if bottomText.isFirstResponder() {
            view.frame.origin.y = 0
        }
    }
    
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    // Share image Function
    
    @IBAction func share(sender: UIBarButtonItem) {
        
        if imagePickerView.image != nil {
            
            shareButton.enabled = true
            let newMemeImage =  generateMemedImage()
            let shareActivity = UIActivityViewController(activityItems: [newMemeImage], applicationActivities: nil)
            
            shareActivity.completionWithItemsHandler = { activity, success, items, error in
                
                if success {
                    self.save(newMemeImage)
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            }
            presentViewController(shareActivity, animated: true, completion: nil)
            
            if memes != nil {
                
                deleteMeme()
            }
        }
    }
    
    // Save an image Function
    
    func save(meMeImage: UIImage){
        
        let meme = Meme(topText: topText.text!,
            bottomText: bottomText.text!,
            image: imagePickerView.image,
            memedImage: meMeImage)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
    }
    
    //Image generation Function
    
    func generateMemedImage() -> UIImage {
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.setToolbarHidden(true, animated: true)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        navigationController?.setToolbarHidden(false, animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        
        return memedImage
    }
    
    // delete old meme
    func deleteMeme() {
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.removeAtIndex(memeEditIndex)
    }

    
}

