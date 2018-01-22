//
//  StoryboardsFactory.swift
//  Portable
//

import UIKit

protocol StoryboardsFactory {
    func getStoryboard(with name: StoryboardName) -> UIStoryboard
}

enum StoryboardName: String {
    case splashScreen               = "SplashScreen"
    case authorization              = "Authorization"
    case posts                      = "Posts"
}

enum ModuleName: String {
    case postsList                  = "PostsList"
    case postDetail                 = "PostDetail"
}

extension UIStoryboard {
    
    func instantiateViewController(with moduleName: ModuleName) -> UIViewController {
        return instantiateViewController(withIdentifier: moduleName.rawValue)
    }
}
