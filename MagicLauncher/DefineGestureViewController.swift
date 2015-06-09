//
//  DefineGestureViewController.swift
//  MagicLauncher
//
//  Created by Jaroslav Chaninovicz on 06/06/15.
//  Copyright (c) 2015 Jaroslav Chaninovicz. All rights reserved.
//

import Foundation
import UIKit

class DefineGestureViewController: EditableGestureViewController {
    
    let saveGestureButton : UIButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    var delegate : InitialViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayColor()
        
        setupDefineGestureViewController()
        SaveGestureButtonLayout.layout(self.view, innerView: saveGestureButton)
    }
    
    
    func setupDefineGestureViewController(){
        saveGestureButton.backgroundColor = UIColor.greenColor()
        saveGestureButton.setTitle("Save", forState: UIControlState.Normal)
        saveGestureButton.addTarget(self, action: "saveGestureButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func saveGestureButtonAction(sender:UIButton!)
    {
        if let image = imageView.image {
            var normalisedPath = recognizeGesture.normaliseGesturePath(gesturePoints)
            if(normalisedPath.count != 64) {
                println("bad path count,draw again")
            } else {
                self.delegate?.createGesture(image, action: actionPicker.getCurrentAction(), path: normalisedPath)
                self.imageView.image = nil
                println("Gesture Saved")
            }
        } else {
            println("draw gesture!")
        }
        
    }

}