//
//  String+Localized.swift
//  Portable
//

import Foundation

extension String {
    
    func localized() -> String {
        let result = NSLocalizedString(self, comment: "")
        return result
    }
}
