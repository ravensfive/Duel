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
let MiddleCategory:UInt32 = 0x1 << 2 // 4
let BorderCategory:UInt32 = 0x1 << 3 // 8

class MainMenu: SKScene, SKPhysicsContactDelegate {
    
    override func didMoveToView(view: SKView) {
        
        //set scene gravity
        scene?.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        //set physics world
        self.physicsWorld.contactDelegate = self
        
        //format main menu
        //FormatMainMenu()
        FormatMainMenuAction()
        
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
        
        //set up frame around full game scene
        let borderBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        //set border friction to zero, removing physics
        borderBody.friction = 0
        self.physicsBody = borderBody
        borderBody.categoryBitMask = BorderCategory
    
        
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
        DUlabel.position = CGPoint(x: 280, y: 1600)
        DUlabel.size = CGSize(width: 200, height: 200)
        DUlabel.name = "DU"
        //initiate body for physics and apply physics
        DUlabel.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 200, height: 200))
        DUlabel.physicsBody!.mass = 1
        DUlabel.physicsBody!.dynamic = true
        DUlabel.physicsBody!.affectedByGravity = true
        DUlabel.physicsBody!.friction = 0.0
        DUlabel.physicsBody!.restitution = -500
        DUlabel.physicsBody!.linearDamping = 0.0
        DUlabel.physicsBody!.angularDamping = 0.0
        
        DUlabel.physicsBody!.categoryBitMask = DULabelCategory
        DUlabel.physicsBody!.contactTestBitMask = MiddleCategory|ELLabelCategory|BorderCategory
        
        //add to scene
        self.addChild(DUlabel)
        
        DUlabel.physicsBody!.applyImpulse(CGVector(dx: 0, dy: -500))
        
        //add sprite node for EL element
        let ELlabel = SKSpriteNode(imageNamed: "EL")
        
         //set starting position, size and name
        ELlabel.position = CGPoint(x:880, y:1600)
        ELlabel.size = CGSize(width: 200, height: 200)
        ELlabel.name = "EL"
        //initiate body for physics and apply physics
        ELlabel.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 200, height: 200))
        ELlabel.physicsBody!.mass = 1
        ELlabel.physicsBody!.dynamic = true
        ELlabel.physicsBody!.affectedByGravity = true
        ELlabel.physicsBody!.friction = 0.0
        ELlabel.physicsBody!.restitution = -500
        ELlabel.physicsBody!.linearDamping = 0.0
        ELlabel.physicsBody!.angularDamping = 0.0
        
        ELlabel.physicsBody!.categoryBitMask = ELLabelCategory
        ELlabel.physicsBody!.contactTestBitMask = MiddleCategory|DULabelCategory|BorderCategory
        
        //add to scene
        self.addChild(ELlabel)
        
        ELlabel.physicsBody!.applyImpulse(CGVector(dx: 0, dy: -500))
        
    }
    
    func FormatMainMenuAction() {
        
        //add sprite node for DU element
        let DUlabel = SKSpriteNode(imageNamed: "DU")
        
        //set starting position, size and name
        DUlabel.position = CGPoint(x: 280, y: 1600)
        DUlabel.size = CGSize(width: 200, height: 200)
        DUlabel.name = "DU"
        DUlabel.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 200, height: 200))
        DUlabel.physicsBody!.dynamic = true
        DUlabel.physicsBody!.allowsRotation = false
        DUlabel.physicsBody!.restitution = 100
        DUlabel.physicsBody!.mass = 0.34
        //add to scene
        self.addChild(DUlabel)
        
        //add sprite node for EL element
        let ELlabel = SKSpriteNode(imageNamed: "EL")
        
        //set starting position, size and name
        ELlabel.position = CGPoint(x:880, y:1600)
        ELlabel.size = CGSize(width: 200, height: 200)
        ELlabel.name = "EL"
        ELlabel.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 200, height: 200))
        ELlabel.physicsBody!.dynamic = true
        ELlabel.physicsBody!.allowsRotation = false
        ELlabel.physicsBody!.restitution = 1
        ELlabel.physicsBody!.mass = 0.34
        //add to scene
        self.addChild(ELlabel)
        
        let action1 = SKAction.moveBy(CGVector(dx:0,dy: -500), duration: 1.0)
        let action2 = SKAction.moveBy(CGVector(dx:500,dy: 0), duration: 0.2)
        let action3 = SKAction.moveBy(CGVector(dx:-500,dy: 0), duration: 0.2)
        let sequence1 = SKAction.sequence([action1,action2])
        let sequence2 = SKAction.sequence([action1,action3])
        //DUlabel.runAction(SKAction.repeatAction(sequence1, count: 1))
        DUlabel.runAction(sequence1)
        ELlabel.runAction(sequence2)
        
        if DUlabel.hasActions() == true {
            print(DUlabel.hasActions())
        }
        
        
        //DUlabel.physicsBody!.applyImpulse(CGVector(dx: 200, dy: 0))
        //ELlabel.physicsBody!.applyImpulse(CGVector(dx: -200, dy: 0))
        
    }
    
    //did begin contact class, called when ball hits an object with a different category mask
    func didBeginContact(contact: SKPhysicsContact) {
        
        //bodyA is the object that has been hit
        //bodyB is the object that has hit
        
        //test if bodyA (the hit object) is a brick, if it is then....
        if contact.bodyA.categoryBitMask == MiddleCategory {
            
            if contact.bodyB.node!.name == "DU" {
                contact.bodyB.node!.physicsBody!.applyImpulse(CGVector(dx: 500, dy: 0))
            }
            else if contact.bodyB.node!.name == "EL" {
                contact.bodyB.node!.physicsBody!.applyImpulse(CGVector(dx: -500, dy: 0))
            }
        }
        else if contact.bodyA.categoryBitMask == DULabelCategory {
            print("Hit DU Label")
            contact.bodyB.node!.physicsBody!.applyImpulse(CGVector(dx: 0, dy: -500))
            contact.bodyB.node!.physicsBody!.friction = 100
            contact.bodyA.node!.physicsBody!.applyImpulse(CGVector(dx: 0, dy: -500))
            contact.bodyA.node!.physicsBody!.friction = 100
            scene?.physicsWorld.gravity = CGVector(dx: 0, dy: -10)
        }
        
        else if contact.bodyA.categoryBitMask == ELLabelCategory {
            print("Hit EL Label")
        }
        
        else if contact.bodyA.categoryBitMask == BorderCategory {
            print("Hit Border")
            
            if contact.bodyB.node!.name == "DU" {
                contact.bodyB.node!.physicsBody!.applyImpulse(CGVector(dx: 100, dy: 0))
            }
            else if contact.bodyB.node!.name == "EL" {
                contact.bodyB.node!.physicsBody!.applyImpulse(CGVector(dx: -100, dy: 0))
            }
        }
        
    }
}
