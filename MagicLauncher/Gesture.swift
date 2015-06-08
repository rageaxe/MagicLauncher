//
//  Gesture.swift
//  MagicLauncher
//
//  Created by Jaroslav Chaninovicz on 06/06/15.
//  Copyright (c) 2015 Jaroslav Chaninovicz. All rights reserved.
//

import Foundation
import UIKit

class Gesture {
    var image : UIImage
    var id : Int
    var action : Action
    var path : [CGPoint]
    
    init(id: Int, action : Action, image: UIImage, path: [CGPoint]){
        self.id = id
        self.action = action
        self.image = image
        self.path = path
    }
}
