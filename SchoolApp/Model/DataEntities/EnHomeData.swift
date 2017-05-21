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
    var status: Int?
    var model: EnHomeDataModel?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        status          <- map["Status"]
        model           <- map["Data"]
    }
    
    func getHomeDataList() -> (events:[EnEvent]?, announcements:[EnEvent]?){
        
        var events = [EnEvent]()
        var announcements = [EnEvent]()
        
        if let urChildren = self.model?.userInfo?.children{
            for childrenObj in urChildren {
                if let arrayEvents = childrenObj.schoolInfo?.events{
                    for event in arrayEvents {
                        if event.type == 1 {
                            events.append(event)
                        }
                        else{
                            announcements.append(event)
                        }
                    }
                }
            }
        }
        
        return (events, announcements)
    }
}

class EnHomeDataModel: Mappable {
    
    var userInfo: EnParentInfo?
    
    required init?(map: Map) {
        mapping(map: map)
    }

    func mapping(map: Map) {
        userInfo        <- map["HomeData"]
    }
}
