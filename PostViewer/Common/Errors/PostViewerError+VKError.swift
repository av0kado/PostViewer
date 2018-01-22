//
//  PostViewerError+VKError.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 22/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import SwiftyVK

// MARK: - Extension to support SwiftyVK
extension PostViewerError {
    init(vkError: VKError) {
        switch vkError {
        case .authorizationCancelled:
            self = .authorizationCancelled
        case .authorizationDenied, .authorizationFailed:
            self = .notAuthorized
        default:
            self = .unknownError
        }
    }
}
