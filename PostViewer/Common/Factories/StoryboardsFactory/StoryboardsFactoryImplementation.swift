//
//  StoryboardsFactoryImplementation.swift
//  Portable
//

import UIKit

class StoryboardsFactoryImplementation: StoryboardsFactory {
    
    func getStoryboard(with name: StoryboardName) -> UIStoryboard {
        return UIStoryboard(name: name.rawValue, bundle: nil)
    }
}
