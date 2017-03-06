//
//  EnStudentInfo.swift
//  SchoolApp
//
//  Created by Prethush on 04/03/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit
import ObjectMapper

class EnStudentInfo: Mappable {
    
    var studentID: String?
    var rollNo: String?
    var firstGuardianID:String?
    var secondGuardianID: String?
    var classTeacher: EnTeacherInfo?
    var schoolInfo : EnSchoolInfo?
    var studentName: String?
    var className: String?
    var division: String?
    var bloodGroup: String?
    var imageURL: String?
    var marksheet: [ENmark]?
    var absenceInfo: ENAbsence?
    var fees: [ENFee]?
    var events: [EnEvent]?
    var status: Int?
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        studentID           <- map["StudentID"]
        rollNo              <- map["RollNo"]
        firstGuardianID     <- map["FirstGuardianID"]
        secondGuardianID    <- map["SecondGuardianID"]
        classTeacher        <- map["ClassTeacher"]
        schoolInfo          <- map["SchoolInfo"]
        studentName         <- map["StudentName"]
        className           <- map["Class"]
        division            <- map["Division"]
        bloodGroup          <- map["BloodGroup"]
        imageURL            <- map["ImageURL"]
        marksheet           <- map["Marksheet"]
        absenceInfo         <- map["AbsenceInfo"]
        fees                <- map["Fees"]
        events              <- map["Events"]
        status              <- map["Status"]
    }
        
}
