//
//  SignUpUsernameViewController.swift
//  HiddenGems
//
//  Created by Daniel Ley on 7/2/16.
//  Copyright © 2016 daniel. All rights reserved.
//

import UIKit

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
        // Best method to do this?
        var birthdate:String
        if(!(fullNameTextField.text?.isEmpty)!){
            fullName = fullNameTextField.text!
            NSUserDefaults.standardUserDefaults().setObject(fullName, forKey: "fullName")
        }
        if(!(dateTextField.text?.isEmpty)!){
            birthdate = dateTextField.text!
            NSUserDefaults.standardUserDefaults().setObject(birthdate, forKey: "birthdate")
        }
        //if(profileImageView != nil) {
          //  NSUserDefaults.standardUserDefaults().setObject(profileImageView, forKey: "profileImage")
        //}
        NSUserDefaults.standardUserDefaults().setObject(username, forKey: "username")
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
        NSUserDefaults.standardUserDefaults().synchronize()
        performSegueWithIdentifier("signUpToMain", sender: self)
    }
    
    // MARK: UITextFieldDelegate 
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        var username:String
        if(!(usernameTextField.text?.isEmpty)!){
            username = usernameTextField.text!
            NSUserDefaults.standardUserDefaults().setObject(username, forKey: "username")
            print(username)
            var fullName:String
            // Best method to do this?
            var birthdate:String
            if(!(fullNameTextField.text?.isEmpty)!){
                fullName = fullNameTextField.text!
                NSUserDefaults.standardUserDefaults().setObject(fullName, forKey: "fullName")
                print(fullName)
            }
            if(!(dateTextField.text?.isEmpty)!){
                birthdate = dateTextField.text!
                NSUserDefaults.standardUserDefaults().setObject(birthdate, forKey: "birthdate")
            }
            //if(profileImageView != nil) {
              //  NSUserDefaults.standardUserDefaults().setObject(profileImageView, forKey: "profileImage")
            //}
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
            NSUserDefaults.standardUserDefaults().synchronize()
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
