//
//  InputGestureViewController.swift
//  MagicLauncher
//
//  Created by Jaroslav Chaninovicz on 06/06/15.
//  Copyright (c) 2015 Jaroslav Chaninovicz. All rights reserved.
//

import Foundation
import UIKit

class InputGestureViewController: DrawGestureViewController {
    var delegate : InputGestureViewControllerDelegate?
    let recognizeGesture : RecongnizeGesture = RecongnizeGesture()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellowColor()
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        
        if let gestures = self.delegate?.getDefinedGestures() {

            let recognizedGesture : Gesture? = recognizeGesture.recognizeGesture(gesturePoints, definedGestures: gestures)
            if let gesture = recognizedGesture {
                recognizedGestureExecuteAction(gesture)
            }
            
        }
    }
    
    func recognizedGestureExecuteAction(gesture: Gesture?) {
        gesture?.action.action()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        imageView.image = nil
    }
}