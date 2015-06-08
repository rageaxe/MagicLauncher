//
//  PrintlnAction.swift
//  MagicLauncher
//
//  Created by Jaroslav Chaninovicz on 06/06/15.
//  Copyright (c) 2015 Jaroslav Chaninovicz. All rights reserved.
//

import Foundation

class PrintlnAction: Action {
    init(name : NSString, id: Int) {
        super.init()
        self.name = name
        self.id = id
    }
    
    override func action() {
        println("println action!!!")
    }
}