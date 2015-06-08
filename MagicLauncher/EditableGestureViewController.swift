//
//  EditableGestureViewController.swift
//  MagicLauncher
//
//  Created by Jaroslav Chaninovicz on 06/06/15.
//  Copyright (c) 2015 Jaroslav Chaninovicz. All rights reserved.
//

import Foundation

class EditableGestureViewController: DrawGestureViewController {
    let actionPicker : ActionPicker = ActionPicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ActionPickerLayout.layout(self.view, innerView: actionPicker)
    }
}