//
//  APIServices.swift
//  SchoolApp
//
//  Created by Prethush on 11/03/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit

class APIServices: NSObject {

    fileprivate let apiManager = APIManager()
    
    func getHomeData(){
        let param = SoapParameters(WithKey: "username", andValue: "a")
        param.addParameters(WithKey: "password", andValue: "a")
        
        self.apiManager.makeRequest(ForMethod: "GetHomeData", andParameters: param)
    }
}
