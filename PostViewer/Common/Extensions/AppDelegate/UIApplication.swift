//
//  UIApplication.swift
//  Portable
//

import UIKit

extension UIApplication {
    static var appDelegate: AppDelegate { get { return (UIApplication.shared.delegate as! AppDelegate) } }
}
