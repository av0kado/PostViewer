//
//  VKWorkerImplementation.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import UIKit

class VKWorkerImplementation: VKWorker, VKDelegateOutput {
    
    private var delegate: VKDelegate!
    
    init() {
        delegate = VKDelegate()
        delegate.output = self
    }
    
    // MARK: - VKWorker
    
    static var `default`: VKWorker = VKWorkerImplementation()
    
    // MARK: - VKDelegateOutput
    
    func vkWantsToPresentController(_ controller: UIViewController) {
        
        DispatchQueue.main.async {
            if let rootController = UIApplication.shared.keyWindow?.rootViewController {
                rootController.present(controller, animated: true)
            }
        }
    }
}
