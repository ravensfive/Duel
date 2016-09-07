//
//  GameOver.swift
//  Duel
//
//  Created by Steven Gooday on 12/08/2016.
//  Copyright © 2016 DT5Ravens. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameOver: GKState {
    unowned let scene: Bricks
    
    init(scene: SKScene) {
        self.scene = scene as! Bricks
        super.init()
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        if previousState is Playing {
            let ball = scene.childNodeWithName("ball") as! SKShapeNode
            let paddle = scene.childNodeWithName("paddle") as! SKSpriteNode
            ball.removeFromParent()
            paddle.removeFromParent()
        print("Gameover")
        }
    }
    
    override func isValidNextState(stateClass: AnyClass) -> Bool {
        return stateClass is WaitingForTap.Type
    }
    
}
