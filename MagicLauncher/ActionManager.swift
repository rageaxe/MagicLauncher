//
//  ActionManager.swift
//  MagicLauncher
//
//  Created by Jaroslav Chaninovicz on 06/06/15.
//  Copyright (c) 2015 Jaroslav Chaninovicz. All rights reserved.
//

import Foundation

class ActionManager {
    private var actions = [Action]()
    
    init(){
        createActions()
    }
    
    private func createActions() {
        actions.append(PrintlnAction(name: "Println Action", id: 0))
        actions.append(TestAction(name: "Test Action", id : 1))
        actions.append(RandomAction(name: "Random Action", id: 2))
        actions.append(OpenGoogleAction(name: "Open Google", id: 3))
    }
    
    func getActions()->[Action] {
        return self.actions
    }
}