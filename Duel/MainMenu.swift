//
//  MainMenu.swift
//  Duel
//
//  Created by Steven Gooday on 21/07/2016.
//  Copyright © 2016 DT5Ravens. All rights reserved.
//

import SpriteKit
import GameplayKit

let DULabelCategory:UInt32 = 0x1 << 0 // 1
let ELLabelCategory:UInt32 = 0x1 << 1 // 2
let BorderCategory:UInt32 = 0x1 << 2 // 4

class MainMenu: SKScene, SKPhysicsContactDelegate {
    
    override func didMoveToView(view: SKView) {
        
        //set scene gravity
        scene?.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        //set physics world
        self.physicsWorld.contactDelegate = self
        
        //format main menu
        FormatMainMenuAction()
        
    }
    
    //touches began class, called when user touches the main menu screen
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let beginaction = SKAction.playSoundFileNamed("Begin.aifc", waitForCompletion: false)
        runAction(beginaction)
        
        //controlling which game to navigate to
        let game:Bricks = Bricks(fileNamed: "Bricks")!
        
        //set scene scale mode i.e. fill to screen
        game.scaleMode = .AspectFill
    
        
        //set transition between screens
        let Transition:SKTransition = SKTransition.doorwayWithDuration(3)
        
        //load game scene
        self.view?.presentScene(game, transition: Transition)
        
    }
    
    func FormatMainMenuAction() {
        
        //set up frame around full game scene
        let borderBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        //set border friction to zero, removing physics
        borderBody.friction = 0
        self.physicsBody = borderBody
        borderBody.categoryBitMask = BorderCategory
        
        //add sprite node for DU element
        let DUlabel = SKSpriteNode(imageNamed: "DU")
        
        //set starting position, size and name
        DUlabel.position = CGPoint(x: 280, y: 1700)
        DUlabel.size = CGSize(width: 200, height: 200)
        DUlabel.name = "DU"
        DUlabel.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 200, height: 200))
        DUlabel.physicsBody!.allowsRotation = false
        DUlabel.physicsBody!.categoryBitMask = DULabelCategory
        DUlabel.physicsBody!.contactTestBitMask = ELLabelCategory|BorderCategory
        
        //add to scene
        self.addChild(DUlabel)
        
        //add sprite node for EL element
        let ELlabel = SKSpriteNode(imageNamed: "EL")
        
        //set starting position, size and name
        ELlabel.position = CGPoint(x:880, y:1700)
        ELlabel.size = CGSize(width: 200, height: 200)
        ELlabel.name = "EL"
        ELlabel.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 200, height: 200))
        ELlabel.physicsBody!.allowsRotation = false
        ELlabel.physicsBody!.categoryBitMask = ELLabelCategory
        ELlabel.physicsBody!.contactTestBitMask = DULabelCategory|BorderCategory
        
        //add to scene
        self.addChild(ELlabel)
        
        let soundaction = SKAction.playSoundFileNamed("AreYouReady.aifc", waitForCompletion: false)
        runAction(soundaction)
        
        let action1 = SKAction.moveBy(CGVector(dx:0,dy: -600), duration: 2)
        let action2 = SKAction.applyImpulse(CGVector(dx: 1000,dy: 0), duration: 0.5)
        let action3 = SKAction.applyImpulse(CGVector(dx: -1000,dy: 0), duration: 0.5)
        let action4 = SKAction.applyImpulse(CGVector(dx: -1000,dy: 0), duration: 0.5)
        let action5 = SKAction.applyImpulse(CGVector(dx: 1000,dy: 0), duration: 0.5)
        let action6 = SKAction.moveTo(CGPoint(x: 340, y: 1100), duration: 0.1)
        let action7 = SKAction.moveTo(CGPoint(x: 740, y: 1100), duration: 0.1)
        let action8 = SKAction.rotateByAngle(1.571, duration: 1)
        
        //let actionwait = SKAction.waitForDuration(0.5)
        let sequence1 = SKAction.sequence([soundaction, action1, action2, action4, action2, action4, action2, action4, action6])
        let sequence2 = SKAction.sequence([action1, action3, action5, action3, action5,
            action3, action5, action7])
        
        DUlabel.runAction(sequence1, completion: {
            DUlabel.physicsBody?.pinned = true
            DUlabel.position = CGPoint(x: 420, y: 1100)
            print ("moved label")
            })
        
        ELlabel.runAction(sequence2, completion: {
            ELlabel.physicsBody?.pinned = true
            ELlabel.position = CGPoint(x: 680, y: 1100)
            ELlabel.physicsBody?.allowsRotation = true
            ELlabel.runAction(action8, completion: {
                ELlabel.zRotation = 1.571
            })
            
            
        })
        
        
            
        //ELlabel.runAction(sequence2)
        
        
        
    
    }
    
//    func randomDirection() -> CGFloat {
//        let speedFactor: CGFloat = 1.0
//        if self.randomFloat(from: 500.00, to: 1000.0) >= 50 {
//            return -speedFactor
//        } else {
//            return speedFactor
//        }
//    }
//    
//    func randomFloat(from from:CGFloat, to:CGFloat) -> CGFloat {
//        let rand:CGFloat = CGFloat(Float(arc4random()) / 0xFFFFFFFF)
//        return (rand) * (to - from) + from
//    }
    
    //did begin contact class, called when ball hits an object with a different category mask
    func didBeginContact(contact: SKPhysicsContact) {
        
        //bodyA is the object that has been hit
        //bodyB is the object that has hit
        
        //test if bodyA (the hit object) is a brick, if it is then....
//        if contact.bodyA.categoryBitMask == DULabelCategory | ELLabelCategory {
//            
//            let action1 = SKAction.applyImpulse(CGVector(dx: 250,dy: 0), duration: 0.5)
//            let action2 = SKAction.applyImpulse(CGVector(dx: -250,dy: 0), duration: 0.5)
//            let actionwait = SKAction.waitForDuration(0.0)
//            let action3 = SKAction.applyImpulse(CGVector(dx: 600,dy: 0), duration: 0.5)
//            let action4 = SKAction.applyImpulse(CGVector(dx: -600,dy: 0), duration: 0.5)
//            let sequence1 = SKAction.sequence([action1,actionwait,action3])
//            let sequence2 = SKAction.sequence([action2,actionwait,action4])
//        
//            contact.bodyB.node!.runAction(sequence2)
//            contact.bodyA.node!.runAction(sequence1)
//            //contact.bodyB.node!.runAction(SKAction.repeatAction(sequence1, count: 10))
//        }
//        
//        else if contact.bodyA.categoryBitMask == BorderCategory {
//            
//            if contact.bodyB.node!.name == "DU" {
//                contact.bodyB.node!.runAction(SKAction.applyImpulse(CGVector(dx: 750,dy: 0), duration: 0.5))
//            }
//            else if contact.bodyB.node!.name == "EL" {
//                contact.bodyB.node!.runAction(SKAction.applyImpulse(CGVector(dx: -750,dy: 0), duration: 0.5))
//            }
//        }
//        
    }
}
