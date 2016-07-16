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
    var gemDescription:String
    var address:String
    var city:String
    var state:String
    var country:String
    var latitude:Double
    var longitude:Double
    
    var directions:String
    
    // MARK: Initialization
    init?(name:String, description: String, address: String, city: String, state: String, latitude: Double, longitude: Double, directions: String) {
        
        self.name = name
        self.gemDescription = description
        self.address = address
        self.city = city
        self.state = state
        self.latitude = latitude
        self.longitude = longitude
        self.country = "United States of America"
        self.directions = directions
        
        super.init()
        if(name.isEmpty){
            return nil
        }
    }
}
