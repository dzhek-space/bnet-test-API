//
//  MessageFooterView.swift
//  bnetTestApp
//
//  Created by Dzhek on 01/10/2019.
//  Copyright © 2019 Dzhek. All rights reserved.
//

import UIKit

//MARK: - • Class

class MessageFooterView: UIView {
    
    //MARK: • Properties
    
    var infoLabel = UILabel()
    private let inset: CGFloat = SizesUI.inset
    private let background = PaletteUI.backgroundColor
    
    
    //MARK: - • Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setNeedsUpdateConstraints()
        self.setupViews()
    }
    
    private func setupViews() {
        self.backgroundColor = self.background
        
        self.infoLabel.textColor = PaletteUI.primaryColor
        self.infoLabel.textAlignment = .center
        self.infoLabel.numberOfLines = 0
        
        self.addSubview(infoLabel)
        self.infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.infoLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: inset * 3),
            self.infoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            self.infoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            ])
        
    }
    
}

