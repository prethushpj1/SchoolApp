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
    
    static let baseURL = "http://betnbid.mobi/IDWCF/vtop.svc/"
    
    func loginWith(userName: String, password: String, handler:@escaping (_ response:EnHomeData?) -> Void){
        let url = APIServices.baseURL + "Parentlogin" + "/\(userName)" + "/\(password)"
        
        //        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response:DataResponse<EnHomeData>) in
        //            handler(response.result.value)
        //        }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) { (data, response, error) in
            
            if error != nil{
                print(error as Any)
            }
            else{
                if let respData = data{
                    do {
//                        let stringData = String(data: respData, encoding: String.Encoding.utf8)
//                        print(stringData ?? "")
                        
                        let parsedData = try JSONSerialization.jsonObject(with: respData, options: []) as! [String:Any]
                        print(parsedData)
                        
                    } catch let error as NSError {
                        print(error)
                    }
                }
            }
        }.resume()
    }
}
