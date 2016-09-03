//
//  SignUpUsernameViewController.swift
//  HiddenGems
//
//  Created by Daniel Ley on 7/2/16.
//  Copyright © 2016 daniel. All rights reserved.
//

import UIKit
import Firebase

class SignUpUsernameViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set Properties
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2
        self.profileImageView.clipsToBounds = true
        
        self.continueButton.hidden = true
        self.continueButton.userInteractionEnabled = false
        
        // Delegates
        dateTextField.delegate = self
        usernameTextField.delegate = self
        fullNameTextField.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: Actions
    @IBAction func textFieldEditing(sender: AnyObject) {
        
        // BUG/TODO: New method for user input of birthdate
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        dateTextField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(SignUpUsernameViewController.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    @IBAction func selectImageFromPhotoLibrary(sender: UIButton) {
        
        dateTextField.resignFirstResponder()
        // UIImagePickerController is a view controller that lets a user pick media from their photo library
        let imagePickerController = UIImagePickerController()
        
        // ONly allow photos to be picked, not taken
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user pcks an image
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController,animated: true, completion: nil)
    }

    @IBAction func continueButtonTapped(sender: UIButton) {
        let username = usernameTextField.text
        var fullName:String
        let userInfo = NSUserDefaults.standardUserDefaults()
        // Best method to do this?
        var birthdate:String
        if(!(fullNameTextField.text?.isEmpty)!){
            fullName = fullNameTextField.text!
            userInfo.setObject(fullName, forKey: "fullName")
        }
        if(!(dateTextField.text?.isEmpty)!){
            birthdate = dateTextField.text!
            userInfo.setObject(birthdate, forKey: "birthdate")
        }
        //if(profileImageView != nil) {
          //  NSUserDefaults.standardUserDefaults().setObject(profileImageView, forKey: "profileImage")
        //}
        userInfo.setObject(username, forKey: "username")
        FIRAuth.auth()?.createUserWithEmail(userInfo.stringForKey("userEmail")!, password: userInfo.stringForKey("userPassword")!) { (user, error) in
            // ...
        }
        userInfo.setBool(true, forKey: "isUserLoggedIn")
        userInfo.synchronize()
        
        // Successfully created User. Present MainTabBar Flow
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MainTabViewController") as UIViewController
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    // MARK: UITextFieldDelegate 
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        var username:String
        let userInfo = NSUserDefaults.standardUserDefaults()
        if(!(usernameTextField.text?.isEmpty)!){
            username = usernameTextField.text!
            userInfo.setObject(username, forKey: "username")
            print(username)
            var fullName:String
            // Best method to do this?
            var birthdate:String
            if(!(fullNameTextField.text?.isEmpty)!){
                fullName = fullNameTextField.text!
                userInfo.setObject(fullName, forKey: "fullName")
                print(fullName)
            }
            if(!(dateTextField.text?.isEmpty)!){
                birthdate = dateTextField.text!
                userInfo.setObject(birthdate, forKey: "birthdate")
            }
            //if(profileImageView != nil) {
              //  NSUserDefaults.standardUserDefaults().setObject(profileImageView, forKey: "profileImage")
            //}
            FIRAuth.auth()?.createUserWithEmail(userInfo.stringForKey("userEmail")!, password: userInfo.stringForKey("userPassword")!) { (user, error) in
                // ...
            }

            userInfo.setBool(true, forKey: "isUserLoggedIn")
            userInfo.synchronize()
            print("end of method, should send to seque")
            performSegueWithIdentifier("signUpToMain", sender: self)
        }
        
        return true

    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if(!((usernameTextField.text?.isEmpty)!)){
            continueButton.hidden = false
            continueButton.userInteractionEnabled = true
        }
        return true
    }
    
   
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        // Dismiss the picker if the user canceled
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        profileImageView.image = selectedImage
        self.profileImageView.layer.borderWidth = 3.0
        self.profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        
        // Dismiss Picker
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    // MARK: Other Functions
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        dateTextField.text = dateFormatter.stringFromDate(sender.date)
        
    }


}
