//
//  Result.swift
//  bnetTestApp
//
//  Created by Dzhek on 01/10/2019.
//  Copyright © 2019 Dzhek. All rights reserved.
//

import Foundation

//MARK: - • Result

enum Result<T> {
    case success(T)
    case failure(Error)
    
}
