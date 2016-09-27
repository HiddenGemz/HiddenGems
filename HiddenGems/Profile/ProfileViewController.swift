//
//  ProfileViewController.swift
//  HiddenGems
//
//  Created by Daniel Ley on 7/7/16.
//  Copyright © 2016 daniel. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutTapped(sender: UIButton) {
        
        let userInfo = NSUserDefaults.standardUserDefaults()
        userInfo.setBool(false, forKey: "isUserLoggedIn")
        userInfo.synchronize()
        try! FIRAuth.auth()!.signOut()
        
        //Log out. Transition to registration flow
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SignOrLogVC") as UIViewController
        self.presentViewController(viewController, animated: true, completion: nil)
        
    }
}
