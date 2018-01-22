//
//  MappableAttachmentImage.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

/// Mappable extension of AttachmentImage
class MappableAttachmentImage : AttachmentImage, JSONMappable {
    
    // MARK: - JSONMappable
    
    required init?(json: [String : Any]) {
        guard let width = json["width"] as? Int, let height = json["height"] as? Int, let photo75Url = json["photo_75"] as? String else {
            return nil
        }
        
        let photo130Url = json["photo_130"] as? String
        let photo604Url = json["photo_604"] as? String
        let photo807Url = json["photo_807"] as? String
        let photo1280Url = json["photo_1280"] as? String
        let photo2560Url = json["photo_2560"] as? String
        
        let text = json["text"] as? String
        
        super.init(width: width, height: height, photo75Url: photo75Url, photo130Url: photo130Url, photo604Url: photo604Url, photo807Url: photo807Url, photo1280Url: photo1280Url, photo2560Url: photo2560Url, text: text)
    }
}
