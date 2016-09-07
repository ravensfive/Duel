//
//  PlayingDB.swift
//  Duel
//
//  Created by Steven Gooday on 24/08/2016.
//  Copyright © 2016 DT5Ravens. All rights reserved.
//

import SpriteKit
import GameplayKit

class PlayingDB: GKState {
    unowned let scene: DroppingBlocks
    
    init(scene: SKScene) {
        self.scene = scene as! DroppingBlocks
        super.init()
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        if previousState is WaitingForTapDB {
           
            //add starting block
            scene.addFallingBlock()
            
        }
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        
    }
    
    override func isValidNextState(stateClass: AnyClass) -> Bool {
        return stateClass is GameOverDB.Type
    }
}

