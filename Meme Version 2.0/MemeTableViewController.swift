//
//  MemeTableViewController.swift
//  Meme Version 2.0
//
//  Created by Souji on 5/3/16.
//  Copyright © 2016 Souji. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Variable Declaration
    
    var memes: [Meme]!
    
    @IBOutlet var meMeTableView: UITableView!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    //life cycle methods
    
   override func viewDidLoad() {
        super.viewDidLoad()
        memes = appDelegate.memes
    
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        meMeTableView.delegate = self
        meMeTableView.dataSource = self
       
        memes = appDelegate.memes
        meMeTableView?.reloadData()
        
    }
    
    
    // MARK: Table View Data Source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if memes.count > 0 {
            
            return memes.count
            
        } else {
            
            return 0
        }
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let meme = self.memes[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableViewCell") as! MemeTableViewCell
        
        // Set image
        
        if memes.count > 0 {
            
            cell.memeLabel?.text = "\(meme.topText) .. \(meme.bottomText)"
            cell.memeImage?.image = meme.memedImage
            cell.memeImage?.contentMode = UIViewContentMode.ScaleAspectFit
            
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let Controller = self.storyboard?.instantiateViewControllerWithIdentifier("MemeDetailController") as! MemeDetailViewController
        
        if memes.count > 0 {
            
            Controller.meme = self.memes[indexPath.row]
            Controller.memeIndex = indexPath.row
            navigationController!.pushViewController(Controller, animated: true)
            
        }
    }
    
    @IBAction func addNewMeme(sender: AnyObject) {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("MemeViewController") as! MemeViewController
        
        presentViewController(controller, animated: true, completion: nil)
    }

    
}
