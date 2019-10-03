//
//  EditorViewController.swift
//  bnetTestApp
//
//  Created by Dzhek on 25/09/2019.
//  Copyright © 2019 Dzhek. All rights reserved.
//

import UIKit

//MARK: - • Class

class AddViewController: UIViewController, UITextViewDelegate {
    
    //MARK: • IBOutlets & Properties
    
    @IBOutlet weak var contentTextView: UITextView!
    private var cancelButton: UIBarButtonItem?
    private var saveButton: UIBarButtonItem?
    private var keyboardDismissTapGesture: UIGestureRecognizer?
    weak var delegate: AddViewControllerDelegate?

    
    //MARK: - • LiveCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.launchObserverKeyboard()
        self.contentTextView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    
    //MARK: - • Methods
    
    private func setupView() {
        self.title = InterfaceItem.editorTitle
        self.cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                            target: self,
                                            action: #selector(doCancel))
        self.navigationItem.leftBarButtonItem = self.cancelButton
        self.saveButton = UIBarButtonItem(barButtonSystemItem: .save,
                                          target: self,
                                          action: #selector(doSave))
        self.navigationItem.rightBarButtonItem = self.saveButton
        
        self.view.backgroundColor = PaletteUI.backgroundColor
        
        self.contentTextView.font = UIFont.systemFont(ofSize: SizesUI.font)
        self.contentTextView.textColor = PaletteUI.primaryColor
    }
    
    @objc private func doCancel() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func doSave() {
        if !self.contentTextView.text.isEmpty {
            let content = self.contentTextView.text!
            let trimmedContent = content.trimmingCharacters(in: .whitespacesAndNewlines)
            delegate?.editingDidSave(self, save: trimmedContent)
        }
        
    }
    
    
    // MARK: - • TextView & Keyboard
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.addTapGestureRecognizer()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.dismissKeyboard()
    }
    
    private func launchObserverKeyboard() {
        let nc = NotificationCenter.default
        nc.addObserver(self,
                       selector: #selector(keyboardWillShow),
                       name: UIResponder.keyboardWillShowNotification,
                       object: nil)
        nc.addObserver(self,
                       selector: #selector(keyboardWillHide),
                       name: UIResponder.keyboardWillHideNotification,
                       object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let key = UIResponder.keyboardFrameEndUserInfoKey
        guard let frameValue = notification.userInfo?[key] as? NSValue
            else { return }
        let frame = frameValue.cgRectValue
        self.contentTextView.contentInset.bottom = frame.size.height
        self.contentTextView.scrollIndicatorInsets.bottom = frame.size.height
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        self.contentTextView.contentInset.bottom = 0
        self.contentTextView.scrollIndicatorInsets.bottom = 0
    }
    
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
        self.removeGestureRecognizer()
    }
    
    private func addTapGestureRecognizer() {
        if self.keyboardDismissTapGesture == nil {
            self.keyboardDismissTapGesture = UITapGestureRecognizer(target: self,
                                                                    action: #selector(dismissKeyboard))
            self.keyboardDismissTapGesture!.cancelsTouchesInView = false
            self.view.addGestureRecognizer(self.keyboardDismissTapGesture!)
        }
    }
    
    private func removeGestureRecognizer() {
        if self.keyboardDismissTapGesture != nil {
            self.view.removeGestureRecognizer(self.keyboardDismissTapGesture!)
            self.keyboardDismissTapGesture = nil
        }
    }

}

// MARK: - • Protocol

protocol AddViewControllerDelegate: class {
    func editingDidSave(_ controller: AddViewController, save content: String)
}
