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

    var userInfo: EnParentInfo?
    var events: [EnEvent]?
    var schoolInfo: EnSchoolInfo?
    var status: Int?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        userInfo        <- map["UserImfo"]
        events          <- map["Events"]
        schoolInfo      <- map["SchoolInfo"]
        status          <- map["Status"]
        
    }
}
