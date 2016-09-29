//
//  WaitingForTap.swift
//  Duel
//
//  Created by Steven Gooday on 12/08/2016.
//  Copyright © 2016 DT5Ravens. All rights reserved.
//

import SpriteKit
import GameplayKit

class WaitingForTap: GKState {
    
    init(scene: SKScene) {
        super.init()
    }
    
    
    override func didEnter(from previousState: GKState?) {
        print("waiting")
        //let scale = SKAction.scaleTo(1.0, duration: 0.25)
        //scene.childNodeWithName(GameMessageName)!.runAction(scale)
    }
    
    override func willExit(to nextState: GKState) {
        if nextState is Playing {
            //let scale = SKAction.scaleTo(0, duration: 0.4)
            //scene.childNodeWithName(GameMessageName)!.runAction(scale)
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is Playing.Type
    }
    
}
