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

class Bricks: SKScene, SKPhysicsContactDelegate {

    var Ball:SKSpriteNode!
    var Paddle:SKSpriteNode!
    var Brick_1:SKSpriteNode!
    var Brick_2:SKSpriteNode!
    var TouchLocation:CGPoint = CGPointZero
    
    override func didMoveToView(view: SKView) {
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
        
        Ball.physicsBody!.contactTestBitMask = BrickCategory
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        TouchLocation = touches.first!.locationInNode(self)
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        TouchLocation = touches.first!.locationInNode(self)
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        Paddle.position.x = TouchLocation.x
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
    
        if contact.bodyA.categoryBitMask == BrickCategory {
                contact.bodyA.node!.removeFromParent()
        }
    
        print(contact.bodyA.categoryBitMask)
        print(contact.bodyB.categoryBitMask)
        
    }
    
}
