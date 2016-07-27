//
//  Gem.swift
//  HiddenGems
//
//  Created by Daniel Ley on 7/9/16.
//  Copyright © 2016 daniel. All rights reserved.
//

import Foundation

class Gem: NSObject {
    
    // MARK: Properties
    var name:String
    var caption:String?
    var address:String?
    var city:String?
    var state:String?
    var country:String?
    var latitude:Double
    var longitude:Double
    var directions:String?
    
    // MARK: Initialization
    init?(name:String, description: String, address: String, city: String, state: String, latitude: Double, longitude: Double, directions: String, country: String) {
        
        self.name = name
        self.caption = description
        self.address = address
        self.city = city
        self.state = state
        self.latitude = latitude
        self.longitude = longitude
        self.country = country
        self.directions = directions
        
        super.init()
        if(name.isEmpty){
            return nil
        }
    }
}
