//
//  CoreDataWorker.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import CoreData

protocol CoreDataWorker {
    
    /// Saves current container's view context
    func save()
}
