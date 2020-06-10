//
//  Resouces.swift
//  bnetTestApp
//
//  Created by Dzhek on 30/09/2019.
//  Copyright © 2019 Dzhek. All rights reserved.
//

import Foundation

//MARK: - • Class

final class Resources: ResourcesProtocol {

    //MARK: • Properties
    
    var list: [Entry] = []
    var lastAddedEntryID: String?
    
    //MARK: - • Methods
    
    func fetchSessionID(_ completion: @escaping (Result<String>) -> Void) {
        if  let sessionID = UserDefaults.standard.string(forKey: "sessionID") {
            completion(.success(sessionID))
        } else {
            DispatchQueue.global(qos: .default).async {
                let parameters = ["a": "new_session"]
                let newSession = GetNewSessionID(with: parameters)
                newSession.upload { result in
                    switch result {
                    case .success(let response):
                        if response.status == 1, let fetchedSessionID = response.data?.session {
                            UserDefaults.standard.set(fetchedSessionID, forKey: "sessionID")
                            completion(.success(fetchedSessionID))
                        }
                        else if response.status == 0 {
                            completion(.failure(APIError.parameterFailure))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
        
    }

    func fetchEntries( _ completion: @escaping (Result<[Entry]>) -> Void) {
        guard let sessionID = UserDefaults.standard.string(forKey: "sessionID")
            else { return }
        DispatchQueue.global(qos: .default).async {
            let parameters = ["session": sessionID, "a": "get_entries"]
            let getEntries = GetEntries(with: parameters)
            getEntries.upload { result in
                switch result {
                case .success(let response):
                    if response.status == 1, let entries = response.data?[0] {
                        self.list = entries
                        completion(.success(entries))
                    }
                    else if response.status == 0 {
                        completion(.failure(APIError.parameterFailure))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        
    }
    
    func addNewEnrty(with content: String, _ completion: @escaping (Result<String>) -> Void) {
        guard let sessionID = UserDefaults.standard.string(forKey: "sessionID")
            else { return }
        DispatchQueue.global(qos: .default).async {
            let parameters = ["session": sessionID, "a": "add_entry", "body": content]
            let addEntry = AddEntry(with: parameters)
            addEntry.upload { result in
                switch result {
                case .success(let response):
                    if response.status == 1, let enrtryID = response.data?.id {
                        completion(.success(enrtryID))
                    }
                    else if response.status == 0 {
                        completion(.failure(APIError.parameterFailure))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
                
            }
        }
        
    }

}

