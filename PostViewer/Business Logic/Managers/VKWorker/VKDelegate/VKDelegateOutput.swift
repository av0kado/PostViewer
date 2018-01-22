//
//  VKDelegateOutput.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import UIKit

protocol VKDelegateOutput: class {
    func vkWantsToPresentController(_ controller: UIViewController)
}
