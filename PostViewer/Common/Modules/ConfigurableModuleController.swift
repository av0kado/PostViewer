//
//  ConfigurableModuleController.swift
//  Portable
//

protocol ConfigurableModuleController: class {
    
    /// Setup module
    ///
    /// - Parameter object: object with data
    func configureModule(with object: Any)
}
