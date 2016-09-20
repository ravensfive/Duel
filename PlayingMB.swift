//
//  PlayingDB.swift
//  Duel
//
//  Created by Steven Gooday on 24/08/2016.
//  Copyright © 2016 DT5Ravens. All rights reserved.
//

import SpriteKit
import GameplayKit

class PlayingMB: GKState {
    unowned let scene: MovingBlocks
    
    init(scene: SKScene) {
        self.scene = scene as! MovingBlocks
        super.init()
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        if previousState is WaitingForTapMB {
            
            let ball = scene.childNodeWithName("ball") as! SKShapeNode
            ball.physicsBody!.applyImpulse(CGVector(dx: 300, dy: 300))
            
        }
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        
    }
    
    override func isValidNextState(stateClass: AnyClass) -> Bool {
        return stateClass is GameOverMB.Type
    }
}

