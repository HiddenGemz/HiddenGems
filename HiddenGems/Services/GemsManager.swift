//
//  GemsManager.swift
//  HiddenGems
//
//  Created by Daniel Ley on 8/31/16.
//  Copyright © 2016 daniel. All rights reserved.
//

import Foundation

class GemsManager : NSObject {
    
    let firebaseManager = FirebaseManager()
    
    class var sharedInstance : GemsManager {
        
        struct Singleton {
            static let instance = GemsManager()
        }
        return Singleton.instance
    }
    
    private let dataPersistencyManager: DataPersistencyManager
    
    override init() {
        dataPersistencyManager = DataPersistencyManager()
    }
    
    func getGemsList() -> [Gem] {
        return dataPersistencyManager.getGemsList()
    }
    
    func addGem(newGem: Gem) {
        dataPersistencyManager.addGem(newGem)
        
        // Send Gem object up to Firebase
        firebaseManager.addGemToDatabase(newGem)
    }
    
    func removeGemAtIndex(index: Int) {
        dataPersistencyManager.removeGemAtIndex(index)
    }
}