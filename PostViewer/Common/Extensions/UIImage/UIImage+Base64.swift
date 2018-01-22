//
//  UIImage+Base64.swift
//  Portable
//

import UIKit

extension UIImage {
    
    static func fromBase64String(_ base64String: String) -> UIImage? {
        let dataDecoded: Data = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters)!
        let decodedImage = UIImage(data: dataDecoded)
        return decodedImage
    }
    
    func base64String() -> String {
        let data = UIImagePNGRepresentation(self)
        let base64String = data!.base64EncodedString()
        return base64String
    }
}
