//
//  AttachmentImage.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import UIKit

/// Model that is post's attachment
class AttachmentImage: ImagesLayoutViewImage {
    
    var image: UIImage? {
        return nil
    }
    
    /// Image text
    var text: String?
    
    /// Image original width
    var width: Int
    
    /// Image original height
    var height: Int
    
    /// Url of image with maximum side size of 75
    var photo75Url: String
    
    /// Url of image with maximum side size of 130
    var photo130Url: String?
    
    /// Url of image with maximum side size of 604
    var photo604Url: String?
    
    /// Url of image with maximum side size of 807
    var photo807Url: String?
    
    /// Url of image with maximum side size of 1280
    var photo1280Url: String?
    
    /// Url of image with maximum side size of 2560
    var photo2560Url: String?
    
    /// Retrieves URL for image with maximum side size set
    func imageUrlString(withMaximumSideSize maximumSideSize: Int) -> String {
        
        let allImages = [photo75Url, photo130Url, photo604Url, photo807Url, photo1280Url, photo2560Url]
        let images = allImages
            .filter { return $0 != nil }
            .map { return $0! }
        
        var index = 0
        
        switch maximumSideSize {
        case 76 ... 130:
            index = 1
        case 131 ... 604:
            index = 2
        case 605 ... 807:
            index = 3
        case 808 ... 1280:
            index = 4
        case 1281...:
            return images.last!
        case ...75:
            fallthrough
        default:
            return photo75Url
        }
        
        index = min(index, images.count - 1)
        return images[index]
    }
    
    init(width: Int, height: Int, photo75Url: String, photo130Url: String?, photo604Url: String?, photo807Url: String?, photo1280Url: String?, photo2560Url: String?, text: String?) {
        self.width = width
        self.height = height
        self.photo75Url = photo75Url
        self.photo130Url = photo130Url
        self.photo604Url = photo604Url
        self.photo807Url = photo807Url
        self.photo1280Url = photo1280Url
        self.photo2560Url = photo2560Url
        self.text = text
    }
}
