//
//  WaitingForTapDB.swift
//  Duel
//
//  Created by Steven Gooday on 24/08/2016.
//  Copyright © 2016 DT5Ravens. All rights reserved.
//

import SpriteKit
import GameplayKit

class WaitingForTapDB: GKState {
    unowned let scene: DroppingBlocks
    
    init(scene: SKScene) {
        self.scene = scene as! DroppingBlocks
        super.init()
    }

    override func didEnterWithPreviousState(previousState: GKState?) {
     print("entered waiting for tap state")
    }
    
    override func willExitWithNextState(nextState: GKState) {
        if nextState is PlayingDB {
        }
    }
    
    override func isValidNextState(stateClass: AnyClass) -> Bool {
        return stateClass is PlayingDB.Type
    }
    
}