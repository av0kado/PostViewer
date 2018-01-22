//
//  AuthorizationInteractorOutput.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

protocol AuthorizationInteractorOutput: class {

    /// User did finish VK authorization
    ///
    /// - Parameter result: authorization result
    func didFinishAuthorization(with result: VKAuthorizationResult)
}
