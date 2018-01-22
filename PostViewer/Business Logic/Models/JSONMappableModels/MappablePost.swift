//
//  MappablePost.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import Foundation

/// Mappable version of post
class MappablePost: Post, JSONMappable {
    
    // MARK: - JSONMappable
    
    required init?(json: [String : Any]) {
        guard let unixDate = json["date"] as? Int,
            let likesDictionary = json["likes"] as? [String : Any],
            let likesCount = likesDictionary["count"] as? Int,
            let userLikes = likesDictionary["user_likes"] as? Int else {
                return nil
        }
        
        var id: Int?
        if let postId = json["post_id"] as? Int {
            id = postId
        } else if let postId = json["id"] as? Int {
            id = postId
        }
        
        guard id != nil else {
            return nil
        }
        let postId = id!
        
        var source: Int?
        if let sourceId = json["owner_id"] as? Int {
            source = sourceId
        } else if let sourceId = json["source_id"] as? Int {
            source = sourceId
        }
        
        guard source != nil else {
            return nil
        }
        let sourceId = source!
        
        let ownerId = abs(sourceId)
        
        // Positive for users, negative for groups
        var ownerType: OwnerType
        if sourceId > 0 {
            ownerType = .user
        }
        else {
            ownerType = .group
        }
        
        let date = Date(timeIntervalSince1970: Double(unixDate))
        
        var text: String?
        if let postText = json["text"] as? String {
            text = postText
        }
        
        let isLiked = (userLikes == 1)
        
        let mappedAttachments = MappablePost.mapAttachments(json["attachments"])
        
        let attachmentImages: [AttachmentImage]? = mappedAttachments
        
        super.init(postId: postId, ownerId: ownerId, ownerType: ownerType, date: date, text: text, images: attachmentImages, likes: likesCount, isLiked: isLiked)
    }
    
    // MARK: - Private
    
    /// Map attachments images; can be extended to map other types of attachments;
    ///
    /// - Parameter attachments: attachments json
    /// - Returns: mapped attachments
    static private func mapAttachments(_ attachments: Any?) -> ([AttachmentImage]?) {
        
        guard let attachments = attachments as? [[String : Any]] else {
            return nil
        }
        
        var attachmentImages: [AttachmentImage]?
        
        for attachment in attachments {
            
            guard let type = attachment["type"] as? String,
                let json = attachment[type] as? [String : Any] else {
                    
                continue
            }
            
            // Add other attachment types here
            switch type {
            case "photo":
                let mappedAttachmentImage = MappableAttachmentImage(json: json)
                
                if let image = mappedAttachmentImage {
                    
                    if attachmentImages == nil {
                        attachmentImages = []
                    }
                    attachmentImages?.append(image)
                }
                break
            default:
                break
            }
        }
        
        return (attachmentImages)
    }
}
