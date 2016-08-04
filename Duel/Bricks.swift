//
//  Bricks.swift
//  Duel
//
//  Created by Steven Gooday on 26/07/2016.
//  Copyright © 2016 DT5Ravens. All rights reserved.
//
import SpriteKit
import UIKit

let BallCategory:UInt32 = 0x1 << 0 // 1
let BrickCategory:UInt32 = 0x1 << 1 // 2
let BottomCategory:UInt32 = 0x1 << 2 // 4

class Bricks: SKScene, SKPhysicsContactDelegate {
    
    var isFingerOnPaddle = false

    var Ball:SKSpriteNode!
    var Paddle:SKSpriteNode!
    var Brick_1:SKSpriteNode!
    var Brick_2:SKSpriteNode!
    var TouchLocation:CGPoint = CGPointZero
    
    override func didMoveToView(view: SKView) {
        
        //set up frame around full game scene
        let borderBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        //set border friction to zero, removing physics
        borderBody.friction = 0
        self.physicsBody = borderBody
        
        //set up a frame along the bottom of the gamescene to detect collisons
        let bottomRect = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: 1)
        //declare bottom as a node
        let bottom = SKNode()
        //set physics body for node/bottom
        bottom.physicsBody = SKPhysicsBody(edgeLoopFromRect: bottomRect)
        //add bottom line to the scene
        addChild(bottom)
        
        Ball = self.childNodeWithName("Ball") as! SKSpriteNode
        Paddle = self.childNodeWithName("Paddle") as! SKSpriteNode
        Brick_1 = self.childNodeWithName("Brick_1") as! SKSpriteNode
        Brick_2 = self.childNodeWithName("Brick_2") as! SKSpriteNode
        
        self.physicsWorld.contactDelegate = self
        
        Ball.physicsBody?.applyImpulse(CGVector(dx: 100, dy: 250))
        Ball.physicsBody?.friction = 0
        Ball.physicsBody?.restitution = 1
        Ball.physicsBody?.linearDamping = 0
        Ball.physicsBody?.angularDamping = 0
        
        Ball.physicsBody!.categoryBitMask = BallCategory
        Brick_1.physicsBody!.categoryBitMask = BrickCategory
        Brick_2.physicsBody!.categoryBitMask = BrickCategory
        bottom.physicsBody!.categoryBitMask = BottomCategory
        
        Ball.physicsBody!.contactTestBitMask = BrickCategory|BottomCategory
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        let touchlocation = touch!.locationInNode(self)
        
        
        
        if let body = physicsWorld.bodyAtPoint(touchlocation){
            //print (body.node!.name)
            if body.node!.name == "Paddle" {
                //print (touchlocation)
            
                //print ("Began tocuhing paddle")
                isFingerOnPaddle = true
            }
        }
        
        //TouchLocation = touches.first!.locationInNode(self)
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        // check if finger is on the paddle node
        if isFingerOnPaddle {
            
            TouchLocation = touches.first!.locationInNode(self)
            
            //Set up touch and touch location as variables
//            let touch = touches.first
//            let touchlocation = touch!.locationInNode(self)
//            
//            //Set up previous location and identify paddle object
//            let previousLocation = touch!.previousLocationInNode(self)
//            let paddle = childNodeWithName("Paddle") as! SKSpriteNode
//            
//            
//            var paddlex = paddle.position.x + (touchlocation.x - previousLocation.x)
//            print ("0", paddlex)
//            
//            paddlex = max(paddlex, paddle.size.width / 2)
//            print ("1", paddlex)
//            paddlex = min(paddlex, size.width - paddle.size.width / 2)
//            print ("2", paddlex)
//            
//            paddle.position = CGPoint(x: paddlex, y: paddle.position.y)
            //print(paddle.position)
        }
        
     
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        isFingerOnPaddle = false
    }
    
    override func update(currentTime: CFTimeInterval) {
        Paddle.position.x = TouchLocation.x
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
    
        if contact.bodyA.categoryBitMask == BrickCategory {
                contact.bodyA.node!.removeFromParent()
        }
        else if contact.bodyA.categoryBitMask == BottomCategory {
        //print ("Hit bottom")
        }
        
    }
    
}
