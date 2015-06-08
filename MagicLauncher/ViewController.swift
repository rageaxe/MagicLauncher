//
//  ViewController.swift
//  MagicLauncher
//
//  Created by Jaroslav Chaninovicz on 06/06/15.
//  Copyright (c) 2015 Jaroslav Chaninovicz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, InitialViewControllerDelegate, GestureTableViewControllerDelegate, InputGestureViewControllerDelegate {
    
    let defineGestureViewController : DefineGestureViewController = DefineGestureViewController()
    let inputGestureViewController : InputGestureViewController = InputGestureViewController()
    let gesturesTableViewController : GestureTableViewController = GestureTableViewController()
    let gestureManager : GestureManager = GestureManager()
    
    var gestureInputViewButton : UIButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    var defineGestureViewButton : UIButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    var gestureTableViewButton : UIButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.brownColor()
        defineGestureViewController.delegate = self
        gesturesTableViewController.delegate = self
        inputGestureViewController.delegate = self
        setupViewController()
        
        InputeGestureButtonLayout.layout(self.view, innerView: gestureInputViewButton)
        DefineGestureButtonLayout.layout(self.view, innerView: defineGestureViewButton)
        GesturesTableViewButtonLayout.layout(self.view, innerView: gestureTableViewButton, topView: gestureInputViewButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupViewController() {
        gestureInputViewButton.backgroundColor = UIColor.greenColor()
        gestureInputViewButton.setTitle("Input Gestures", forState: UIControlState.Normal)
        gestureInputViewButton.addTarget(self, action: "inputGestureButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        defineGestureViewButton.backgroundColor = UIColor.greenColor()
        defineGestureViewButton.setTitle("Define Gestures", forState: UIControlState.Normal)
        defineGestureViewButton.addTarget(self, action: "defineGestureButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        gestureTableViewButton.backgroundColor = UIColor.greenColor()
        gestureTableViewButton.setTitle("Gestures", forState: UIControlState.Normal)
        gestureTableViewButton.addTarget(self, action: "gesturesTableViewButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func gesturesTableViewButtonAction(sender:UIButton!)
    {
        navigationController?.pushViewController(gesturesTableViewController, animated: true)
    }
    
    func defineGestureButtonAction(sender:UIButton!)
    {
        navigationController?.pushViewController(defineGestureViewController, animated: true)
    }
    
    func inputGestureButtonAction(sender:UIButton!)
    {
        navigationController?.pushViewController(inputGestureViewController, animated: true)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.hidesBarsOnSwipe = false
        super.viewWillAppear(animated)
    }
    
    func createGesture(image: UIImage, action: Action, path: [CGPoint]) {
        var id : Int = 0
        if(gestureManager.gesturesCount() > 0) {
            id = gestureManager.getAllGestures()[gestureManager.gesturesCount() - 1].id + 1
        }
        
        var gesture = Gesture(id: id, action: action, image: image, path: path)
        gestureManager.addGesture(gesture)
    }
    
    func editGesture(id: Int, image: UIImage, action: Action, path: [CGPoint]) {
        gestureManager.editGesture(id, image: image, action: action, path: path)
    }
    
    func deleteGesture(id: Int) {
        gestureManager.deleteGesture(id)
    }
    
    func getGestures() -> [Gesture] {
        return gestureManager.getAllGestures()
    }
    
    func getDefinedGestures() -> [Gesture] {
        return gestureManager.getAllGestures()
    }
    
    func gesturesCount() -> Int {
        return gestureManager.gesturesCount()
    }
}

