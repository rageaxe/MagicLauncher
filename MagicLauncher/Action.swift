//
//  Action.swift
//  MagicLauncher
//
//  Created by Jaroslav Chaninovicz on 06/06/15.
//  Copyright (c) 2015 Jaroslav Chaninovicz. All rights reserved.
//

import Foundation
import UIKit

class Action {
    
    var name : NSString?
    var id : Int?
    
    func action(parentController: UIViewController) {
        fatalError("This method must be overridden")
    }
}