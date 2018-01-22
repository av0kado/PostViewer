//
//  ErrorIsCancelled.swift
//  Portable
//

import Foundation

extension Error {
    var isCancelled: Bool {
        get {
            let nsError = self as NSError
            return nsError.code == NSURLErrorCancelled
        }
    }
}
