//
//  EnAddress.swift
//  SchoolApp
//
//  Created by Prethush on 04/03/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit
import ObjectMapper

class EnAddress: Mappable {
    
    var address1: String?
    var address2: String?
    var pincode: String?
    var city: String?
    var state: String?
    var country: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        address1        <- map["Address1"]
        address2        <- map["Address2"]
        pincode         <- map["Pincode"]
        city            <- map["City"]
        state           <- map["State"]
        country         <- map["Country"]
    }
}
