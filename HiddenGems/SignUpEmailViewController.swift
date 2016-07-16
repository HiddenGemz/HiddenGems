//
//  SignUpEmailViewController.swift
//  HiddenGems
//
//  Created by Daniel Ley on 6/28/16.
//  Copyright © 2016 daniel. All rights reserved.
//

import UIKit

class SignUpEmailViewController: UIViewController, UITextFieldDelegate {

    // MARK: Properties
    @IBOutlet var userEmailTextField: UITextField!
    @IBOutlet var continueButton: UIButton!
    
    @IBOutlet var emailWarningLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Delegates
        userEmailTextField.delegate = self
        
        // Make the ContinueButton inactive when the view first appears
        continueButton.hidden = true
        continueButton.userInteractionEnabled = false
    }
    
    override func viewWillAppear(animated: Bool) {
        emailWarningLabel.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
    
    // MARK: Actions
    @IBAction func continueButtonTapped(sender: UIButton) {
        let userEmail = userEmailTextField.text
        if(isValidEmail(userEmail!)){
            NSUserDefaults.standardUserDefaults().setObject(userEmail, forKey: "userEmail")
            NSUserDefaults.standardUserDefaults().synchronize()
            self.performSegueWithIdentifier("signUpStep2", sender: self)
        } else {
            emailWarningLabel.hidden = false
        }
    }
    
    
    // MARK: UITextFieldDelegate Functions
    func textFieldDidBeginEditing(textField: UITextField) {
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // BUG: Button shows if not empty and has '@'
        // Need to add qualifications for Email so .com/.net/.org etc
        if((!(userEmailTextField.text?.isEmpty)!) && (isValidEmail((userEmailTextField.text)!))){
            continueButton.hidden = false
            continueButton.userInteractionEnabled = true
        } else {
            continueButton.hidden = true
            continueButton.userInteractionEnabled = false
        }
        return true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        textField.isFirstResponder()
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        // Hide the keyboard
        //textField.resignFirstResponder()
        let userEmail = userEmailTextField.text
        if(isValidEmail(userEmail!)){
            NSUserDefaults.standardUserDefaults().setObject(userEmail, forKey: "userEmail")
            NSUserDefaults.standardUserDefaults().synchronize()
            self.performSegueWithIdentifier("signUpStep2", sender: self)
        } else {
            emailWarningLabel.hidden = false
        }
        return true
    }
    
    // MARK: Utility Functions
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }

}
