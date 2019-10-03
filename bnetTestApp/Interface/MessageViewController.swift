//
//  MessageViewController.swift
//  bnetTestApp
//
//  Created by Dzhek on 02/10/2019.
//  Copyright © 2019 Dzhek. All rights reserved.
//

import UIKit

//MARK: - • Class

class MessageViewController: UIViewController {
    
    //MARK: • Properties
    
    private let inset: CGFloat = SizesUI.inset
    private let background = PaletteUI.backgroundColor.cgColor
    private let buttonBorderColor = PaletteUI.secondaryColor.cgColor
    
    var viewContainer = UIView()
    var infoLabel = UILabel()
    var button = UIButton(type: .system)
    var didTapButton: (() -> Void)?
    
    
    //MARK: - • LiveCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        
        self.viewContainer.layer.backgroundColor = background
        self.viewContainer.layer.cornerRadius = self.setCornerRadius()
        self.viewContainer.layer.masksToBounds = true
        
        self.infoLabel.textColor = PaletteUI.primaryColor
        self.infoLabel.textAlignment = .center
        self.infoLabel.numberOfLines = 0
        
        self.button.setTitle(InterfaceItem.buttonText, for: .normal)
        self.button.backgroundColor = .white
        self.button.layer.cornerRadius = self.setCornerRadius() / 2
        self.button.layer.borderWidth = 0.1
        self.button.layer.borderColor = self.buttonBorderColor
        
        if didTapButton == nil {
            self.button.isHidden = true
        } else {
            self.button.addTarget(self, action: #selector(doTapButton), for: .touchUpInside)
        }
    }
    
    
    //MARK: - • Methods
    
    @objc private func doTapButton() {
        self.dismiss(animated: true, completion: self.didTapButton)
    }
    
    private func setupViews() {
        
        self.view.addSubview(viewContainer)
        self.viewContainer.addSubview(infoLabel)
        self.viewContainer.addSubview(button)
        self.viewContainer.translatesAutoresizingMaskIntoConstraints = false
        self.infoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.button.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            self.viewContainer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: inset * 5),
            self.viewContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset * 1.5),
            self.viewContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -inset * 1.5),
            self.viewContainer.bottomAnchor.constraint(greaterThanOrEqualTo: self.view.bottomAnchor, constant: -inset * 1.5),
        
            self.infoLabel.topAnchor.constraint(equalTo: self.viewContainer.topAnchor, constant: inset * 4),
            self.infoLabel.leadingAnchor.constraint(equalTo: self.viewContainer.leadingAnchor, constant: inset),
            self.infoLabel.trailingAnchor.constraint(equalTo: self.viewContainer.trailingAnchor, constant: -inset),
            
            self.button.heightAnchor.constraint(equalToConstant: inset * 2.5),
            self.button.widthAnchor.constraint(equalToConstant: inset * 12 ),
            self.button.centerXAnchor.constraint(equalTo: self.viewContainer.centerXAnchor),
            self.button.bottomAnchor.constraint(greaterThanOrEqualTo: self.viewContainer.bottomAnchor, constant: -inset * 4),
            ])
    }
    
    private func setCornerRadius() -> CGFloat {
        switch UIScreen.main.nativeBounds.height {
        case 1136, 1334, 2208:
            return inset / 2
        default:
            return inset
        }
    }

}
