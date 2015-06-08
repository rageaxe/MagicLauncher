//
//  DeleteGestureButtonLayout.swift
//  MagicLauncher
//
//  Created by Jaroslav Chaninovicz on 06/06/15.
//  Copyright (c) 2015 Jaroslav Chaninovicz. All rights reserved.
//

import Foundation
import UIKit

struct DeleteGestureButtonLayout {
    static func layout(containerView: UIView, innerView: UIView) {
        innerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        containerView.addSubview(innerView)
        
        containerView.addConstraint(NSLayoutConstraint(item: innerView, attribute: .Bottom, relatedBy: .Equal, toItem: containerView, attribute: .Bottom, multiplier: 1, constant: -buttonMargin))
        
        containerView.addConstraint(NSLayoutConstraint(item: innerView, attribute: .Right, relatedBy: .Equal, toItem: containerView, attribute: .Right, multiplier: 1, constant: 0))
        
        containerView.addConstraint(NSLayoutConstraint(item: innerView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: buttonSize.height))
        
        containerView.addConstraint(NSLayoutConstraint(item: innerView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: buttonSize.width))
    }
}