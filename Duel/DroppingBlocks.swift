//
//  DroppingBlocks.swift
//  Duel
//
//  Created by Steven Gooday on 19/08/2016.
//  Copyright © 2016 DT5Ravens. All rights reserved.
//

import UIKit
import SpriteKit

class DroppingBlocks: SKScene, SKPhysicsContactDelegate {
    
    let PlayerCategory:UInt32 = 0x1 << 1 // 1
    let BlockCategory:UInt32 = 0x1 << 0 // 2
    let BottomCategory:UInt32 = 0x1 << 2 // 4
    
    var isfingeronplayer = false
    var TouchLocation:CGPoint = CGPointZero
    
    //didmovetoview function, called when view loads
    override func didMoveToView(view: SKView) {
    
        //set initial physics of gamescene
        self.physicsWorld.contactDelegate = self
        
        //set scene gravity
        scene?.physicsWorld.gravity = CGVector(dx: 0, dy: -1)
        
        //add borders around frame and apply physics to bottom
        addBorders()
        
        //add player object
        addPlayer()
        
        //add starting block
        addFallingBlock()
    
    }
    
    //custom class to add borders to game scene
    func addBorders() {
        
        //set up frame around full game scene
        //let borderBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        //set border friction to zero, removing physics
        //borderBody.friction = 0
        //self.physicsBody = borderBody
        //borderBody.categoryBitMask = BottomCategory
        //set up a frame along the bottom of the gamescene to detect collisons
        let bottomRect = SKShapeNode(rectOfSize: CGSize(width: frame.size.width, height: 100))
        bottomRect.position = CGPoint(x: frame.size.width/2, y: 200)
        bottomRect.fillColor = SKColor.blueColor()
        //declare bottom as a node
        //let bottom = SKNode()
       //set physics body for node/bottom
        bottomRect.physicsBody = SKPhysicsBody(rectangleOfSize: bottomRect.frame.size)
        bottomRect.physicsBody?.pinned = true
        bottomRect.physicsBody?.allowsRotation = false
        //add bottom line to the scene
        addChild(bottomRect)
        
        //apply intialised physics categories to their objects
        bottomRect.physicsBody!.categoryBitMask = BottomCategory
        
    }
    
    //custom class to add paddle
    func addPlayer() {
        
        let player = SKShapeNode(circleOfRadius: 75)
        player.fillColor = SKColor.blueColor()
        
        player.position = CGPoint(x: 750, y: 500)
        player.name = "player"
        player.physicsBody = SKPhysicsBody(circleOfRadius: 75)
        player.physicsBody?.categoryBitMask = PlayerCategory
        player.physicsBody!.affectedByGravity = false
        player.physicsBody!.dynamic = true
        addChild(player)
        
    }
    
    //add custom block
    func addFallingBlock() {
    let fallingblock = SKShapeNode(rectOfSize: CGSize(width: randomInt(50, max: 75), height: randomInt(50, max: 75)))
    //set the brick position
    fallingblock.position = CGPoint(x: randomInt(100, max: 900), y: 1800)
    fallingblock.fillColor = SKColor.darkGrayColor()
    fallingblock.physicsBody = SKPhysicsBody(rectangleOfSize: fallingblock.frame.size)
    fallingblock.physicsBody!.affectedByGravity = true
    fallingblock.name = "fallingblock"
    fallingblock.physicsBody!.categoryBitMask = BlockCategory
    fallingblock.physicsBody!.restitution = 0
    //fallingblock.zPosition = 2
    fallingblock.physicsBody?.contactTestBitMask = PlayerCategory|BottomCategory
    addChild(fallingblock)
        
    }
    
    //touches began class, called when user first touches the screen anywhere
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //declare touch and touch location
        let touch = touches.first
        let touchlocation = touch!.locationInNode(self)
        let body = physicsWorld.bodyAtPoint(touchlocation)
        
        if body?.node!.name == "player" {
            
            isfingeronplayer = true
        
        }
    }
    
        //touches moved class, called when the users moves once they have touched the screen anywhere
        override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
            
            // check if finger is on the player node, set in touches began class
            if isfingeronplayer {
                
                //this code moves the paddle, but we don't know why yet
                TouchLocation = touches.first!.locationInNode(self)
                //print(TouchLocation)
                
                //Set up touch and touch location as variables
                //let touch = touches.first
                //let touchlocation = touch!.locationInNode(self)
                //let player = childNodeWithName("player") as! SKShapeNode
                
                //Set up previous location and identify paddle object
                //let previousLocation = touch!.previousLocationInNode(self)
                
                //let playerx = player.position.x + (touchlocation.x - previousLocation.x)
                //player.position = CGPoint(x: playerx, y: player.position.y)
                
            }
            
        }
        
        //touches ended class, called when touch is released
        override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
            
            //set isFingerOnPaddle variable to false
            isfingeronplayer = false
            
        }
    
    //update class, also used in moving the paddle
    override func update(currentTime: CFTimeInterval) {
        let player = childNodeWithName("player") as! SKShapeNode
        player.position = TouchLocation
    }
    
    //did begin contact class, called when ball hits an object with a different category mask
    func didBeginContact(contact: SKPhysicsContact) {
        
        //bodyA is the object that has been hit
        //bodyB is the object that has hit
        
        //test if bodyA (the hit object) is a brick, if it is then....
        if contact.bodyA.categoryBitMask == BottomCategory {
            if contact.bodyB.categoryBitMask == BlockCategory {
                // Testing if node exists and then removes if it does
                contact.bodyB.node?.removeFromParent()
                // add another block
                print("Block added")
                addFallingBlock()
            }
            
        }
        
    }
    
    //returns a random integer between the passed min and maximum values
    func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
}
