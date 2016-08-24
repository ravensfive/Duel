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
//            let ball = scene.childNodeWithName("ball") as! SKShapeNode
//            let paddle = scene.childNodeWithName("paddle") as! SKSpriteNode
//            ball.removeFromParent()
//            paddle.removeFromParent()
        }
    }
    
    override func isValidNextState(stateClass: AnyClass) -> Bool {
        return stateClass is WaitingForTapDB.Type
    }
    
}

