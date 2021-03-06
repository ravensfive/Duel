//
//  DroppingBlocks.swift
//  Duel
//
//  Created by Steven Gooday on 19/08/2016.
//  Copyright © 2016 DT5Ravens. All rights reserved.

//Actions in progress


import UIKit
import SpriteKit
import GameKit

class DroppingBlocks: SKScene, SKPhysicsContactDelegate {
    
    
    let BlockCategory:UInt32 = 0x1 << 0 // 1
    let PlayerCategory:UInt32 = 0x1 << 1 // 2
    let BottomCategory:UInt32 = 0x1 << 2 // 4
    
    var isfingeronplayer = false
    var TouchLocation:CGPoint = CGPoint.zero
    
    lazy var gameState:GKStateMachine = GKStateMachine(states:[WaitingForTap(scene: self),Playing(scene:self),GameOver(scene:self)])
    
    //didmovetoview function, called when view loads
    override func didMove(to view: SKView) {
    
        //set initial physics of gamescene
        self.physicsWorld.contactDelegate = self
        
        gameState.enter(WaitingForTap.self)
        
        //set scene gravity
        scene?.physicsWorld.gravity = CGVector(dx: 0, dy: -3)
        
        //add borders around frame and apply physics to bottom
        addBorders()
        
        //add player object
        addPlayer()
    
    }
    
    //custom class to add borders to game scene
    func addBorders() {
        
        //set up frame around full game scene
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        //set border friction to zero, removing physics
        borderBody.friction = 0
        self.physicsBody = borderBody
        
        //set up a frame along the bottom of the gamescene to detect collisons
        let bottomRect = SKShapeNode(rectOf: CGSize(width: frame.size.width, height: 5))
        bottomRect.position = CGPoint(x: frame.size.width/2, y: frame.origin.y)
        bottomRect.fillColor = SKColor.clear
        //declare bottom as a node
        //let bottom = SKNode()
       //set physics body for node/bottom
        bottomRect.physicsBody = SKPhysicsBody(rectangleOf: bottomRect.frame.size)
        bottomRect.physicsBody?.pinned = true
        bottomRect.physicsBody?.allowsRotation = false
        bottomRect.name = "bottom"
        //add bottom line to the scene
        addChild(bottomRect)
        
        //apply intialised physics categories to their objects
        bottomRect.physicsBody!.categoryBitMask = BottomCategory
        
    }
    
    //custom class to add paddle
    func addPlayer() {
        
        let player = SKShapeNode(circleOfRadius: 50)
        player.position = CGPoint(x: frame.size.width/2, y: 25)
        player.fillColor = SKColor.red
        player.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        player.physicsBody!.categoryBitMask = PlayerCategory
        player.name = "player"
        player.physicsBody!.affectedByGravity = false
        player.physicsBody!.isDynamic = true
        self.addChild(player)
        
    }
    
    //add custom block
    func addFallingBlock() {
    let fallingblock = SKShapeNode(rectOf: CGSize(width: randomInt(100, max:1000), height: randomInt(20, max: 250)))
    //set the brick position
    fallingblock.position = CGPoint(x: randomInt(100, max: 900), y: 1900)
    fallingblock.fillColor = SKColor.darkGray
    fallingblock.physicsBody = SKPhysicsBody(rectangleOf: fallingblock.frame.size)
    fallingblock.physicsBody!.affectedByGravity = true
    fallingblock.name = "fallingblock"
    fallingblock.physicsBody!.categoryBitMask = BlockCategory
    fallingblock.physicsBody!.mass = 0.1
    fallingblock.physicsBody!.restitution = 0
    
    fallingblock.physicsBody?.contactTestBitMask = PlayerCategory|BottomCategory
    addChild(fallingblock)
    
    fallingblock.physicsBody!.applyImpulse(CGVector(dx: 0, dy: randomInt(0, max: 300)))
    }
    
    //touches began class, called when user first touches the screen anywhere
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //declare touch and touch location
        let touch = touches.first
        let touchlocation = touch!.location(in: self)
        let body = physicsWorld.body(at: touchlocation)
        
        //test current state and if in waiting for tap state then switch to playing
        switch gameState.currentState {
        case is WaitingForTap:
            
            //test if the body touched is the ball
            if body?.node!.name == "player" {
                
                //Set game state to playing
                gameState.enter(Playing.self)
                
            }
            
        case is Playing:
            
            if body?.node!.name == "player" {
                
                isfingeronplayer = true
                
            }
            
        case is GameOver:
            
            let newscene = MainMenu(fileNamed: "MainMenu")
            newscene!.scaleMode = .aspectFill
            let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
            self.view?.presentScene(newscene!, transition: reveal)
            
        default:break
            
        }

    }
    
        //touches moved class, called when the users moves once they have touched the screen anywhere
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            
            // check if finger is on the player node, set in touches began class
            if isfingeronplayer {
                
                //this code sets the touch location of the touch
                TouchLocation = touches.first!.location(in: self)
                
                //this defines the object thats been touched and moves the object to the new location (with the finger)
                let player = childNode(withName: "player") as? SKShapeNode
                player?.position = TouchLocation
                
            }
            
        }
        
        //touches ended class, called when touch is released
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            
            //set isFingerOnPaddle variable to false
            isfingeronplayer = false
            
        }
    
    //update class, also used in moving the paddle
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    //did begin contact class, called when ball hits an object with a different category mask
    func didBegin(_ contact: SKPhysicsContact) {
        
        //bodyA is the object that has been hit
        //bodyB is the object that has hit
        
        //test if bodyA (the hit object) is a brick, if it is then....
        if contact.bodyA.categoryBitMask == BottomCategory {
            if contact.bodyB.categoryBitMask == BlockCategory {
                // Testing if node exists and then removes if it does
                contact.bodyB.node?.removeFromParent()
                // add another block
                addFallingBlock()
            }
        }
        else if contact.bodyB.categoryBitMask == PlayerCategory {
            
            gameState.enter(GameOver.self)
            
        }
        
    }
    
    //returns a random integer between the passed min and maximum values
    func randomInt(_ min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
}
