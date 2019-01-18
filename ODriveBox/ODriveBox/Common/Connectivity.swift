//
//  Connectivity.swift
//  ODriveBox
//
//  Created by Ahmed ATIA on 05/01/2019.
//  Copyright © 2019 Ahmed ATIA. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Types
public typealias SaveCompletion = (success : Bool, error: Error?)

// MARK: - Enum
enum ErrorStatus : Error {
    case notFound
    case network
    case none
}

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
