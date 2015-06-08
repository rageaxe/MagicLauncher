//
//  ActionPickerLayout.swift
//  MagicLauncher
//
//  Created by Jaroslav Chaninovicz on 06/06/15.
//  Copyright (c) 2015 Jaroslav Chaninovicz. All rights reserved.
//

import Foundation
import UIKit

struct ActionPickerLayout {
    static func layout(containerView: UIView, innerView: UIView) {
        innerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        containerView.addSubview(innerView)
        
        containerView.addConstraint(NSLayoutConstraint(item: innerView, attribute: .Top, relatedBy: .Equal, toItem: containerView, attribute: .Top, multiplier: 1, constant: 30))
        
        containerView.addConstraint(NSLayoutConstraint(item: innerView, attribute: .Left, relatedBy: .Equal, toItem: containerView, attribute: .Left, multiplier: 1, constant: 0))
        
    }
}