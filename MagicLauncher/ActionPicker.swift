//
//  ActionPicker.swift
//  MagicLauncher
//
//  Created by Jaroslav Chaninovicz on 06/06/15.
//  Copyright (c) 2015 Jaroslav Chaninovicz. All rights reserved.
//

import Foundation
import UIKit

class ActionPicker: UIPickerView  {
    let actionManager: ActionManager = ActionManager()
    var currentAction : Int = 0
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.dataSource = self
        self.delegate = self
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getCurrentAction()->Action {
        return actionManager.getActions()[currentAction]
    }
    
}

extension ActionPicker: UIPickerViewDataSource {
    
    func numberOfComponentsInPickerView(colorPicker: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return actionManager.getActions().count
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentAction = row
    }
}

extension ActionPicker: UIPickerViewDelegate {
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        return actionManager.getActions()[row].name! as String
    }
}