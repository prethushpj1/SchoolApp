//
//  EnEvent.swift
//  SchoolApp
//
//  Created by Prethush on 05/03/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit
import ObjectMapper

class EnEvent: Mappable {
    
    var eventID: String?
    var date: String?
    var sender: String?
    var eventName: String?
    var eventDetails: String?
    var type: Int?
    var status: Int?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        eventID         <- map["EventID"]
        date            <- map["date"]
        sender          <- map["Sender"]
        eventName       <- map["EventName"]
        eventDetails    <- map["EventDetails"]
        type            <- map["Type"]
    }

}
