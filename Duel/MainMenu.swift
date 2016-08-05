//
//  MainMenu.swift
//  Duel
//
//  Created by Steven Gooday on 21/07/2016.
//  Copyright © 2016 DT5Ravens. All rights reserved.
//

import SpriteKit

class MainMenu: SKScene, SKPhysicsContactDelegate {
    
    override func didMoveToView(view: SKView) {
    
        let DUlabel = SKLabelNode(fontNamed: "Helvetica Neue UltraLight")
    
        DUlabel.physicsBody = SKPhysicsBody(edgeLoopFromRect: DUlabel.frame)
        
        DUlabel.physicsBody!.affectedByGravity = true
        
        DUlabel.text = "Duel"
        DUlabel.fontSize = 300
        DUlabel.fontColor = SKColor.blueColor()
        DUlabel.hidden = false
        DUlabel.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        self.addChild(DUlabel)
        
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
