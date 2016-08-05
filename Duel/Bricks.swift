//Brick Breaker Class

//import spritekit
import SpriteKit

//intialise physics categories for each spritenode
let BallCategory:UInt32 = 0x1 << 0 // 1
let BrickCategory:UInt32 = 0x1 << 1 // 2
let BottomCategory:UInt32 = 0x1 << 2 // 4

//main class
class Bricks: SKScene, SKPhysicsContactDelegate {
    
    //intialise variables and objects
    var isFingerOnPaddle = false
    var Ball:SKSpriteNode!
    var Paddle:SKSpriteNode!
    var Brick_1:SKSpriteNode!
    var Brick_2:SKSpriteNode!
    var TouchLocation:CGPoint = CGPointZero
    
    //didmovetoview function, called when view loads
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
        
        //allocate objects to initialised objects
        Ball = self.childNodeWithName("Ball") as! SKSpriteNode
        Paddle = self.childNodeWithName("Paddle") as! SKSpriteNode
        Brick_1 = self.childNodeWithName("Brick_1") as! SKSpriteNode
        Brick_2 = self.childNodeWithName("Brick_2") as! SKSpriteNode
        
        //set initial physics of gamescene
        self.physicsWorld.contactDelegate = self
        
        //set intial physics of ball
        Ball.physicsBody?.friction = 0
        Ball.physicsBody?.restitution = 1
        Ball.physicsBody?.linearDamping = 0
        Ball.physicsBody?.angularDamping = 0
        
        //apply intialised physics categories to their objects
        Ball.physicsBody!.categoryBitMask = BallCategory
        Brick_1.physicsBody!.categoryBitMask = BrickCategory
        Brick_2.physicsBody!.categoryBitMask = BrickCategory
        bottom.physicsBody!.categoryBitMask = BottomCategory
        
        //apply contact physics to the ball when it collides with.....
        Ball.physicsBody!.contactTestBitMask = BrickCategory|BottomCategory
        
    }
    
    //touches began class, called when user first touches the screen anywhere
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //declare touch and touch location
        let touch = touches.first
        let touchlocation = touch!.locationInNode(self)
        
        //test if user has touched an object
        if let body = physicsWorld.bodyAtPoint(touchlocation){
            
            //if the user has touched the paddle then....
            if body.node!.name == "Paddle" {
                
                //set the isFingerOnPaddle variable to true
                isFingerOnPaddle = true
            }
            
            //if the user has touched the ball then....
            if body.node!.name == "Ball" {
            
                //if the ball is currently not moving, then apply impulse to ball
                if Ball.physicsBody!.velocity.dx == 0.0 || Ball.physicsBody!.velocity.dy == 0.0 {
                        Ball.physicsBody?.applyImpulse(CGVector(dx: 100, dy: 250))
                }
                
            }
        }
        
    }
    //touches moved class, called when the users moves once they have touched the screen anywhere
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        // check if finger is on the paddle node, set in touches began class
        if isFingerOnPaddle {
            
            //this code moves the paddle, but we don't know why yet
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
    
    //touches ended class, called when touch is released
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //set isFingerOnPaddle variable to false
        isFingerOnPaddle = false
        
    }
    
    //update class, also used in moving the paddle
    override func update(currentTime: CFTimeInterval) {
        Paddle.position.x = TouchLocation.x
    }
    
    //did begin contact class, called when ball hits an object with a different category mask
    func didBeginContact(contact: SKPhysicsContact) {
        
        //bodyA is the object that has been hit
        //bodyB is the object that has hit
        
        //test if bodyA (the hit object) is a brick, if it is then....
        if contact.bodyA.categoryBitMask == BrickCategory {
                //remove brick from gamescene
                contact.bodyA.node!.removeFromParent()
        }
        //test if bodyA is the bottom border of the screen, if it is then....
        else if contact.bodyA.categoryBitMask == BottomCategory {
        //print ("Hit bottom")
        }
        
    }
    
}
