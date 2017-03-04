//
//  EnTeacherInfo.swift
//  SchoolApp
//
//  Created by Prethush on 04/03/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit
import ObjectMapper

class EnTeacherInfo: Mappable {

    var teacherID: String?
    var fullName: String?
    var phone: String?
    var emailID: String?
    var subject: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        teacherID   <- map["TeacherID"]
        fullName    <- map["FullName"]
        phone       <- map["Phone"]
        emailID     <- map["EmailID"]
        subject     <- map["Subject"]
    }
}
