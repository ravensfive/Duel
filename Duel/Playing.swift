//
//  Playing.swift
//  Duel
//
//  Created by Steven Gooday on 12/08/2016.
//  Copyright © 2016 DT5Ravens. All rights reserved.
//

import SpriteKit
import GameplayKit

class Playing: GKState {
    unowned let scene: Bricks
    
    init(scene: SKScene) {
        self.scene = scene as! Bricks
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        if previousState is WaitingForTap {
            
        
            
            let ball = scene.childNode(withName: "ball") as! SKShapeNode
            ball.physicsBody!.applyImpulse(CGVector(dx: 300, dy: 300))
        }
    }
    
    override func update(deltaTime seconds: TimeInterval) {
//        let ball = scene.childNodeWithName("ball") as! SKSpriteNode
//        
//        let maxSpeed: CGFloat = 10
//        
//        let xSpeed = sqrt(ball.physicsBody!.velocity.dx * ball.physicsBody!.velocity.dx)
//        let ySpeed = sqrt(ball.physicsBody!.velocity.dy * ball.physicsBody!.velocity.dy)
//        
//        let speed = sqrt(ball.physicsBody!.velocity.dx * ball.physicsBody!.velocity.dx + ball.physicsBody!.velocity.dy * ball.physicsBody!.velocity.dy)
        
//        if xSpeed <= 10.0 {
//            ball.physicsBody!.applyImpulse(CGVector(dx: randomDirection(), dy: 0.0))
//        }
//        if ySpeed <= 10.0 {
//            ball.physicsBody!.applyImpulse(CGVector(dx: 0.0, dy: randomDirection()))
//        }
//        
//        if speed > maxSpeed {
//            ball.physicsBody!.linearDamping = 0.4
//        }
//        else {
//            ball.physicsBody!.linearDamping = 0.0
        //}
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is GameOver.Type
    }
    
//    func randomDirection() -> CGFloat {
//        let speedFactor: CGFloat = 1.0
//        if scene.randomFloat(from: 0.0, to: 100.0) >= 50 {
//            return -speedFactor
//        } else {
//            return speedFactor
//        }
    }
    

