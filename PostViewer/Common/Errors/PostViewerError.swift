//
//  PostViewerError.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 22/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import Foundation

/// Custom error
enum PostViewerError: Error {
    
    // Authorization cancelled
    case authorizationCancelled
    
    // Authorization error; maybe unauthorized
    case notAuthorized
    
    // Serialization error
    case serializationError
    
    // Unknown error
    case unknownError
    
    var localizedDescription: String {
        var response: StringsHelper.StringKey
        
        switch self {
        case .authorizationCancelled:
            response = .PVErrorAuthorizationCancelled
        case .notAuthorized:
            response = .PVErrorNotAuthorized
        case .serializationError:
            response = .PVSerializationError
        case .unknownError:
            response = .PVUnknownError
        }
        
        return StringsHelper.string(for: response)
    }
}
