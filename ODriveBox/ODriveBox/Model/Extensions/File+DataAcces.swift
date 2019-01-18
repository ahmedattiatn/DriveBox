//
//  File+DataAcces.swift
//  ODriveBox
//
//  Created by Ahmed ATIA on 05/01/2019.
//  Copyright © 2019 Ahmed ATIA. All rights reserved.
//

import Foundation
import SwiftyJSON

extension File {
    
    static func saveMainDirData(_ results: JSON, completion: @escaping (SaveCompletion) -> Void) {
        guard  let responseJSON = JSON(results).dictionaryObject,let rootItem = responseJSON[FilesKey.rootItem.rawValue] as? [String : Any] else {
            completion(SaveCompletion(false, ErrorStatus.none))
            return
        }
        UserDefaults.standard.set(rootItem[FilesKey.id.rawValue], forKey: UtilityUserDefaultKey.mainDriveID.rawValue)
        completion(SaveCompletion(true, error: nil))
    }
    
    static func updateLocalDataFilesFromDrive(_ results: JSON, completion: @escaping (SaveCompletion) -> Void) {
        guard  let responseJSON = JSON(results).arrayObject else {
            completion(SaveCompletion(false, ErrorStatus.none))
            return
        }
        DriveFiles.removeAll()
        for file in responseJSON {
            File.DriveFiles.append(File(file as! [String : Any]))
        }
        completion(SaveCompletion(true, error: nil))
    }
    
}
