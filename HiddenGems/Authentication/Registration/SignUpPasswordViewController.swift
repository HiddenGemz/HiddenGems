//
//  SignUpPasswordViewController.swift
//  HiddenGems
//
//  Created by Daniel Ley on 6/30/16.
//  Copyright © 2016 daniel. All rights reserved.
//

import UIKit

class SignUpPasswordViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties 
    
    @IBOutlet var userPasswordTextField: UITextField!
    @IBOutlet var continueButton: UIButton!
    @IBOutlet weak var passwordWarningLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set delegates
        userPasswordTextField.delegate = self
        
        // Make the ContinueButton inactive when the view first appears
        continueButton.hidden = true
        continueButton.userInteractionEnabled = false

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    @IBAction func continueButtonTapped(sender: UIButton) {
        let userPassword = userPasswordTextField.text
        if(userPassword?.characters.count > 8){
            NSUserDefaults.standardUserDefaults().setObject(userPassword, forKey: "userPassword")
            NSUserDefaults.standardUserDefaults().synchronize()
            self.performSegueWithIdentifier("signUpStep3", sender: self)
        } else {
            passwordWarningLabel.textColor = UIColor.redColor()
        }
        
    }
    
    // MARK: UITextFieldDelegate Functions
    func textFieldDidBeginEditing(textField: UITextField) {
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if(!(userPasswordTextField.text?.isEmpty)!){
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
        
        let userPassword = userPasswordTextField.text
        if(userPassword?.characters.count >= 8){
            NSUserDefaults.standardUserDefaults().setObject(userPassword, forKey: "userPassword")
            NSUserDefaults.standardUserDefaults().synchronize()
            self.performSegueWithIdentifier("signUpStep3", sender: self)
        } else {
            passwordWarningLabel.textColor = UIColor.redColor()
        }
        return true
    }
}
