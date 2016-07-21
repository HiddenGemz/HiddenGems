//
//  LoginViewController.swift
//  HiddenGems
//
//  Created by Daniel Ley on 6/23/16.
//  Copyright © 2016 daniel. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {

    // MARK: Properties
    @IBOutlet weak var UserEmailTextField: UITextField!
    @IBOutlet weak var UserPasswordTextfield: UITextField!
    var userEmail: String?
    var userPassword: String?
    let userEmailStored = NSUserDefaults.standardUserDefaults().stringForKey("userEmail")
    let userPasswordStored = NSUserDefaults.standardUserDefaults().stringForKey("userPassword")
    @IBOutlet var loginButton: UIButton!
    
    @IBOutlet var emailWarningLabel: UILabel!
    
    @IBOutlet var passwordWarningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegates assignments
        UserPasswordTextfield.delegate = self
        UserEmailTextField.delegate = self
        
        // Hide login button and warning labels
        loginButton.hidden = true
        loginButton.userInteractionEnabled = false
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        emailWarningLabel.hidden = true
        passwordWarningLabel.hidden = true
    }
    
    // MARK: Actions
    @IBAction func LoginButtonTapped(sender: UIButton) {
        userEmail = UserEmailTextField.text
        userPassword = UserPasswordTextfield.text
        let userInfo = NSUserDefaults.standardUserDefaults()
        
        // BUG: LEARN CORE DATA - Retrieve user data
        
        // If login successful
        // Checking locally stored data and user
        if(userEmailStored == userEmail) {
            if(userPasswordStored == userPassword) {
                // Login Successful
                userInfo.setBool(true, forKey: "isUserLoggedIn")
                userInfo.synchronize()
                FIRAuth.auth()?.signInWithEmail(userInfo.stringForKey("userEmail")!, password: userInfo.stringForKey("userPassword")!) { (user, error) in
                    // ...
                }
                // BUG: Should send user to main app 
                performSegueWithIdentifier("loginToMain", sender: self)
                //self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                passwordWarningLabel.hidden = false
            }
        } else {
            emailWarningLabel.hidden = false
        }

    }
    @IBAction func ForgotPasswordButtonTapped(sender: UIButton) {
        // TODO: Forgot password process
        
    }
    
    // MARK: UITextFieldDelegate Functions
    func textFieldDidBeginEditing(textField: UITextField) {
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if((!(UserEmailTextField.text?.isEmpty)!) && (!(UserPasswordTextfield.text?.isEmpty)!)){
            loginButton.hidden = false
            loginButton.userInteractionEnabled = true
        } else {
            loginButton.hidden = true
            loginButton.userInteractionEnabled = false
        }
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        // Hide the keyboard
        //textField.resignFirstResponder()
        //return true
        
        userEmail = UserEmailTextField.text
        userPassword = UserPasswordTextfield.text
        let userInfo = NSUserDefaults.standardUserDefaults()
        
        // Firebase
        // If login successful
        // Checking locally stored data and user
        if(userEmailStored == userEmail) {
            if(userPasswordStored == userPassword) {
                // Login Successful
                FIRAuth.auth()?.signInWithEmail(userInfo.stringForKey("userEmail")!, password: userInfo.stringForKey("userPassword")!) { (user, error) in
                    // ...
                }
                userInfo.setBool(true, forKey: "isUserLoggedIn")
                userInfo.synchronize()
                // BUG: Should send user to main app
                performSegueWithIdentifier("loginToMain", sender: self)
                //self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                passwordWarningLabel.hidden = false
            }
        } else {
            emailWarningLabel.hidden = false
        }
        
        return true
    }
    
    
    // MARK: other functions
    func displayMyAlertMessage(message:String, alertTitle: String){
        let myAlert = UIAlertController(title: alertTitle, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated:true, completion:nil)
    }


}
