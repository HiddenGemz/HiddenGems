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
    let rootRef = FIRDatabase.database().referenceFromURL("https://hidden-gems-3185b.firebaseio.com/")
    let usersRef = FIRDatabase.database().referenceFromURL("https://hidden-gems-3185b.firebaseio.com/Users")
    let gemRef = FIRDatabase.database().referenceFromURL("https://hidden-gems-3185b.firebaseio.com/Gems")
    let storage = FIRStorage.storage()
    
    override init() {
        super.init()
    
    }
    
    func addGemToDatabase(gem:Gem) -> Void {
        let currentGemRef = self.gemRef.child(gem.name)
        currentGemRef.setValue(gem.toAnyObject())
    }
    
    func addUserToDatabase(user: User) -> Void {
        
    }
}
