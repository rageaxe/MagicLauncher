//
//  Action.swift
//  MagicLauncher
//
//  Created by Jaroslav Chaninovicz on 06/06/15.
//  Copyright (c) 2015 Jaroslav Chaninovicz. All rights reserved.
//

import Foundation

class Action {
    
    var name : NSString?
    var id : Int?
    
    func action() {
        fatalError("This method must be overridden")
    }
}