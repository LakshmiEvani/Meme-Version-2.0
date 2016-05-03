//
//  MemeCollectionViewController.swift
//  Meme Version 2.0
//
//  Created by Souji on 5/3/16.
//  Copyright © 2016 Souji. All rights reserved.
//

import Foundation
import UIKit

class  MemeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    //TODO: Add outlet to flowLayout here.
    
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    
    var ImageCollectionView: UICollectionView!
    
    //Images array
    
    var memes: [Meme] {
        
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Implement flowLayout here.
        flowLayOut(self.view.frame.size)
    }
    
    
    func flowLayOut(size:CGSize){
        
        let space: CGFloat = 3.0
        let dimension1 = (view.frame.size.height - (2 * space))/2.0
        
        flowLayout?.minimumInteritemSpacing = space
        flowLayout?.minimumLineSpacing = space
        flowLayout?.itemSize = CGSizeMake(dimension1, dimension1)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = false
        self.ImageCollectionView?.delegate = self
        self.ImageCollectionView?.dataSource = self
        ImageCollectionView?.reloadData()
        
    }
    
    // MARK: Collection View Data Source
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if memes.count > 0 {
            
            return memes.count
            
        } else {
            
            return 0
        }
        
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        
        let meme = memes[indexPath.row]
        
        if memes.count > 0 {
            
            cell.memeLabel?.text = "\(meme.topText) .. \(meme.bottomText)"
            
            cell.imageMeme?.image = meme.image
            cell.imageMeme?.contentMode = UIViewContentMode.ScaleAspectFit
            
        }
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath) {
        
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        
        if memes.count > 0 {
            
            controller.meme = self.memes[indexPath.row]
            self.navigationController!.pushViewController(controller, animated: true)
            
        }
        
    }
    
}
