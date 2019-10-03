//
//  ViewController.swift
//  bnetTestApp
//
//  Created by Dzhek on 24/09/2019.
//  Copyright © 2019 Dzhek. All rights reserved.
//

import UIKit

//MARK: - • Class

class TableViewController: UITableViewController {
    
    //MARK: • Properties
    
    var presenter: PresenterViewProtocol?
    private var addButton: UIBarButtonItem?
    var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var messageFooterView: MessageFooterView!
    
    //MARK: - • LiveCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = Presenter(resorces: Resources(),
                                   view: self)
        self.setupView()
        self.presenter?.takeEntries()
    }
    
    //MARK: - • Methods
    
    private func setupView() {
        self.title = InterfaceItem.tableTitle
        self.addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                          target: self,
                                          action: #selector(doAdd))
        self.navigationItem.rightBarButtonItem = self.addButton
        
        self.tableView.estimatedRowHeight = 64
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.backgroundColor = PaletteUI.backgroundColor
        
        activityIndicatorView = UIActivityIndicatorView(style: .gray)
        self.activityIndicatorView.backgroundColor = PaletteUI.backgroundColor
        tableView.backgroundView = activityIndicatorView
        
        self.messageFooterView.frame.size.width = self.view.frame.width
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        let navigationBarHeight = (self.navigationController?.navigationBar.frame.height)!
        self.messageFooterView.frame.size.height = self.view.frame.height - navigationBarHeight - statusBarHeight
        self.tableView.tableFooterView = UIView()
    }
    
    private func configureView(for cell: UITableViewCell) {
        cell.textLabel?.textColor = PaletteUI.primaryColor
        cell.textLabel?.numberOfLines = 0
        
        cell.detailTextLabel?.textColor = PaletteUI.secondaryColor
        cell.detailTextLabel?.numberOfLines = 2
    }
    
    @objc private func doAdd() {
        self.performSegue(withIdentifier: CodeItem.addSegue, sender: self.addButton)
    }
    
//    private func hideLoader
    
    private func showMessage(_ message: String, _ action: (() -> Void)? = nil) {
        let messageVC = MessageViewController()
        messageVC.infoLabel.text = message
        messageVC.didTapButton = action
        messageVC.modalTransitionStyle = .crossDissolve
        messageVC.modalPresentationStyle = .overCurrentContext
        self.present(messageVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let number = self.presenter?.listContent.count
            else { return 0 }
        return number
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let cell = tableView.dequeueReusableCell(withIdentifier: CodeItem.cellId, for: indexPath)
        self.configureView(for: cell)
        if let shortEntry = self.presenter?.listContent[indexPath.row] {
            cell.textLabel?.text = shortEntry.0
            cell.detailTextLabel?.text = shortEntry.1
        }
        return cell
        
    }
    
    
    // MARK: - • Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case CodeItem.detailSegue:
            if let controller = segue.destination as? PreviewViewController {
                guard let index = tableView.indexPathForSelectedRow?[1]
                    else { return }
                guard let entry = self.presenter?.prepareFullEntry(with: index)
                    else { return }
                controller.content = entry
            }
        case CodeItem.addSegue:
            if let controller = segue.destination as? AddViewController {
                controller.delegate = self
            }
        default:
            return
        }
    }
}

//MARK: - • Protocol Implementation

extension TableViewController: AddViewControllerDelegate {
    func editingDidSave(_ controller: AddViewController, save content: String) {
        self.presenter?.addEntry(with: content)
        self.navigationController?.popViewController(animated: true)
    }
}

extension TableViewController: TableViewProtocol {
    
    func showLoader() {
        activityIndicatorView.startAnimating()
    }
    
    func updateViews(as tableState: TableState, message: String) {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.hidesWhenStopped = true
        switch tableState {
        case .empty:
            self.tableView.tableFooterView = nil
            self.messageFooterView.infoLabel.text = message
            self.tableView.tableFooterView = self.messageFooterView
        case .list:
            self.tableView.tableFooterView = UIView()
            if let index = Int(message), self.tableView.numberOfRows(inSection: 0) > 0 {
                let indexPath = IndexPath(row: index, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                self.tableView.insertRows(at: [indexPath], with: .fade)
            } else {
                self.tableView.reloadData()
            }
        case .error:
            self.showMessage(message) {
                self.presenter?.takeEntries()
            }
            self.tableView.tableFooterView = UIView()
            self.tableView.reloadData()
        }
    }

}
