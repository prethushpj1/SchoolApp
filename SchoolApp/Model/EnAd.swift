//
//  EnAd.swift
//  SchoolApp
//
//  Created by Prethush on 05/03/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit
import ObjectMapper

class EnAd: Mappable {

    var id: Int?
    var imageURL: String?
    var desinationURL: String?
    var categoryInfo: ENFee?
    var type: Int?
    var status: Int?
    var userInto: EnParentInfo?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id              <- map["ID"]
        imageURL        <- map["ImageURL"]
        desinationURL   <- map["DesinationURL"]
        categoryInfo    <- map["CategoryInfo"]
        type            <- map["Type"]
        status          <- map["Status"]
        userInto        <- map["UserInfo"]
    }

}
