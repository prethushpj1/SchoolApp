//
//  EnParentInfo.swift
//  SchoolApp
//
//  Created by Prethush on 06/03/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit
import ObjectMapper

class EnParentInfo: Mappable {

    var parentID: String?
    var fullName: String?
    var phone: String?
    var emailID: String?
    var address: EnAddress?
    var password: String?
    var deviceKey: String?
    var username: String?
    var children: [EnStudentInfo]?
    var status: Int?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        parentID        <- map["ParentID"]
        fullName        <- map["FullName"]
        phone           <- map["Phone"]
        emailID         <- map["EmailID"]
        address         <- map["Address"]
        self.password   <- map["Password"]
        deviceKey       <- map["DeviceKey"]
        children        <- map["Children"]
        status          <- map["Status"]
    }
}
