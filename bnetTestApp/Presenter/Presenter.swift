//
//  Presenter.swift
//  bnetTestApp
//
//  Created by Dzhek on 24/09/2019.
//  Copyright © 2019 Dzhek. All rights reserved.
//

import Foundation

//MARK: - • Class

class Presenter {
    
    //MARK: • Properties
    
    private weak var view: TableViewProtocol?
    private var resorces: ResourcesProtocol
    
    var listContent: [EntryContent] = []
    private var newEntry: Entry?
    
    //MARK: - • Methods
    
    init(resorces: ResourcesProtocol,
         view: TableViewProtocol){
        self.resorces = resorces
        self.view = view
    }
    
    private func createListContent(from entries: [Entry]) {
        for entry in entries {
            let cellContent = prepareCellContent(from: entry)
            self.listContent.append(cellContent)
        }
    }
    
    private func prepareCellContent(from entry: Entry) -> EntryContent {
        let content = entry.content.count > 200 ? self.trimLongContent(entry.content) : entry.content
        let dateString = self.prepareDate(for: entry)
        return (content, dateString)
    }
    
    private func prepareDate(for entry: Entry) -> String {
        
        let interval = Double(entry.createdAt)!
        let localDate = interval.asStringLocalDate(local: CodeItem.locale)
        var resultString = "Created at: \(localDate)"
        
        if entry.lastEdit != entry.createdAt {
            let interval = Double(entry.lastEdit)!
            let modificationDate = interval.asStringLocalDate(local: CodeItem.locale)
            let separator = "\n"
            resultString.append("\(separator)Last edited: \(modificationDate)")
        }
        
        return resultString
    }
    
    private func trimLongContent(_ content: String) -> String {
        let index = content.index(content.startIndex, offsetBy: 196)
        var shortEntryBody = String(content[...index])
        shortEntryBody.append("...")
        return shortEntryBody
    }
    
}

//MARK: - • Protocol Implementation

extension Presenter: PresenterViewProtocol {
    
    func takeEntries() {
        self.view?.showLoader()
        self.resorces.fetchSessionID { result in
            switch result {
            case .success(_):
                self.resorces.fetchEntries({ result in
                    switch result {
                    case .success(let entries):
                        self.createListContent(from: entries)
                        let tableState: TableState = entries.isEmpty ? .empty : .list
                        let message: String = tableState == .empty ? InterfaceItem.massageText : ""
                        self.view?.updateViews(as: tableState, message: message)
                    case .failure(let error):
                        let message = (error as! APIError).customDescription
                        self.view?.updateViews(as: .error, message: message)
                    }
                })
            case .failure(let error):
                let message = (error as! APIError).customDescription
                self.view?.updateViews(as: .error, message: message)
            }
        }

    }
    
    func prepareFullEntry(with index: Int) -> EntryContent {
        let entry = self.resorces.list[index]
        let content = entry.content
        let dateString = self.prepareDate(for: entry)
        return (content, dateString)
    }
    
    func addEntry(with content: String) {
        self.view?.showLoader()
        self.resorces.addNewEnrty(with: content) { result in
            switch result {
            case .success(let entryID):
                self.resorces.fetchEntries({ result in
                    switch result {
                    case .success(let entries):
                        guard let index = entries.firstIndex(where: { $0.id == entryID })
                            else { return }
                        let shortEntry = self.prepareCellContent(from: entries[index])
                        self.listContent.insert(shortEntry, at: index)
                        self.view?.updateViews(as: .list, message: String(index))
                    case .failure(let error):
                        let message = (error as! APIError).customDescription
                        self.view?.updateViews(as: .error, message: message)
                    }
                })
            case .failure(let error):
                self.listContent = []
                let message = (error as! APIError).customDescription
                self.view?.updateViews(as: .error, message: message)
            }
        }
    }
    
    
}

