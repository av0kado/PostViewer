//
//  BaseModuleConfigurator.swift
//  Portable
//

import UIKit

class BaseModuleConfigurator: NSObject {
    
    @IBOutlet weak var viewController: UIViewController!
    
    override func awakeFromNib() {
        configureModule(for: viewController)
        finishModuleConfiguration(for: viewController)
    }
    
    
    /// Configure module. Can be overridden in subclasses
    ///
    /// - Parameter view: view controller that's module is being configurated
    func configureModule(for view: UIViewController) {
    }
    
    /// Finish configuration of module
    ///
    /// - Parameter view: controller that's module was configured
    func finishModuleConfiguration(for view: UIViewController) {
        view.didFinishModuleConfiguration()
    }
}

extension UIViewController {
    
    /// Callback that configuration of module is being completed
    func didFinishModuleConfiguration() {
        
    }
}
