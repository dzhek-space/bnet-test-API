//
//  TableViewProtocol.swift
//  bnetTestApp
//
//  Created by Dzhek on 30/09/2019.
//  Copyright © 2019 Dzhek. All rights reserved.
//

import Foundation

//MARK: - • Protocol

protocol TableViewProtocol: class {
    
    func showLoader()
    func updateViews(as tableState: TableState, message: String)
    
}
