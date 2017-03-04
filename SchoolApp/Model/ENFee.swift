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
//    @SerializedName("Amount")
//    public long Amount;
//    @SerializedName("AmountPaid")
//    public long AmountPaid;
//    @SerializedName("PaidStatus")
//    public int PaidStatus;
//    @SerializedName("LastDate")
//    public String LastDate;
//    @SerializedName("Fine")
//    public long Fine;
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        feeID       <- map["FeeID"]
        feeName     <- map["FeeName"]
    }
}
