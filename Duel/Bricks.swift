//Brick Breaker Class

//import spritekit
import SpriteKit
import GameplayKit

//intialise physics categories for each spritenode
let BallCategory:UInt32 = 0x1 << 0 // 1
let BrickCategory:UInt32 = 0x1 << 1 // 2
let BottomCategory:UInt32 = 0x1 << 2 // 4
let PaddleCategory:UInt32 = 0x1 << 3 // 8

//main class
class Bricks: SKScene, SKPhysicsContactDelegate {
    
    //intialise variables and objects
    var isFingerOnPaddle = false
    var TouchLocation:CGPoint = CGPointZero
    
    lazy var gameState:GKStateMachine = GKStateMachine(states:[WaitingForTap(scene: self),Playing(scene:self),GameOver(scene:self)])
    
    
    //didmovetoview function, called when view loads
    override func didMoveToView(view: SKView) {
        
        //set initial physics of gamescene
        self.physicsWorld.contactDelegate = self
        
        gameState.enterState(WaitingForTap)
        
        //add borders around frame and apply physics to bottom
        addBorders()

        //add ball to the game scene
        addBall(CGPoint(x: 100,y: 100), BallColor:SKColor.blueColor())
        //addBall(CGPoint(x: 150,y: 150), BallColor:SKColor.redColor())
        
        //add bricks to game scene
        addBlocks(8,yPosition: 0.95)
        addBlocks(8,yPosition: 0.90)
        addBlocks(6,yPosition: 0.85)
        addBlocks(6,yPosition: 0.80)
        addBlocks(4,yPosition: 0.75)
        addBlocks(4,yPosition: 0.70)
        
        //add paddle to game scene
        addPaddle()
        
    }
    
    //custom class to add borders to game scene
    func addBorders() {
        
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
        
        //apply intialised physics categories to their objects
        bottom.physicsBody!.categoryBitMask = BottomCategory
        
    }
    
    //custom class to add paddle
    func addPaddle() {
        
        let paddle = SKSpriteNode(imageNamed: "Paddle")
        //let paddle = SKShapeNode(rectOfSize: CGSize(width: 305, height: 75), cornerRadius: 20)
        //paddle.fillColor = SKColor.brownColor()
        paddle.position = CGPoint(x: 540, y: 63)
        paddle.name = "paddle"
        //paddle.physicsBody = SKPhysicsBody(rectangleOfSize: paddle.frame.size)
        paddle.physicsBody = SKPhysicsBody(circleOfRadius: 150)
        paddle.physicsBody?.categoryBitMask = PaddleCategory
        paddle.physicsBody!.affectedByGravity = false
        paddle.physicsBody!.dynamic = false
        addChild(paddle)
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
        ball.physicsBody!.mass = 0.34
        ball.physicsBody!.dynamic = true
        ball.physicsBody!.affectedByGravity = true
        ball.physicsBody!.friction = 0.0
        ball.physicsBody!.restitution = 1
        ball.physicsBody!.linearDamping = 0.0
        ball.physicsBody!.angularDamping = 0.0
        
        ball.name = "ball"
        
        //apply ball category to category mask of the object
        ball.physicsBody!.categoryBitMask = BallCategory
        
        //apply contact physics to the ball when it collides with.....
        ball.physicsBody!.contactTestBitMask = BrickCategory|BottomCategory
        
        //add object to game scene
        addChild(ball)
        //ball.physicsBody!.applyImpulse(CGVector(dx: 300, dy: 300))
    }

