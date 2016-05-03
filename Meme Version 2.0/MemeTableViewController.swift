//
//  MemeTableViewController.swift
//  Meme Version 2.0
//
//  Created by Souji on 5/3/16.
//  Copyright © 2016 Souji. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    // Variable Declaration
    
    var memes: [Meme]{
        
        return (UIApplication.sharedApplication().delegate as? AppDelegate)!.memes
        
    }
    
    
    @IBOutlet var meMeTableView: UITableView!
    
    //life cycle method
    
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
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
        
        let Controller = self.storyboard?.instantiateViewControllerWithIdentifier("MemeDetailController") as! MemeDetailViewController
        
        if memes.count > 0 {
            
            Controller.meme = self.memes[indexPath.row]
            
            navigationController!.pushViewController(Controller, animated: true)
            
        }
    }
    
    
}
