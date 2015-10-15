//
//  ViewController.swift
//  PicShare
//
//  Created by Pablo Arango on 10/14/15.
//  Copyright © 2015 Pablo Arango. All rights reserved.
//
import Parse
import UIKit

class SignUpLogInViewController: UIViewController {

    @IBOutlet weak var signUpUsername: UITextField!
    @IBOutlet weak var signUpEmail: UITextField!
    @IBOutlet weak var signUpPassword: UITextField!
    @IBOutlet weak var signUpPasswordVerification: UITextField!
    
    @IBOutlet weak var signUpAlert: UILabel!
    
    @IBOutlet weak var logInUsername: UITextField!
    @IBOutlet weak var logInPassword: UITextField!
    
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
            self.signUpAlert.text = "Missing Username".capitalizedString
            self.signUpAlert.hidden = false
            self.actInd.stopAnimating()
        }
        
        if(password?.utf16.count<1){
            self.signUpAlert.text = "Missing Password".capitalizedString
            self.signUpAlert.hidden = false
        } else if (password != passwordVerification){
            self.signUpAlert.text = "Passwords do not match"
            self.signUpAlert.hidden = false
            self.actInd.stopAnimating()
        }
        
        if(email?.utf16.count<1){
            self.signUpAlert.text = "Missing Username".capitalizedString
            self.signUpAlert.hidden = false
            self.actInd.stopAnimating()
        }
        
        if (username?.utf16.count>=1 && password?.utf16.count>=1 && email?.utf16.count>=1 ){
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
                    let alert = UIAlertView(title: "Logged In", message: "Success", delegate: self, cancelButtonTitle: "OK")
                    alert.show();
                    
                } else {
                    let errorString = error!.localizedDescription
                    
                    self.signUpAlert.text = "\(errorString)".capitalizedString
                    self.signUpAlert.hidden = false
                }
            
            
            })
        }
        
            
        
        
        
    }

    @IBAction func logInAction(sender: AnyObject) {
        
        let username = self.logInUsername.text;
        let password = self.logInPassword.text;
        
        if(username?.utf16.count < 4 || password?.utf16.count<6){
            
            let alert = UIAlertView(title: "Invalid", message: "Invalid password or email", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else {
            self.actInd.startAnimating()
            
            PFUser.logInWithUsernameInBackground(username!, password: password!, block: {(user:PFUser?, error: NSError?)->
                Void in
                
                self.actInd.stopAnimating()
                
                if(error == nil){
                    let alert = UIAlertView(title: "Logged In", message: "Success", delegate: self, cancelButtonTitle: "OK")
                    alert.show();
                } else {
                    let errorString = error!.localizedDescription
                    let alert = UIAlertView(title: "Error", message: "\(errorString)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
                
                
            })
            
        }
        
        
    }
}

