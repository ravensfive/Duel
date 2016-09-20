//
//  WaitingForTapDB.swift
//  Duel
//
//  Created by Steven Gooday on 24/08/2016.
//  Copyright © 2016 DT5Ravens. All rights reserved.
//

import SpriteKit
import GameplayKit

class WaitingForTapMB: GKState {
    unowned let scene: MovingBlocks
    
    init(scene: SKScene) {
        self.scene = scene as! MovingBlocks
        super.init()
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        
    }
    
    override func willExitWithNextState(nextState: GKState) {
        if nextState is PlayingMB {
        }
    }
    
    override func isValidNextState(stateClass: AnyClass) -> Bool {
        return stateClass is PlayingMB.Type
    }
    
}