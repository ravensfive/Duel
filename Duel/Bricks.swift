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
    var Brick:SKSpriteNode!
    var TouchLocation:CGPoint = CGPointZero
    
    override func didMoveToView(view: SKView) {
        Ball = self.childNodeWithName("Ball") as! SKSpriteNode
        Paddle = self.childNodeWithName("Paddle") as! SKSpriteNode
        Brick = self.childNodeWithName("Brick_1") as! SKSpriteNode
        
        self.physicsWorld.contactDelegate = self
        
        Ball.physicsBody?.applyImpulse(CGVector(dx: 100, dy: 250))
        
        Ball.physicsBody!.categoryBitMask = BallCategory
        Brick.physicsBody!.categoryBitMask = BrickCategory
        
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
