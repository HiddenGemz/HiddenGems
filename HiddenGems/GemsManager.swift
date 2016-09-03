//
//  GemsManager.swift
//  HiddenGems
//
//  Created by Daniel Ley on 8/31/16.
//  Copyright © 2016 daniel. All rights reserved.
//

import Foundation

class GemsManager : NSObject {
    
    class var shareInstance : GemsManager {
        
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
    }
    
    func removeGemAtIndex(index: Int) {
        dataPersistencyManager.removeGemAtIndex(index)
    }
}