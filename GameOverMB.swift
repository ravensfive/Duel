//
//  GameOverDB.swift
//  Duel
//
//  Created by Steven Gooday on 24/08/2016.
//  Copyright © 2016 DT5Ravens. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameOverMB: GKState {
    unowned let scene: MovingBlocks
    
    init(scene: SKScene) {
        self.scene = scene as! MovingBlocks
        super.init()
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        
        if previousState is PlayingMB {
            
            //let player = scene.childNodeWithName("player") as! SKShapeNode
            //let block = scene.childNodeWithName("fallingblock") as! SKShapeNode
            //let bottom = scene.childNodeWithName("bottom") as! SKShapeNode
            
            //bottom.removeFromParent()
            //player.removeFromParent()
            //block.removeFromParent()
        }
    }
    
    override func isValidNextState(stateClass: AnyClass) -> Bool {
        return stateClass is WaitingForTapMB.Type
    }
    
}

