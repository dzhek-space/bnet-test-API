//
//  BnetResponse.swift
//  bnetTestApp
//
//  Created by Dzhek on 30/09/2019.
//  Copyright © 2019 Dzhek. All rights reserved.
//

import Foundation

//MARK: - • Struct

struct BnetResponse<T: Decodable>: Decodable {
    
    //MARK: • Properties
    
    let status: Int
    let data: T?
    let error: String?
    
}
