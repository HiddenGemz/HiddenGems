//
//  CreateGemViewController2.swift
//  HiddenGems
//
//  Created by Daniel Ley on 8/15/16.
//  Copyright © 2016 daniel. All rights reserved.
//

import Foundation
import UIKit

class CreateGemViewController2: UIViewController {
    
    // MARK: Properties
    let locationManager = LocationManager()
    var gemPic = UIImage()
    @IBOutlet weak var gemPhoto: UIImageView?
    
    @IBOutlet weak var captionTextView: UITextView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var shareGemButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gemPhoto?.contentMode = .ScaleAspectFit
        gemPhoto?.image = gemPic
        
        // Set Delegates
        captionTextView.delegate = self
        titleTextField.delegate = self
        
        
        captionTextView.layer.borderColor = UIColor.blackColor().CGColor
        captionTextView.layer.borderWidth = 1.0
        captionTextView.layer.cornerRadius = 5.0
        
        shareGemButton.layer.borderWidth = 2.0
        shareGemButton.layer.cornerRadius = 1.0
    }
    
    @IBAction func shareGemTapped(sender: UIButton) {
        let title = titleTextField.text
        let caption = captionTextView.text
        if let address : [String : String] = parseAddress(locationManager.currentAddress!) {
            
            print(address["fullAddress"])
            print(address["shortAddress"])
            print(address["state"])
            print(address["city"])
            print(address["zipcode"])
            
            if let name = title, text = caption, fullAddress = address["fullAddress"], shortAddress = address["shortAddress"], city = address["city"], state = address["state"]{
                if let gem = Gem(name: name, caption: text, address: fullAddress, shortAddress: shortAddress, city: city, state: state, latitude: locationManager.currentLatitude, longitude: locationManager.currentLongitude, image: gemPic) {
                    
                    GemsManager.shareInstance.addGem(gem)
                }
                
                
                //let userInfo = NSUserDefaults.standardUserDefaults()
                //userInfo.setObject(gem, forKey: "currentGem")
                //userInfo.synchronize()
            }
            
            // TODO: Send Gem object up to Firebase
            
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MainTabViewController") as UIViewController
            self.presentViewController(viewController, animated: true, completion: nil)
            
        }
    }
    
    func parseAddress(var address : String) -> [String:String] {
        var parsedAddress : [String:String] = [:]
        let addressSuffix = ["Street","Avenue","Place","Road","Court","Circle","Boulevard","Drive","Creek","Land","Lane","trail","Parkway"]
        address = address.stringByReplacingOccurrencesOfString("\n", withString: " ", options: NSStringCompareOptions.LiteralSearch, range: nil)
        parsedAddress["fullAddress"] = address
        let addressArray = address.characters.split{$0 == " "}.map(String.init)
        var tempAddress : String = ""
        for var i = 0; i < addressArray.count ; ++i {
            if addressSuffix.contains(addressArray[i]) {
                tempAddress = tempAddress + " " + addressArray[i]
                parsedAddress["shortAddress"] = tempAddress
            } else {
                if let foundAddress = parsedAddress["shortAddress"] {
                    if (addressArray[i].rangeOfString(",") != nil) {
                        var index = addressArray[i].endIndex.advancedBy(-1)
                        parsedAddress["city"] = addressArray[i].substringToIndex(index)
                    } else if addressArray[i].characters.count == 2 {
                        parsedAddress["state"] = addressArray[i]
                        print("State: \(addressArray[i])")
                    } else {
                        parsedAddress["zipcode"] = addressArray[i]
                    }
                } else {
                    if i == 0 {
                        tempAddress = addressArray[i]
                    } else {
                        tempAddress = tempAddress + " " + addressArray[i]
                    }
                }
            }
        }
        //print(address)
        
        return parsedAddress
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension CreateGemViewController2 : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
    
}

extension CreateGemViewController2 : UITextViewDelegate {
    
    func textViewDidBeginEditing(textView: UITextView) {
        
        if captionTextView.text == "How can someone find your gem?" {
            captionTextView.text = ""
        }
        
    }
}