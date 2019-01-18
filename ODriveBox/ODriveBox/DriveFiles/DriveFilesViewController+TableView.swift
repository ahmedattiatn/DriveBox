
//
//  DriveFilesViewController+TableView.swift
//  ODriveBox
//
//  Created by Ahmed ATIA on 05/01/2019.
//  Copyright © 2019 Ahmed ATIA. All rights reserved.
//

import UIKit

extension DriveFilesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellDrive = tableView.dequeueReusableCell(withIdentifier: UtilityCellID.cellDriveFile.rawValue, for: indexPath) as! DriveFilesTableViewCell
        cellDrive.updateGraphicElementsOfOffer(File.DriveFiles[indexPath.row])
        return cellDrive
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return File.DriveFiles.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        displayContenFromCurrentDirWith(indexPath)
    }
    
    func displayContenFromCurrentDirWith(_ indexPath: IndexPath) {
        let currentFile = File.DriveFiles[indexPath.row]
        if currentFile.isDir {
            updatelFilesFromRemoteWith(currentFile.id)
            // save the Current parent ID in the List so we can navigate Back
            listParentID.append(currentFile.parentId)
            showOrHideBackBarItem()
            animateDriveFilesTableView()
            
        }
    }
    
    func animateDriveFilesTableView() {
        driveFilesTableView.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.driveFilesTableView.alpha = 1
        }
    }
}
