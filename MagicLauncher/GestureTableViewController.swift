//
//  GestureTableViewController.swift
//  MagicLauncher
//
//  Created by Jaroslav Chaninovicz on 06/06/15.
//  Copyright (c) 2015 Jaroslav Chaninovicz. All rights reserved.
//

import Foundation
import UIKit

class GestureTableViewController: UITableViewController, EditGestureViewControllerDelegate {
    var delegate : GestureTableViewControllerDelegate?
    let textCellIdentifier = "GestureCell"
    var gestureEditViews : [EditGestureViewController]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: textCellIdentifier)
        self.tableView.rowHeight = 120
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.hidesBarsOnSwipe = true
        createEditGestureViews()
        self.tableView.reloadData()
        super.viewWillAppear(animated)
    }
    
    func createEditGestureViews() {
        gestureEditViews = [EditGestureViewController]()
        var gestures : [Gesture]? = self.delegate?.getGestures()
        for gesture in gestures! {
            var editGestureView : EditGestureViewController = EditGestureViewController()
            editGestureView.delegate = self
            editGestureView.gesture = gesture
            gestureEditViews?.append(editGestureView)
        }
    }
    
    func editGesture(id: Int, image: UIImage, action: Action, path: [CGPoint]) {
        self.delegate?.editGesture(id, image: image, action: action, path: path)
    }
    
    func deleteGesture(id: Int) {
        self.delegate?.deleteGesture(id)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count : Int? = self.delegate?.gesturesCount()
        return count!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        let row = indexPath.row
        var gesture : Gesture? = self.delegate?.getGestures()[row]
        cell.textLabel?.text = gesture?.action.name as? String
        cell.imageView?.image = gesture?.image
        
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        if var gestureEditView = gestureEditViews?[row] {
            navigationController?.pushViewController(gestureEditView, animated: true)
        }
        
    }
}