//
//  OpenCameraAction.swift
//  MagicLauncher
//
//  Created by Jaroslav Chaninovicz on 09/06/15.
//  Copyright (c) 2015 Jaroslav Chaninovicz. All rights reserved.
//

import Foundation
import UIKit
class OpenCameraAction: Action {
    
    let cameraViewController : CameraViewController = CameraViewController()
    
    init(name : NSString, id: Int) {
        super.init()
        self.name = name
        self.id = id
    }
    
    override func action(parentController: UIViewController) {
        parentController.navigationController?.pushViewController(cameraViewController, animated: true)
    }
}