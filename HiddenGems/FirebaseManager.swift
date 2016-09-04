//
//  FirebaseManager.swift
//  HiddenGems
//
//  Created by Daniel Ley on 9/3/16.
//  Copyright © 2016 daniel. All rights reserved.
//

import Foundation
import Firebase

class FirebaseManager : NSObject{
    
    let ref = FIRDatabase.database().reference()
    
    override init() {
        super.init()
    
    }
}
