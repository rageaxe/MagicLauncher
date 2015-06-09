//
//  EditGestureViewController.swift
//  MagicLauncher
//
//  Created by Jaroslav Chaninovicz on 06/06/15.
//  Copyright (c) 2015 Jaroslav Chaninovicz. All rights reserved.
//

import Foundation
import UIKit

class EditGestureViewController: EditableGestureViewController {
    
    let saveGestureButton : UIButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    let deleteGestureButton : UIButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    var delegate : EditGestureViewControllerDelegate?
    var gesture : Gesture? {
        didSet {
            self.updateGesture()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayColor()
        
        setupEditGestureViewController()
        SaveGestureButtonLayout.layout(self.view, innerView: saveGestureButton)
        DeleteGestureButtonLayout.layout(self.view, innerView: deleteGestureButton)
    }
    
    
    func setupEditGestureViewController(){
        saveGestureButton.backgroundColor = UIColor.greenColor()
        saveGestureButton.setTitle("Save", forState: UIControlState.Normal)
        saveGestureButton.addTarget(self, action: "saveGestureButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        deleteGestureButton.backgroundColor = UIColor.greenColor()
        deleteGestureButton.setTitle("Delete", forState: UIControlState.Normal)
        deleteGestureButton.addTarget(self, action: "deleteGestureButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func updateGesture() {
        imageView.image = gesture?.image
        if var row = gesture?.action.id {
            actionPicker.selectRow(row, inComponent: 0, animated: false)
        }
    }
    
    func saveGestureButtonAction(sender:UIButton!)
    {
        if let image = imageView.image {
            let gestureId: Int? = gesture?.id
            var normalisedPath = recognizeGesture.normaliseGesturePath(gesturePoints)
            self.delegate?.editGesture(gestureId!, image: image, action: actionPicker.getCurrentAction(), path: normalisedPath)
            navigationController?.popViewControllerAnimated(true)
            println("Gesture edited")
        } else {
            println("draw gesture!")
        }
        
    }
    
    func deleteGestureButtonAction(sender:UIButton!) {
        let gestureId: Int? = gesture?.id
        self.delegate?.deleteGesture(gestureId!)
        println("Gesture deleted")
        navigationController?.popViewControllerAnimated(true)
    }
    
}