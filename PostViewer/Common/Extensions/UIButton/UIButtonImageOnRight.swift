//
//  UIButtonImageOnRight.swift
//  Portable
//

import UIKit

extension UIButton {
    @IBInspectable var isImageOnRight: Bool {
        get {
            if transform.tx != -1.0 {
                return false
            } else {
                if let titleLabel = titleLabel {
                    if titleLabel.transform.tx != -1.0 {
                        return false
                    }
                }
                if let imageView = imageView {
                    if imageView.transform.tx != -1.0 {
                        return false
                    }
                }
            }
            return true
        }
        set {
            transform = newValue ? CGAffineTransform(scaleX: -1.0, y: 1.0) : CGAffineTransform(scaleX: 1.0, y: 1.0)
            titleLabel?.transform = newValue ? CGAffineTransform(scaleX: -1.0, y: 1.0) : CGAffineTransform(scaleX: 1.0, y: 1.0)
            imageView?.transform = newValue ? CGAffineTransform(scaleX: -1.0, y: 1.0) : CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
}
