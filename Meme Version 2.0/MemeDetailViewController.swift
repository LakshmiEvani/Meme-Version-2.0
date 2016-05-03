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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        detailImageView.image = meme.memedImage;
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    
}
