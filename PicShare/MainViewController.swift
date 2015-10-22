//
//  MainViewController.swift
//  PicShare
//
//  Created by Pablo Arango on 10/14/15.
//  Copyright © 2015 Pablo Arango. All rights reserved.
//
import Parse
import Foundation

class MainViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if PFUser.currentUser() == nil {
            self.performSegueWithIdentifier("logInSignUpShow", sender: self)
            return
        }
        
        self.performSegueWithIdentifier("mainTabsShow", sender: self)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}