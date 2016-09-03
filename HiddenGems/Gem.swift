//
//  Gem.swift
//  HiddenGems
//
//  Created by Daniel Ley on 7/9/16.
//  Copyright © 2016 daniel. All rights reserved.
//

import Foundation
import UIKit

class Gem: NSObject {
    
    // MARK: Properties
    var name:String
    var caption:String?
    var address:String?
    var shortAddress:String?
    var city:String?
    var state:String?
    var latitude:Double
    var longitude:Double
    var image : UIImage
    
    //var directions:String?
    //var country:String?
    
    // MARK: Initialization
    init?(name:String, caption: String, address: String, shortAddress: String, city: String, state: String, latitude: Double, longitude: Double, image: UIImage) {
        
        self.name = name
        self.caption = caption
        self.address = address
        self.shortAddress = shortAddress
        self.city = city
        self.state = state
        self.latitude = latitude
        self.longitude = longitude
        self.image = image
        //self.country = country
        //self.directions = directions
        
        super.init()
        if(name.isEmpty){
            return nil
        }
    }
}
