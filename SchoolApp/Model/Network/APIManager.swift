//
//  APIManager.swift
//  SchoolApp
//
//  Created by Prethush on 04/03/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit

class APIManager: NSObject {
    
    fileprivate let NAMESPACE           = "http://tempuri.org/"
    fileprivate let SOAPACTION          = "http://tempuri.org/IVTOP/"
    fileprivate let serverURL           = "http://betnbid.mobi/IDWCF/VTop.svc"
    
    fileprivate func createSOAPBody(WithMethodName method: String, andParameters parameters:SoapParameters?) -> String{
        var JSONBody = ""
        if let urParameters = parameters, let keyValueDict = urParameters.getParameters(){
            
            if let theJSONData = try? JSONSerialization.data(
                withJSONObject: keyValueDict,
                options: [.prettyPrinted]) {
                JSONBody = String(data: theJSONData,
                                         encoding: .ascii) ?? ""
            }
        }
        
        let soapMessage = "<soap:Envelope " +
        "xmlns:i=\"http://www.w3.org/2001/XMLSchema-instance\" " +
        "xmlns:d=\"http://www.w3.org/2001/XMLSchema\" " +
        "xmlns:c=\"http://schemas.xmlsoap.org/soap/encoding/\" " +
        "xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\"> " +
        "<soap:Header/> " +
        "<soap:Body> " +
        "\(method)" +
        "\(JSONBody)" +
        "</soap:Body> " +
        "</soap:Envelope>"
        return soapMessage
        
//        let soapMessage =
//            "\(method)" +
//            "\(JSONBody)"
//        return soapMessage
    }
    
    fileprivate func xmlEncode(Request request: String) -> String{
        var encodedRequest =  request.replacingOccurrences(of: "&", with: "&amp;")
        encodedRequest = encodedRequest.replacingOccurrences(of: "<", with: "&lt;")
        encodedRequest = encodedRequest.replacingOccurrences(of: ">", with: "&gt;")
        return encodedRequest
    }
    
    func makeRequest(ForMethod method: APIMethods, andParameters parameters:SoapParameters?){
        let methodString = method.rawValue
        
        var soapMessage = self.createSOAPBody(WithMethodName: methodString, andParameters: parameters)
        print(soapMessage)
        //soapMessage = self.xmlEncode(Request: soapMessage)
        
        var request = URLRequest(url: URL(string: serverURL)!)
        request.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        request.addValue(SOAPACTION + methodString, forHTTPHeaderField: "SOAPAction")
        request.addValue("\(soapMessage.characters.count)", forHTTPHeaderField: "Content-Length")
        request.httpMethod = "POST"
        request.httpBody = soapMessage.data(using: .utf8)
        
        let defaultSession = URLSession(configuration: .default)
        let dataTask = defaultSession.dataTask(with: request) { (data, response, error) in
            print("Data \(data)")
            print("response \(response)")
            print("Error \(error)")
        }
        dataTask.resume()
    }

}
