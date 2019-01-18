//
//  Utility.swift
//  ODriveBox
//
//  Created by Ahmed ATIA on 05/01/2019.
//  Copyright © 2019 Ahmed ATIA. All rights reserved.
//

import Foundation

// MARK: - CellsID
enum UtilityCellID : String {
    case cellDriveFile = "DriveFilesCell"
}

// MARK: - LinksID
enum Utilitylink : String {
    //Link For Debug
    case  basicDebugLink = "http://noel:foobar@localhost:8080/"
    //In case we have more than one Target we put here the basic link for release or staging...
}

// MARK: - USerDefaultKeys
enum UtilityUserDefaultKey : String {
    case mainDriveID = "DriveID"
}

enum UtilitySegueId : String {
    case driveFiles = "driveFilesSegue"
}
