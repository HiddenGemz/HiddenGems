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
        
        captionTextView.layer.borderColor = UIColor.blackColor().CGColor
        captionTextView.layer.borderWidth = 1.0
        captionTextView.layer.cornerRadius = 5.0
        
        shareGemButton.layer.borderWidth = 2.0
        shareGemButton.layer.cornerRadius = 1.0
    }
    
    @IBAction func shareGemTapped(sender: UIButton) {
    }
    
    @IBAction func getCurrentTapped(sender: UIButton) {
        print("Current latitude: \(locationManager.currentLatitude) current longitude:\(locationManager.currentLongitude) Current Address: \(locationManager.currentAddress)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}