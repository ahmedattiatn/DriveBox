//
//  DriveFilesViewController.swift
//  ODriveBox
//
//  Created by Ahmed ATIA on 05/01/2019.
//  Copyright © 2019 Ahmed ATIA. All rights reserved.
//

import UIKit

class DriveFilesViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var driveFilesTableView: UITableView!
    @IBOutlet weak var backBarButton: UIBarButtonItem!
    @IBOutlet weak var loaderIndicator: UIActivityIndicatorView!
    
    // MARK: - Proprities
    var listParentID = [String]()
    var mainParentID = String()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updatelFilesFromRemoteWith(mainParentID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showOrHideBackBarItem()
    }
    
    // MARK: - User Action
    @IBAction func goBackToParentDir(_ sender: Any) {
        displayPreviousContent()
        showOrHideBackBarItem()
    }
    
    // MARK: - Methods
    func updatelFilesFromRemoteWith(_ id: String) {
        File.fetchFilesFromDrive(withParent: id){ (success,error) in
            if success {
                print("Fetching Files Data With Success...")
                self.driveFilesTableView.isHidden = false
                //Refresh the TableView with the new Content
                self.driveFilesTableView.reloadData()
            }else{
                if let error = error {
                    print("Failure while Fetching Files Data Data...",error)
                    // Display a Custom View when no data Found
                    self.driveFilesTableView.isHidden = true
                }
            }
            self.loaderIndicator.stopAnimating()
        }
    }
    
    func showOrHideBackBarItem() {
        if listParentID.isEmpty {
            self.backBarButton.isEnabled = false
            self.backBarButton.tintColor = .clear
        }
        else {
            self.backBarButton.isEnabled = true
            self.backBarButton.tintColor = .white
        }
    }
    
    private func displayPreviousContent() {
        // LiFO :last in first out
        if !listParentID.isEmpty, let id = listParentID.last {
            listParentID.removeLast()
            updatelFilesFromRemoteWith(id)
        }
    }
}

