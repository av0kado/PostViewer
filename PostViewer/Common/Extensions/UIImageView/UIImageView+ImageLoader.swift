//
//  UIImageView+ImageLoader.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 21/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func setImageOnMainQueue(_ image: UIImage) {
        DispatchQueue.main.async {
            self.image = image
        }
    }
    
    func loadImage(with url: URL) {
        sd_setImage(with: url, completed: nil)
    }
    
    static func freeUpCachedMemory() {
        SDImageCache.shared().clearMemory()
    }
}
