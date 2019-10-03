//
//  ErrorFooterView.swift
//  bnetTestApp
//
//  Created by Dzhek on 01/10/2019.
//  Copyright © 2019 Dzhek. All rights reserved.
//

import UIKit

//MARK: - • Class

class ErrorFooterView: UIView {
    
    //MARK: • Properties

    var infoLabel = UILabel()
    private var button = UIButton(type: .roundedRect)
    private let inset: CGFloat = SizesUI.inset
    private let background = PaletteUI.backgroundColor
    
    
    //MARK: - • Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupViews()
    }
    
    private func setupViews() {
        self.backgroundColor = background
        
        self.infoLabel.textColor = PaletteUI.primaryColor
        self.infoLabel.textAlignment = .center
        self.infoLabel.numberOfLines = 0
        
        self.button.setTitle(InterfaceItem.buttonText, for: .normal)
        self.button.backgroundColor = .white
        self.button.layer.cornerRadius = self.button.frame.height / 2
        
        self.addSubview(infoLabel)
        self.addSubview(button)
        self.infoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.infoLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: inset * 3),
            self.infoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            self.infoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            
            self.button.heightAnchor.constraint(equalToConstant: inset * 2.5),
            self.button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset * 2),
            self.button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset * 2),
            self.button.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor, constant: -self.frame.height / 4),
            ])
    }

}
