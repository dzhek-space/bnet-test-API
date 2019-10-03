//
//  ExtensionDate.swift
//  bnetTestApp
//
//  Created by Dzhek on 01/10/2019.
//  Copyright © 2019 Dzhek. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    func asStringLocalDate(local: String) -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeZone = .current
        dateFormatter.locale = Locale(identifier: local)
        
        let interval = Double(self)
        let date = Date.init(timeIntervalSince1970: interval)
        let localDate = dateFormatter.string(from: date)
        
        return localDate
    }
    
}
