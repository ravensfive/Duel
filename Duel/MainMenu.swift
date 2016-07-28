//
//  MainMenu.swift
//  Duel
//
//  Created by Steven Gooday on 21/07/2016.
//  Copyright © 2016 DT5Ravens. All rights reserved.
//

import SpriteKit

class MainMenu: SKScene {
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let game:Bricks = Bricks(fileNamed: "Bricks")!
        game.scaleMode = .AspectFill
        let Transition:SKTransition = SKTransition.doorwayWithDuration(0.1)

        self.view?.presentScene(game, transition: Transition)
        
        // Simon comment
        
        // Simon comment 2
        
        
    }

}