    //custom function, adds the number of blocks passed to the game
    func addBlocks(NoofBlocks: UInt32, yPosition: CGFloat) {
        
        //establish width of brick image
        let blockWidth = self.size.width / CGFloat(NoofBlocks)
        
        //establish total block width, no of blocks time block width
        let totalBlocksWidth = blockWidth * CGFloat(NoofBlocks)
        
        //establish x offset, width of frame - total block width divided by 2
        let xOffset = (CGRectGetWidth(frame) - totalBlocksWidth) / 2
        
        //loop through 1 to no of blocks
        for i in 0..<NoofBlocks {
            
                //define new sk sprite node for the brick using the image as a base
            let brick = SKShapeNode(rectOfSize: CGSize(width: blockWidth, height: 100))
                //set the brick position
                brick.position = CGPoint(x: xOffset + CGFloat(CGFloat(i) + 0.5) * blockWidth, y: CGRectGetHeight(frame)*yPosition)
                brick.fillColor = SKColor.darkGrayColor()
                brick.physicsBody = SKPhysicsBody(rectangleOfSize: brick.frame.size)
                brick.physicsBody!.allowsRotation = false
                brick.physicsBody!.friction = 0.0
                brick.physicsBody!.affectedByGravity = false
                brick.physicsBody!.dynamic = false
                brick.name = "Brick"
                brick.physicsBody!.categoryBitMask = BrickCategory
                brick.zPosition = 2
                addChild(brick)
        }
       
    }
    
    //touches began class, called when user first touches the screen anywhere
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //declare touch and touch location
        let touch = touches.first
        let touchlocation = touch!.locationInNode(self)
        let body = physicsWorld.bodyAtPoint(touchlocation)
        
        //test current state and if in waiting for tap state then switch to playing
        switch gameState.currentState {
            case is WaitingForTap:
                
                //test if the body touched is the ball
                if body?.node!.name == "ball" {
                    
                    //Set game state to playing
                    gameState.enterState(Playing)
                    
                }
            
            case is Playing:
    
                 //if the user has touched the paddle then....
                if body?.node!.name == "paddle" {
                
                //set the isFingerOnPaddle variable to true
                isFingerOnPaddle = true
                    
                }
            
            case is GameOver:
                
            let newscene = MainMenu(fileNamed: "MainMenu")
            newscene!.scaleMode = .AspectFill
            let reveal = SKTransition.flipHorizontalWithDuration(0.5)
            self.view?.presentScene(newscene!, transition: reveal)
            
        default:break
            
        }
    }
    
    //touches moved class, called when the users moves once they have touched the screen anywhere
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        // check if finger is on the paddle node, set in touches began class
        if isFingerOnPaddle {
            //print(isFingerOnPaddle)
            
            //this code moves the paddle, but we don't know why yet
            TouchLocation = touches.first!.locationInNode(self)
            //print(TouchLocation)
            
            //Set up touch and touch location as variables
            let touch = touches.first
            let touchlocation = touch!.locationInNode(self)
            let paddle = childNodeWithName("paddle") as! SKSpriteNode
            
           //Set up previous location and identify paddle object
            let previousLocation = touch!.previousLocationInNode(self)
            
            let paddlex = paddle.position.x + (touchlocation.x - previousLocation.x)
            paddle.position = CGPoint(x: paddlex, y: paddle.position.y)
            
        }
        
    }
    
    //touches ended class, called when touch is released
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //set isFingerOnPaddle variable to false
        isFingerOnPaddle = false
        
    }
    
    //update class, also used in moving the paddle
    override func update(currentTime: CFTimeInterval) {
        //Paddle.position.x = TouchLocation.x
    }
    
    //did begin contact class, called when ball hits an object with a different category mask
    func didBeginContact(contact: SKPhysicsContact) {
        
        //bodyA is the object that has been hit
        //bodyB is the object that has hit
        
        //test if bodyA (the hit object) is a brick, if it is then....
        if contact.bodyA.categoryBitMask == BrickCategory {
                //remove brick from gamescene
//            if contact.bodyA.node != nil {
//            contact.bodyA.node!.removeFromParent()
//            }
            
            // Testing if node exists and then removes if it does
            contact.bodyA.node?.removeFromParent()
            let action = SKAction.playSoundFileNamed("SwishTrimmed.m4a", waitForCompletion: false)
            runAction(action)
        }
        //test if bodyA is the bottom border of the screen, if it is then....
        else if contact.bodyA.categoryBitMask == BottomCategory {
            
            gameState.enterState(GameOver)
            
        //addBall(CGPoint(x: 100,y: 100), BallColor:SKColor.blueColor())
        //addBall(CGPoint(x: 150,y: 150), BallColor:SKColor.redColor())
    
        }
        
    }
    
}
