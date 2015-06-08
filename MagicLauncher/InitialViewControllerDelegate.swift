//
//  InitialViewControllerDelegate.swift
//  MagicLauncher
//
//  Created by Jaroslav Chaninovicz on 06/06/15.
//  Copyright (c) 2015 Jaroslav Chaninovicz. All rights reserved.
//

import Foundation
import UIKit

protocol InitialViewControllerDelegate {
    func createGesture(image: UIImage, action: Action, path: [CGPoint])
}