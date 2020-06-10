//
//  PresenterViewProtocol.swift
//  bnetTestApp
//
//  Created by Dzhek on 25/09/2019.
//  Copyright © 2019 Dzhek. All rights reserved.
//

import Foundation

typealias EntryContent = (String, String)

//MARK: - • Protocol

protocol PresenterViewProtocol {
    var listContent: [EntryContent] { get }
    func takeEntries()
    func prepareFullEntry(with index: Int) -> EntryContent
    func addEntry(with content: String)
    
}

