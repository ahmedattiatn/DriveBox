//
//  File.swift
//  ODriveBox
//
//  Created by Ahmed ATIA on 05/01/2019.
//  Copyright © 2019 Ahmed ATIA. All rights reserved.
//

import Foundation

class File {
    
    static var DriveFiles = [File]()
    var id: String
    var parentId: String
    var isDir: Bool
    var modificationDate: String
    var size: Int
    var name: String
    var contentType: String
    
    init(_ dictionary: [String: Any]) {
        self.id = dictionary[FilesKey.id.rawValue] as! String
        self.parentId = dictionary[FilesKey.parentId.rawValue] as? String ?? ""
        self.isDir = dictionary[FilesKey.isDir.rawValue] as? Bool ?? false
        self.modificationDate = dictionary[FilesKey.modificationDate.rawValue] as! String
        self.size = dictionary[FilesKey.size.rawValue] as? Int ?? 0
        self.name = dictionary[FilesKey.name.rawValue] as! String
        self.contentType = dictionary[FilesKey.contentType.rawValue] as? String ?? ""
    }
}

enum FilesKey : String {
    case id = "id"
    case parentId = "parentId"
    case isDir = "isDir"
    case modificationDate = "modificationDate"
    case size = "size"
    case name = "name"
    case contentType = "contentType"
    case rootItem = "rootItem"
}


