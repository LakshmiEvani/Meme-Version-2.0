//
//  MemeDetailViewController.swift
//  Meme Version 2.0
//
//  Created by Souji on 5/3/16.
//  Copyright © 2016 Souji. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController:UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    var meme: Meme!
    @IBOutlet weak var memeLabel: UILabel!
    var memeIndex: Int!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        detailImageView.image = meme.memedImage;
        tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.hidden = false
    }
    
    @IBAction func EditMeme(sender: AnyObject) {
        let memeEditorViewController = storyboard?.instantiateViewControllerWithIdentifier("MemeViewController") as! MemeViewController
        
        memeEditorViewController.memes = meme
        memeEditorViewController.memeEditIndex = memeIndex

        
    }
    
    @IBAction func DeleteMeme(sender: AnyObject) {
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.removeAtIndex(memeIndex)
        
        navigationController?.popToRootViewControllerAnimated(true)

        
    }
    
    
}
