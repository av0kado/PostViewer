//
//  JSONMappable.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

/// Protocol for mapping objects from json downloaded via api
protocol JSONMappable {
    
    /// Init with json dictionary
    init?(json: [String : Any])
}
