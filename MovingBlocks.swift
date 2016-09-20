//
//  MovingBlocks.swift
//  Duel
//
//  Created by Steven Gooday on 13/09/2016.
//  Copyright © 2016 DT5Ravens. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit

class MovingBlocks: SKScene, SKPhysicsContactDelegate {
    
    let PlayerCategory:UInt32 = 0x1 << 0 // 1
    let BallCategory:UInt32 = 0x1 << 1 // 2
    let GoalCategory:UInt32 = 0x1 << 2 // 4

    var isfingeronplayer = false
    var TouchLocation:CGPoint = CGPointZero
    
    lazy var gameStateMB:GKStateMachine = GKStateMachine(states:[WaitingForTapMB(scene: self),PlayingMB(scene:self),GameOverMB(scene:self)])
    
    //didmovetoview function, called when view loads
    override func didMoveToView(view: SKView) {
        
        //set initial physics of gamescene
        self.physicsWorld.contactDelegate = self
        
        gameStateMB.enterState(WaitingForTapMB)
        
        //set scene gravity
        scene?.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        //add borders around frame and apply physics to bottom
        addBorders()
        
        //add player object
        addPlayer()
        
        //add ball object
        addBall(CGPoint(x: 500,y: 500), BallColor:SKColor.blueColor())
        
    }
    
    //custom class to add borders to game scene
    func addBorders() {
        
        //set up frame around full game scene
        let borderBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        //set border friction to zero, removing physics
        borderBody.friction = 0
        self.physicsBody = borderBody
        
    }
    
    //custom class to add paddle
    func addPlayer() {
        
        let player = SKShapeNode(circleOfRadius: 50)
        player.position = CGPoint(x: frame.size.width/2, y: 25)
        player.fillColor = SKColor.redColor()
        player.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        player.physicsBody!.categoryBitMask = PlayerCategory
        player.name = "player"
        player.physicsBody!.affectedByGravity = false
        player.physicsBody!.dynamic = true
        self.addChild(player)
        
    }
    
    //custom function, adds a ball at the cordinates passed through
    func addBall(Location:CGPoint, BallColor:SKColor) {
        
        //define new sk sprite node with Ball.png as a base
        let ball = SKShapeNode(circleOfRadius: 25)
        ball.fillColor = BallColor
        
        //set location to the passed CGPoint
        ball.position = Location
        //set up physics body around image
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        //set intial physics of ball
        ball.physicsBody!.mass = 0.10
        ball.physicsBody!.dynamic = true
        //ball.physicsBody!.affectedByGravity = true
        //ball.physicsBody!.friction = 0.0
        //ball.physicsBody!.restitution = 1
        //ball.physicsBody!.linearDamping = 1
        //ball.physicsBody!.angularDamping = 0.0
        
        ball.name = "ball"
        
        //apply ball category to category mask of the object
        ball.physicsBody!.categoryBitMask = BallCategory
        
        //apply contact physics to the ball when it collides with.....
        ball.physicsBody!.contactTestBitMask = GoalCategory
        
        //add object to game scene
        addChild(ball)
        //ball.physicsBody!.applyImpulse(CGVector(dx: 300, dy: 300))
        
}
    //touches began class, called when user first touches the screen anywhere
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print(gameStateMB.currentState)
        
        //declare touch and touch location
        let touch = touches.first
        let touchlocation = touch!.locationInNode(self)
        let body = physicsWorld.bodyAtPoint(touchlocation)
        
        //test current state and if in waiting for tap state then switch to playing
        switch gameStateMB.currentState {
        case is WaitingForTapMB:
            
            //test if the body touched is the ball
            if body?.node!.name == "player" {
                
                //Set game state to playing
                gameStateMB.enterState(PlayingMB)
                
            }
            
        case is PlayingMB:
            
            if body?.node!.name == "player" {
                print(isfingeronplayer)
                isfingeronplayer = true
                
            }
            
        case is GameOverMB:
            
            let newscene = MainMenu(fileNamed: "MainMenu")
            newscene!.scaleMode = .AspectFill
            let reveal = SKTransition.flipHorizontalWithDuration(0.5)
            self.view?.presentScene(newscene!, transition: reveal)
            
        default:break
            
        }
        
    }
    
    //touches moved class, called when the users moves once they have touched the screen anywhere
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        // check if finger is on the player node, set in touches began class
        if isfingeronplayer {
            
            //this code sets the touch location of the touch
            TouchLocation = touches.first!.locationInNode(self)
            
            //this defines the object thats been touched and moves the object to the new location (with the finger)
            let player = childNodeWithName("player") as! SKShapeNode
            player.position = TouchLocation
            
        }
        
    }
    
    //touches ended class, called when touch is released
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //set isFingerOnPaddle variable to false
        isfingeronplayer = false
        
    }
    
    //update class, also used in moving the paddle
    override func update(currentTime: CFTimeInterval) {
        
    }
}