//
//  OpenGoogleAction.swift
//  MagicLauncher
//
//  Created by Jaroslav Chaninovicz on 08/06/15.
//  Copyright (c) 2015 Jaroslav Chaninovicz. All rights reserved.
//

import Foundation
import UIKit
class OpenGoogleAction: Action {
    init(name : NSString, id: Int) {
        super.init()
        self.name = name
        self.id = id
    }
    
    override func action() {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.google.com")!)
    }
}
