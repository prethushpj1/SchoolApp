//
//  EnSchoolInfo.swift
//  SchoolApp
//
//  Created by Prethush on 04/03/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit
import ObjectMapper

class EnSchoolInfo: Mappable {

    var schoolID: String?
    var schoolName: String?
    var phone: String?
    var emailID: String?
    var address: EnAddress?
    var teachers: [EnTeacherInfo]?
    var events: [EnEvent]?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        schoolID        <- map["SchoolID"]
        schoolName      <- map["SchoolName"]
        phone           <- map["Phone"]
        emailID         <- map["EmailID"]
        teachers        <- map["Teachers"]
        address         <- map["Address"]
        events          <- map["Events"]
    }
}
