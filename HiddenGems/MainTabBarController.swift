//
//  MainTabBarController.swift
//  HiddenGems
//
//  Created by Daniel Ley on 6/22/16.
//  Copyright © 2016 daniel. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
        if(!isUserLoggedIn){
            self.performSegueWithIdentifier("registrationView", sender: self)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        //NSUserDefaults.standardUserDefaults().removeObjectForKey("isUserLoggedIn")
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
        //print(isUserLoggedIn)
        if(!isUserLoggedIn){
            self.performSegueWithIdentifier("registrationView", sender: self)
        } else {
            print(NSUserDefaults.standardUserDefaults().stringForKey("username"))
            print(NSUserDefaults.standardUserDefaults().stringForKey("userEmail"))
            print(NSUserDefaults.standardUserDefaults().stringForKey("userPassword"))
            print(NSUserDefaults.standardUserDefaults().stringForKey("fullName"))
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
