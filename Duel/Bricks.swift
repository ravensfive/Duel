//
//  Bricks.swift
//  Duel
//
//  Created by Steven Gooday on 26/07/2016.
//  Copyright © 2016 DT5Ravens. All rights reserved.
//
import SpriteKit
import UIKit

class Bricks: SKScene {

    var Ball:SKSpriteNode!
    var Paddle:SKSpriteNode!
    var TouchLocation:CGPoint = CGPointZero
    
    override func didMoveToView(view: SKView) {
        Ball = self.childNodeWithName("Ball") as! SKSpriteNode
        Paddle = self.childNodeWithName("Paddle") as! SKSpriteNode
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        TouchLocation = touches.first!.locationInNode(self)
        //Ball.physicsBody?.applyImpulse(CGVector(dx: 100, dy: 2500))
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        TouchLocation = touches.first!.locationInNode(self)
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        Paddle.position.x = TouchLocation.x
    }
    
}
