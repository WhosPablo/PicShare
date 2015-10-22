//
//  FeedViewController.swift
//  PicShare
//
//  Created by Pablo Arango on 10/16/15.
//  Copyright © 2015 Pablo Arango. All rights reserved.
//

import Parse
import Foundation

class FriendsViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customBackButton = UIBarButtonItem(title:"BACK", style:.Plain, target:nil, action:nil)
        
        customBackButton.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFontOfSize(14)], forState: UIControlState.Normal)
        self.navigationItem.backBarButtonItem = customBackButton
           
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
