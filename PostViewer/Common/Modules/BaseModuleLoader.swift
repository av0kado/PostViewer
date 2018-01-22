//
//  BaseModuleLoader.swift
//  Portable
//

import UIKit

/// Base class for loading modules
class BaseModuleLoader: BaseModuleConfigurator {
    
    /// Load and configure module
    ///
    /// - Returns: configured view controller
    func loadAndConfigureModule() -> UIViewController {
        
        let controller = loadModuleViewController()
        viewController = controller
        
        configureModule(for: viewController)
        finishModuleConfiguration(for: viewController)
        
        return controller
    }
    
    /// Load view controller of module
    ///
    /// - Returns: loaded view controller of module
    func loadModuleViewController() -> UIViewController {
        return UIViewController()
    }
}
