//
//  SwiftyVKTask+Cancelable.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import SwiftyVK

class SwiftyVKCancelableTask: CancelableRequest {
    
    private var task: Task
    
    init(_ task: Task) {
        self.task = task
    }
    
    // MARK: - CancelableRequest
    
    func cancel() {
        task.cancel()
    }
}
