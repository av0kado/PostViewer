//
//  ImagesLayoutViewImage.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 21/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import UIKit

protocol ImagesLayoutViewImage {
    
    var width: Int { get }
    var height: Int { get }
    func imageUrlString(withMaximumSideSize maximumSideSize: Int) -> String
    var image: UIImage? { get }
}
