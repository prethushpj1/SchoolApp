//
//  APIServices.swift
//  SchoolApp
//
//  Created by Prethush on 11/03/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire

class APIServices: NSObject {
    
    static let baseURL = "http://192.168.1.3:2020/vtop.svc/"
    
    func loginWith(userName: String, password: String, handler:@escaping (_ response:EnHomeData?) -> Void){
        let url = APIServices.baseURL + "Parentlogin" + "/\(userName)" + "/\(password)"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response:DataResponse<EnHomeData>) in
            handler(response.result.value)
        }
    }
}
