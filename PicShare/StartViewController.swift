//
//  ViewController.swift
//  PicShare
//
//  Created by Pablo Arango on 10/14/15.
//  Copyright © 2015 Pablo Arango. All rights reserved.
//
import Parse
import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var signUpUsername: UITextField!
    @IBOutlet weak var signUpEmail: UITextField!
    @IBOutlet weak var signUpPassword: UITextField!
    @IBOutlet weak var signUpPasswordVerification: UITextField!
    
    @IBOutlet weak var logInUsername: UITextField!
    @IBOutlet weak var logInPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signUpAction(sender: AnyObject) {
    }

    @IBAction func logInAction(sender: AnyObject) {
    }
}

