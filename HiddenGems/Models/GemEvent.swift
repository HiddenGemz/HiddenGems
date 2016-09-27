//
//  GemEvent.swift
//  HiddenGems
//
//  Created by Daniel Ley on 7/26/16.
//  Copyright © 2016 daniel. All rights reserved.
//

import Foundation

class GemEvent : NSObject {
    // MARK: Properties
    var creator : User
    var gem : Gem
    
    init(user : User, gem : Gem) {
        self.creator = user
        self.gem = gem
    }
}