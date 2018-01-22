//
//  NSLayoutConstraint+SetMultiplier.swift
//  Portable
//

import UIKit

extension NSLayoutConstraint {
    
    func setMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint? {
        
        guard let firstItem = firstItem else {
            return nil
        }
        
        isActive = false
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        
        newConstraint.isActive = true
        return newConstraint
    }
}
