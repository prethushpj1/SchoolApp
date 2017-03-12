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
    fileprivate let SOAPACTION          = "http://tempuri.org/IVTP/"
    fileprivate let serverURL           = "http://betnbid.mobi/IDWCF/VTop.svc"
    
    fileprivate func createSOAPBody(WithMethodName method: String, andParameters parameters:SoapParameters?) -> String{
        var parameterXML = ""
        if let urParameters = parameters, let keyValueDict = urParameters.getParameters(){
            for (key, value) in keyValueDict {
                parameterXML += "<\(key)>\(value)</\(key)>"
            }
        }
        
        let bodyXML = "<\(method)>" + parameterXML + "</\(method)>"
        
        let soapMessage = "<?xml version=\"1.0\" encoding=\"utf-8\"?>" +
        "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">" +
        "<soap:Body>" +
        "<\(method) xmlns=\"\(NAMESPACE)\">" +
        "\(bodyXML)" +
        "</\(method)>" +
        "</soap:Body>" +
        "</soap:Envelope>"
        return soapMessage
    }
    
    fileprivate func xmlEncode(Request request: String) -> String{
        var encodedRequest =  request.replacingOccurrences(of: "&", with: "&amp;")
        encodedRequest = encodedRequest.replacingOccurrences(of: "<", with: "&lt;")
        encodedRequest = encodedRequest.replacingOccurrences(of: ">", with: "&gt;")
        return encodedRequest
    }
    
    func makeRequest(ForMethod method: String, andParameters parameters:SoapParameters?){
        var soapMessage = self.createSOAPBody(WithMethodName: method, andParameters: parameters)
        soapMessage = self.xmlEncode(Request: soapMessage)
        
        var request = URLRequest(url: URL(string: serverURL)!)
        request.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        request.addValue(SOAPACTION + method, forHTTPHeaderField: "SOAPAction")
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
