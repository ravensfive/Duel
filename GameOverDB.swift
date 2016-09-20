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
    
    override func didEnter(from previousState: GKState?) {
        
        if previousState is PlayingDB {
        
            let player = scene.childNode(withName: "player") as! SKShapeNode
            let block = scene.childNode(withName: "fallingblock") as! SKShapeNode
            let bottom = scene.childNode(withName: "bottom") as! SKShapeNode
            
            bottom.removeFromParent()
            player.removeFromParent()
            block.removeFromParent()
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is WaitingForTapDB.Type
    }
    
}

