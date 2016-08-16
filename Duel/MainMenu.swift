//
//  MainMenu.swift
//  Duel
//
//  Created by Steven Gooday on 21/07/2016.
//  Copyright © 2016 DT5Ravens. All rights reserved.
//

import SpriteKit

let DULabelCategory:UInt32 = 0x1 << 0 // 1
let ELLabelCategory:UInt32 = 0x1 << 1 // 2
let MiddleCategory:UInt32 = 0x1 << 2 // 2

class MainMenu: SKScene, SKPhysicsContactDelegate {
    
    override func didMoveToView(view: SKView) {
        
        //set scene gravity
        scene?.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        //set physics world
        self.physicsWorld.contactDelegate = self
        
        //format main menu
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
        
        let MiddleBlock = SKShapeNode(rectOfSize: CGSize(width: self.frame.width, height: 1))
        MiddleBlock.position = CGPoint(x: 540, y: self.frame.height/2)
        MiddleBlock.fillColor = SKColor.blueColor()
        MiddleBlock.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.frame.width, height: 100))
        MiddleBlock.physicsBody!.affectedByGravity = false
        MiddleBlock.physicsBody!.dynamic = false
        
        MiddleBlock.physicsBody!.categoryBitMask = MiddleCategory
        
        self.addChild(MiddleBlock)
        
        //add sprite node for DU element
        let DUlabel = SKSpriteNode(imageNamed: "DU")
        
        //set starting position, size and name
        DUlabel.position = CGPoint(x: 150, y: 1920)
        DUlabel.size = CGSize(width: 300, height: 300)
        DUlabel.name = "DU"
        //initiate body for physics and apply physics
        DUlabel.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 300, height: 300))
        DUlabel.physicsBody!.mass = 1
        DUlabel.physicsBody!.dynamic = true
        DUlabel.physicsBody!.affectedByGravity = true
        DUlabel.physicsBody!.friction = 0.0
        DUlabel.physicsBody!.restitution = -250
        DUlabel.physicsBody!.linearDamping = 0.0
        DUlabel.physicsBody!.angularDamping = 0.0
        
        DUlabel.physicsBody!.categoryBitMask = DULabelCategory
        DUlabel.physicsBody!.contactTestBitMask = MiddleCategory|ELLabelCategory
        
        //add to scene
        self.addChild(DUlabel)
        
        DUlabel.physicsBody!.applyImpulse(CGVector(dx: 0, dy: -500))
        
        //add sprite node for EL element
        let ELlabel = SKSpriteNode(imageNamed: "EL")
        
         //set starting position, size and name
        ELlabel.position = CGPoint(x:950, y:1920)
        ELlabel.size = CGSize(width: 300, height: 300)
        ELlabel.name = "EL"
        //initiate body for physics and apply physics
        ELlabel.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 300, height: 300))
        ELlabel.physicsBody!.mass = 1
        ELlabel.physicsBody!.dynamic = true
        ELlabel.physicsBody!.affectedByGravity = true
        ELlabel.physicsBody!.friction = 0.0
        ELlabel.physicsBody!.restitution = -250
        ELlabel.physicsBody!.linearDamping = 0.0
        ELlabel.physicsBody!.angularDamping = 0.0
        
        ELlabel.physicsBody!.categoryBitMask = ELLabelCategory
        ELlabel.physicsBody!.contactTestBitMask = MiddleCategory|DULabelCategory
        
        //add to scene
        self.addChild(ELlabel)
        
        ELlabel.physicsBody!.applyImpulse(CGVector(dx: 0, dy: -500))
        
    }
    
    //did begin contact class, called when ball hits an object with a different category mask
    func didBeginContact(contact: SKPhysicsContact) {
        
        //bodyA is the object that has been hit
        //bodyB is the object that has hit
        
        //test if bodyA (the hit object) is a brick, if it is then....
        if contact.bodyA.categoryBitMask == MiddleCategory {
            
                print("Hit Middle")
            
            if contact.bodyB.node!.name == "DU" {
                contact.bodyB.node!.physicsBody!.applyImpulse(CGVector(dx: 500, dy: 0))
            }
            if contact.bodyB.node!.name == "EL" {
                contact.bodyB.node!.physicsBody!.applyImpulse(CGVector(dx: -500, dy: 0))
            }
        }
        if contact.bodyA.categoryBitMask == DULabelCategory {
            print("Hit DU Label")
            contact.bodyB.node!.physicsBody!.applyImpulse(CGVector(dx: 0, dy: -500))
            contact.bodyA.node!.physicsBody!.applyImpulse(CGVector(dx: 0, dy: -500))
        }
        
        if contact.bodyA.categoryBitMask == ELLabelCategory {
            print("Hit EL Label")
        }
    }
}
