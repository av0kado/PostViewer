//
//  CommonAlertsFactoryImplementation.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 21/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import UIKit

class CommonAlertsFactoryImplementation: CommonAlertsFactory {

    // MARK: - CommonAlertsFactory
    
    func buildAlert(with title: String) -> UIViewController {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: StringsHelper.string(for: .commonAlertOKButtonTitle), style: .cancel, handler: nil)
        alertController.addAction(okAction)
        
        return alertController
    }
}
