//
//  PreviewViewController.swift
//  bnetTestApp
//
//  Created by Dzhek on 25/09/2019.
//  Copyright © 2019 Dzhek. All rights reserved.
//

import UIKit

//MARK: - • Class

class PreviewViewController: UIViewController {
    
    //MARK: • IBOutlets & Properties

    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var content: EntryContent = ("","")
    
    
    //MARK: - • LiveCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLabelStyle()
        self.assignDataForLabel()
    }
    
    
    //MARK: - • Methods
    
    private func setupLabelStyle() {
        self.bodyLabel.font = UIFont.systemFont(ofSize: SizesUI.font)
        self.bodyLabel.textColor = PaletteUI.primaryColor
        
        self.dateLabel.font = UIFont.systemFont(ofSize: SizesUI.font * SizesUI.coefficient)
        self.dateLabel.textColor = PaletteUI.secondaryColor
    }
    
    private func assignDataForLabel() {
        self.bodyLabel.text = self.content.0
        self.dateLabel.text = self.content.1
    }
}
