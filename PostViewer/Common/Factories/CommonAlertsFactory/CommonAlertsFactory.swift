//
//  CommonAlertsFactory.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 21/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import UIKit

protocol CommonAlertsFactory {

    func buildAlert(with title: String) -> UIViewController
}
