//
//  MainMenu.swift
//  Duel
//
//  Created by Steven Gooday on 21/07/2016.
//  Copyright © 2016 DT5Ravens. All rights reserved.
//

import SpriteKit

class MainMenu: SKScene {
    
    var areyoureadylabel:SKLabelNode!
    
    override func didMoveToView(view: SKView) {
            print("Moved to main menu")
        
        
        areyoureadylabel = SKLabelNode(fontNamed: "Arial")
        
        areyoureadylabel.text = "Test - Test - Test - Test"
        areyoureadylabel.fontSize = 200
        areyoureadylabel.fontColor = SKColor(red: 150, green: 150, blue: 150, alpha: 150)
        areyoureadylabel.hidden = false
        self.addChild(areyoureadylabel)
        
    }
    
    //touches began class, called when user touches the main menu screen
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //controlling which game to navigate to
        let game:Bricks = Bricks(fileNamed: "Bricks")!
        
        //set scene scale mode i.e. fill to screen
        game.scaleMode = .AspectFill
        
        //set transition between screens
        let Transition:SKTransition = SKTransition.doorwayWithDuration(0.1)
        
        //load game scene
        self.view?.presentScene(game, transition: Transition)
        
        
    }

}
