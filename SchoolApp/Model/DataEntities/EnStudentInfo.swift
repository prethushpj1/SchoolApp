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
    var firstGuardian:String?
    var secondGuardian: String?
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
    var status: Int?
    var gender: Int?
    var dob: String?
    var registerNumber: String?
    var classID: String?
    var timeTable: [EnTimeTable]?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        studentID           <- map["StudentID"]
        rollNo              <- map["RollNo"]
        firstGuardian       <- map["FirstGuardian"]
        secondGuardian      <- map["SecondGuardian"]
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
        status              <- map["Status"]
        gender              <- map["Sex"]
        dob                 <- map["DOB"]
        registerNumber      <- map["RegisterNumber"]
        classID             <- map["ClassID"]
        timeTable           <- map["TimeTableDetails"]
    }
    
    func getTermsList() -> [String]?{
        var terms = [String]()
        if let urMarkSheet = marksheet {
            for mark in urMarkSheet {
                terms.append(mark.term ?? "")
            }
        }
        return terms
    }
    
    func getMarklistFor(Term term: String) -> [ENmark]?{
        var marklist = [ENmark]()
        if let urMarkSheet = marksheet {
            for mark in urMarkSheet {
                if mark.term == term {
                    marklist.append(mark)
                }
            }
        }
        return marklist
    }
}

class EnTimeTable: Mappable {

    var date: String?
    var startTime: String?
    var endTime: String?
    var maximumMark: String?
    var subject: String?
    var comment: String?
    var periodIndex: String?
    var dayIndex: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        date        <-  map["Date"]
        startTime   <-  map["StartTime"]
        endTime     <-  map["EndTime"]
        maximumMark <-  map["MaximumMArk"]
        subject     <-  map["Subject"]
        comment     <-  map["Comments"]
        periodIndex <-  map["PeriodIndex"]
        dayIndex    <-  map["DayIndex"]
        
    }
}
