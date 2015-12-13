//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UITextFieldDelegate {

    var signUpState = true
    
    func displayAlert(title:String,message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var driverLabel: UILabel!
    @IBOutlet weak var riderLabel: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBAction func signUp(sender: AnyObject) {
    
        if username.text == "" || password.text == "" {
            
            displayAlert("Missing field(s)", message:"Username and password are required.")
            
        } else {

            if signUpState == true {
               
                var user = PFUser()
                user.username = username.text
                user.password = password.text
                
                user["isDriver"] = `switch`.on
                
                user.signUpInBackgroundWithBlock {
                    (succeeded, error: NSError?) -> Void in
                    if let error = error {
                        if let errorString = error.userInfo["error"] as? String {
                            
                            self.displayAlert("Sign Up Failed", message: errorString)
                            
                        }
                        
                    } else {
                        
                        self.performSegueWithIdentifier("loginRider", sender: self)
                        
                    }
                }
                
            } else {
                
                PFUser.logInWithUsernameInBackground(username.text!, password:password.text!) {
                    (user: PFUser?, error: NSError?) -> Void in
                    if user != nil {
                        
                        self.performSegueWithIdentifier("loginRider", sender: self)
                        
                    } else {
                        
                        if let errorString = error?.userInfo["error"] as? String {
                            
                            self.displayAlert("Log In Failed", message: errorString)
                            
                        }
                    }
                }
                
                
            }
            
            
        }
    
    }
    
    @IBOutlet weak var toggleSignUpButton: UIButton!
    @IBAction func toggleSignUp(sender: AnyObject) {
    
        if signUpState == true {
            
            signUpButton.setTitle("Log In", forState: UIControlState.Normal)
            
            toggleSignUpButton.setTitle("Switch to Signup", forState: UIControlState.Normal)
            
            signUpState = false
            
            riderLabel.alpha = 0
            driverLabel.alpha = 0
            `switch`.alpha = 0
            
        } else {
            
            signUpButton.setTitle("Sign Up", forState: UIControlState.Normal)
            
            toggleSignUpButton.setTitle("Switch to Login", forState: UIControlState.Normal)
            
            signUpState = true
            
            riderLabel.alpha = 1
            driverLabel.alpha = 1
            `switch`.alpha = 1
            
        }
    
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do an y additional setup after loading the view, typically from a nib.
        
//        let testObject = PFObject(className: "TestObject")
//        testObject["foo"] = "bar"
//        testObject.saveInBackgroundWithBlock { (success, error) -> Void in
//            print("Object has been saved.")
//        }

        
        //looks for single or multiple taps to dismiss keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        //look for return button to dismiss keyboard
        self.username.delegate = self
        self.password.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //hide keyboard when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //hide keyboard on return button
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if PFUser.currentUser()?.username != nil {
        
            performSegueWithIdentifier("loginRider", sender: self)
            
        }
        
        
    }
    
}

