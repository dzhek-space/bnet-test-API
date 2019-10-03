//
//  Entry.swift
//  bnetTestApp
//
//  Created by Dzhek on 24/09/2019.
//  Copyright © 2019 Dzhek. All rights reserved.
//

import Foundation

//MARK: - • Struct

struct Entry: Decodable {
    
    //MARK: • Properties
    
    let id, content, createdAt, lastEdit: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case content = "body"
        case createdAt = "da"
        case lastEdit = "dm"
    }
    
    //MARK: - • Methods
    
    init(id: String,
         content: String,
         createdAt: String,
         lastEdit: String) {
        self.id = id
        self.content = content
        self.createdAt = createdAt
        self.lastEdit = lastEdit
    }
    
}
