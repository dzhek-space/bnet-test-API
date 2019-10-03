//
//  AddEntry.swift
//  bnetTestApp
//
//  Created by Dzhek on 30/09/2019.
//  Copyright © 2019 Dzhek. All rights reserved.
//

import Foundation

//MARK: - • Class

class AddEntry: NetworkRequestProtocol {
    
    typealias ModelType = ServiceData
    
    
    //MARK: • Properties
    
    var parameters: [String : String]
    
    
    //MARK: - • Methods
    
    init(with parameters: [String : String]) {
        self.parameters = parameters
    }
    
    func upload(withCompletion completion: @escaping TaskCompletionHandler) {
        self.uploadResume(with: parameters, withCompletion: completion)
    }
}
