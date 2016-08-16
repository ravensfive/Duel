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
        
        //Format Main Menu
        FormatMainMenu()
    
    }
    
    //touches began class, called when user touches the main menu screen
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //controlling which game to navigate to
        let game:Bricks = Bricks(fileNamed: "Bricks")!
        
        //set scene scale mode i.e. fill to screen
        game.scaleMode = .AspectFill
        
        let action = SKAction.playSoundFileNamed("AreYouReady.aifc", waitForCompletion: true)
        runAction(action)
        
        //set transition between screens
        let Transition:SKTransition = SKTransition.doorwayWithDuration(5)
        
        //load game scene
        self.view?.presentScene(game, transition: Transition)
        
    }
    
    func FormatMainMenu() {
        
        let DUlabel = SKSpriteNode(imageNamed: "DU")
        
        DUlabel.position = CGPoint(x: 350, y: 960)
        DUlabel.size = CGSize(width: 300, height: 300)
        DUlabel.physicsBody = SKPhysicsBody(edgeLoopFromRect: DUlabel.frame)
        DUlabel.physicsBody!.mass = 1
        DUlabel.physicsBody!.dynamic = true
        DUlabel.physicsBody!.affectedByGravity = true
        DUlabel.physicsBody!.friction = 0.0
        DUlabel.physicsBody!.restitution = 1
        DUlabel.physicsBody!.linearDamping = 0.0
        DUlabel.physicsBody!.angularDamping = 0.0
        DUlabel.physicsBody!.pinned = false
        DUlabel.name = "DU"
        
        self.addChild(DUlabel)
        
        let ELlabel = SKSpriteNode(imageNamed: "EL")
        
        ELlabel.position = CGPoint(x:700, y:960)
        ELlabel.size = CGSize(width: 300, height: 300)
        ELlabel.physicsBody = SKPhysicsBody(edgeLoopFromRect: ELlabel.frame)
        ELlabel.physicsBody!.mass = 1
        ELlabel.physicsBody!.dynamic = true
        ELlabel.physicsBody!.affectedByGravity = true
        ELlabel.physicsBody!.friction = 0.0
        ELlabel.physicsBody!.restitution = 1
        ELlabel.physicsBody!.linearDamping = 0.0
        ELlabel.physicsBody!.angularDamping = 0.0
        ELlabel.name = "EL"
        
        self.addChild(ELlabel)
        
        DUlabel.physicsBody!.applyImpulse(CGVector(dx: 300, dy: 300))
        
    }
    

}
