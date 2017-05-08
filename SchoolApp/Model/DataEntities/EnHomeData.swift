//
//  EnHomeData.swift
//  SchoolApp
//
//  Created by Prethush on 06/03/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit
import ObjectMapper

class EnHomeData: Mappable {
    var status: Int?
    var model: EnHomeDataModel?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        status          <- map["Status"]
        model           <- map["Data"]
    }
}

class EnHomeDataModel: Mappable {
    
    var userInfo: EnParentInfo?
    
    required init?(map: Map) {
        mapping(map: map)
    }

    func mapping(map: Map) {
        userInfo        <- map["HomeData"]
    }
}
