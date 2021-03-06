//
//  LogInViewController.swift
//  PicShare
//
//  Created by Pablo Arango on 10/16/15.
//  Copyright © 2015 Pablo Arango. All rights reserved.
//
import Parse
import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var logInUsername: UITextField!
    @IBOutlet weak var logInPassword: UITextField!
    @IBOutlet weak var logInAlert: UILabel!
    
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView( frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.actInd.center = self.view.center
        self.actInd.hidesWhenStopped = true
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        
        view.addSubview(self.actInd)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logInAction(sender: AnyObject) {
        
        let username = self.logInUsername.text;
        let password = self.logInPassword.text;
        
        if(username?.utf16.count < 4 || password?.utf16.count<6){
            
            self.logInAlert.text = "Invalid password and/or email";
            self.logInAlert.hidden = false;
            print("error: password too short");
            
        } else {
            self.actInd.startAnimating()
            
            PFUser.logInWithUsernameInBackground(username!, password: password!, block: {(user:PFUser?, error: NSError?)->
                Void in
                
                self.actInd.stopAnimating()
                
                if(error == nil){
                    
                    self.logInAlert.hidden = true;
                    self.performSegueWithIdentifier("logInDone", sender: self);
                } else {
                    let errorString = error!.localizedDescription
                    print(errorString);
                    
                    self.logInAlert.text = "Invalid password and/or email";
                    self.logInAlert.hidden = false;
                }
            })
            
        }
    }
    
    
    @IBAction func cancelAction(sender: AnyObject) {
        
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}


