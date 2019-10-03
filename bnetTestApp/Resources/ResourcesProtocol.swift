//
//  ResourcesProtocol.swift
//  bnetTestApp
//
//  Created by Dzhek on 30/09/2019.
//  Copyright © 2019 Dzhek. All rights reserved.
//

import Foundation

//MARK: - • Protocol

protocol ResourcesProtocol {

    //MARK: • Properties
    
    var list: [Entry] { get }
    
    //MARK: - • Methods
    
    func fetchSessionID(_ completion: @escaping (_ result: Result<String>) -> Void)
    func fetchEntries(_ completion: @escaping (_ result: Result<[Entry]>) -> Void)
    func addNewEnrty(with content: String, _ completion: @escaping (_ result: Result<String>) -> Void)
}

