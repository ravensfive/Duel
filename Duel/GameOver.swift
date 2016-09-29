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
    
    init(scene: SKScene) {
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        if previousState is Playing {
            print("game over")
            //let ball = scene.childNode(withName: "ball") as! SKShapeNode
            //let paddle = scene.childNode(withName: "paddle") as! SKSpriteNode
            //ball.removeFromParent()
            //paddle.removeFromParent()
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is WaitingForTap.Type
    }
    
}
