//
//  ENFee.swift
//  SchoolApp
//
//  Created by Prethush on 04/03/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit
import ObjectMapper

class ENFee: Mappable {
    
    var feeID: Int?
    var feeName: String?
    var amount: Double?
    var amountPaid: Double?
    var paidStatus: Int?
    var lastDate: String?
    var fine: Double?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        feeID       <- map["FeeID"]
        feeName     <- map["FeeName"]
        amount      <- map["Amount"]
        amountPaid  <- map["AmountPaid"]
        paidStatus  <- map["PaidStatus"]
        lastDate    <- map["LastDate"]
        fine        <- map["Fine"]
    }
}
