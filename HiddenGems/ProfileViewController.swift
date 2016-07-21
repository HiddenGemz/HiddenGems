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
        navigationController!.pushViewController(storyboard!.instantiateViewControllerWithIdentifier("MainTabViewController") as UIViewController, animated: true)
        //self.dismissViewControllerAnimated(true, completion: nil)
        
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
