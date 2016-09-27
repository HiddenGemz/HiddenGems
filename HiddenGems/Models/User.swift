//
//  User.swift
//  HiddenGems
//
//  Created by Daniel Ley on 7/24/16.
//  Copyright © 2016 daniel. All rights reserved.
//

import Foundation
import UIKit

class User: NSObject {
    
    // MARK: Properties
    var fullname: String
    var email: String
    var password: String
    var username: String
    var profpic: UIImageView?
    var dateOfBirth: String?
    var dateOfCreation: String
    
    init?(fullname: String, email: String, password: String, username: String, profpic: UIImageView) {
        
        if(fullname.isEmpty || email.isEmpty || password.isEmpty || username.isEmpty) {
            return nil
        }
        
        self.fullname = fullname
        self.email = email
        self.password = password
        self.username = username
        self.profpic = profpic
        
        let currentDate : NSDate = NSDate()
        let dateFromatter = NSDateFormatter()
        
        dateFromatter.dateStyle = NSDateFormatterStyle.ShortStyle
        let convertedDate = dateFromatter.stringFromDate(currentDate)
        
        self.dateOfCreation = convertedDate
        
    }
    
}