//
//  GestureManager.swift
//  MagicLauncher
//
//  Created by Jaroslav Chaninovicz on 06/06/15.
//  Copyright (c) 2015 Jaroslav Chaninovicz. All rights reserved.
//

import Foundation
import UIKit

class GestureManager {
    private var gestures = [Gesture]()
    
    func getAllGestures()->[Gesture] {
        return self.gestures
    }
    
    func addGesture(gesture: Gesture){
        self.gestures.append(gesture)
    }
    
    func gesturesCount()->Int {
        return self.gestures.count
    }
    
    func editGesture(id: Int, image: UIImage, action : Action, path: [CGPoint]){
        for gesture in self.gestures {
            if(gesture.id == id) {
                gesture.image = image
                gesture.action = action
                gesture.path = path
                break
            }
        }
    }
    
    func deleteGesture(id: Int) {
        var index = 0
        for gesture in self.gestures {
            if(gesture.id == id) {
                self.gestures.removeAtIndex(index)
                break
            }
            index++
        }
    }
}