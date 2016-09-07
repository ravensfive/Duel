//
//  GameOverDB.swift
//  Duel
//
//  Created by Steven Gooday on 24/08/2016.
//  Copyright © 2016 DT5Ravens. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameOverDB: GKState {
    unowned let scene: DroppingBlocks
    
    init(scene: SKScene) {
        self.scene = scene as! DroppingBlocks
        super.init()
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        
        if previousState is PlayingDB {
        
            let player = scene.childNodeWithName("player") as! SKShapeNode
            let block = scene.childNodeWithName("fallingblock") as! SKShapeNode
            let bottom = scene.childNodeWithName("bottom") as! SKShapeNode
            
            bottom.removeFromParent()
            player.removeFromParent()
            block.removeFromParent()
        }
    }
    
    override func isValidNextState(stateClass: AnyClass) -> Bool {
        return stateClass is WaitingForTapDB.Type
    }
    
}

