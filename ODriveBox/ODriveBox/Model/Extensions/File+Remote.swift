//
//  File+Remote.swift
//  ODriveBox
//
//  Created by Ahmed ATIA on 05/01/2019.
//  Copyright © 2019 Ahmed ATIA. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension File {
    
    static  func fetchFilesFromDrive(withParent id: String? = nil, completion: @escaping (SaveCompletion) -> Void) {
        // Check for connectivity
        if !Connectivity.isConnectedToInternet() {
            completion(SaveCompletion(false, ErrorStatus.network))
        }
        // Prepare the Link using The ID
        // ID == nil : mean that we don't have the id of the Parent
        var link : String
        if let fileId = id {
            link = DataLinks.FILES_URL + fileId
        }
        else {
            link  = DataLinks.PARENT_DIR_URL
        }
        print("link --> ",link)
        // Request for data using Get Method
        Alamofire.request(
            URL(string: link)!,
            method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    // in case of failure
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    if let statusCode = response.response?.statusCode {
                        if statusCode == 404 {
                            /* 404 Not Found -- The server can not find requested resource (Files) */
                            completion(SaveCompletion(false, ErrorStatus.notFound))
                        }
                    }
                    /* Could not connect to the server */
                    completion(SaveCompletion(false, ErrorStatus.network))
                    return
                }
                // get responseData
                guard let responseData = response.result.value else {
                    print("Invalid Files information received from the service")
                    completion(SaveCompletion(false, ErrorStatus.none))
                    return
                }
                print("ResponseData ---> ",responseData)
                // Send Data to Be Parsed And Save
                if let _ = id {
                    File.updateLocalDataFilesFromDrive(JSON(responseData), completion: { (saveCompletion) in
                        completion(saveCompletion)
                    })
                }
                else {
                    File.saveMainDirData(JSON(responseData), completion: { (saveCompletion) in
                        completion(saveCompletion)
                    })
                }
        }
    }
}
