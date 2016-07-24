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
        let game:BrickBreaker = BrickBreaker(fileNamed: "BrickBreaker")!
        self.view?.presentScene(game)
        
        // Simon comment
        
    }

}
