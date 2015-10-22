//
//  ViewController.swift
//  PicShare
//
//  Created by Pablo Arango on 10/14/15.
//  Copyright © 2015 Pablo Arango. All rights reserved.
//
import Parse
import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var signUpUsername: UITextField!
    @IBOutlet weak var signUpEmail: UITextField!
    @IBOutlet weak var signUpPassword: UITextField!
    @IBOutlet weak var signUpPasswordVerification: UITextField!
    
    @IBOutlet weak var signUpAlert: UILabel!
    
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

    @IBAction func signUpAction(sender: AnyObject) {
        
        self.actInd.startAnimating()
        
        let username = self.signUpUsername.text
        let password = self.signUpPassword.text
        let passwordVerification = self.signUpPasswordVerification.text
        let email = self.signUpEmail.text
        
        
        
        if(username?.utf16.count<1){
            self.signUpAlert.text = "Username field is empty"
            self.signUpAlert.hidden = false
            self.actInd.stopAnimating()
            return
        }
        
        if(email?.utf16.count<5){
            self.signUpAlert.text = "Email field is empty or invalid"
            self.signUpAlert.hidden = false
            self.actInd.stopAnimating()
            return
        }
        
        if(password?.utf16.count<6){
            self.signUpAlert.text = "Password field is empty or too short"
            self.signUpAlert.hidden = false
            self.actInd.stopAnimating()
            return
        } else if (password != passwordVerification){
            self.signUpAlert.text = "Passwords do not match"
            self.signUpAlert.hidden = false
            self.actInd.stopAnimating()
            return
        }
        
        
        
        if (username?.utf16.count>=1 && password?.utf16.count>=1 && email?.utf16.count>=1 && password == passwordVerification){
            self.actInd.startAnimating()
            
            let newUser = PFUser()
            newUser.username = username;
            newUser.password = password;
            newUser.email = email;
            
            newUser.signUpInBackgroundWithBlock({(success: Bool, error: NSError?) ->
                Void in
                
                self.actInd.stopAnimating()
                
                if(error == nil){
                    self.signUpAlert.hidden = true
                    self.performSegueWithIdentifier("signUpDone", sender: self);
                    
                } else {
                    
                    var errorString = error!.localizedDescription
                    
                    errorString.replaceRange(errorString.startIndex...errorString.startIndex, with: String(errorString[errorString.startIndex]).uppercaseString)
                    
                    self.signUpAlert.text = errorString
                    self.signUpAlert.hidden = false
                }
            
            
            })
        }
        
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}

