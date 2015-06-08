//
//  GesturesTableViewButtonLayout.swift
//  MagicLauncher
//
//  Created by Jaroslav Chaninovicz on 06/06/15.
//  Copyright (c) 2015 Jaroslav Chaninovicz. All rights reserved.
//

import Foundation
import UIKit

struct GesturesTableViewButtonLayout {
    static func layout(containerView: UIView, innerView: UIView, topView: UIView) {
        innerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        containerView.addSubview(innerView)
        
        containerView.addConstraint(NSLayoutConstraint(item: innerView, attribute: .Top, relatedBy: .Equal, toItem: topView, attribute: .Bottom, multiplier: 1, constant: 10))

        containerView.addConstraint(NSLayoutConstraint(item: innerView, attribute: .CenterX, relatedBy: .Equal, toItem: containerView, attribute: .CenterX, multiplier: 1, constant: 0))
        
        containerView.addConstraint(NSLayoutConstraint(item: innerView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: buttonSize.height))
        
        containerView.addConstraint(NSLayoutConstraint(item: innerView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: buttonSize.width))
    }
}