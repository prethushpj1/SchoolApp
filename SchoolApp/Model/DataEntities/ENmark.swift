//
//  ENmark.swift
//  SchoolApp
//
//  Created by Prethush on 04/03/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit
import ObjectMapper

class ENmark: Mappable {
    
    var subjectID: String?
    var subject: String?
    var marksObtained: String?
    var maxMarks: String?
    var grade: String?
    var result: String?
    var term: String?
    var date: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        subjectID       <- map["SubjectID"]
        subject         <- map["Subject"]
        marksObtained   <- map["MarksObtained"]
        maxMarks        <- map["MaxMarks"]
        grade           <- map["Grade"]
        result          <- map["Result"]
        term            <- map["Term"]
        date            <- map["Date"]
    }
}

class ENAbsence: Mappable {
    
    var date: String?
    var status: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        date        <- map["Date"]
        status      <- map["Status"]
    }
}
