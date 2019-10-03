//
//  NetworkConstants.swift
//  bnetTestApp
//
//  Created by Dzhek on 30/09/2019.
//  Copyright © 2019 Dzhek. All rights reserved.
//

import Foundation

//MARK: - • Struct

struct NetworkConstants {
    
    //MARK: • Properties
    
    static let boundary = UUID().uuidString
    static var endPoint = "https://bnet.i-partner.ru/testAPI/"
    static var contentHeader: (fieldName:String, value:String) {
        return (fieldName: "Content-Type", value: "multipart/form-data; boundary=\(self.boundary)")
    }
    static let tokenHeader = (fieldName: "token", value: "***") // get your token at https://bnet.i-partner.ru/testAPI/?a=request_token
    
}

//MARK: - • Enum

enum HTTPMethods: String {
    case post = "POST"
    
}
