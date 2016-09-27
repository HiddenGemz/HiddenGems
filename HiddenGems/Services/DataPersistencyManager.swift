//
//  DataPersistencyManager.swift
//  HiddenGems
//
//  Created by Daniel Ley on 8/31/16.
//  Copyright © 2016 daniel. All rights reserved.
//

import Foundation

class DataPersistencyManager : NSObject {
    
    private var gemsList = [Gem]()
    
    override init() {
        super.init()
    }
    
    func getGemsList() -> [Gem] {
        return gemsList
    }
    
    func addGem(newGem: Gem) {
        gemsList.append(newGem)
    }
    
    func removeGemAtIndex(index: Int) {
        gemsList.removeAtIndex(index)
    }
}