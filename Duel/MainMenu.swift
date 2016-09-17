//Main Menu class

//  Trying to seperate the sequence logic but although function is firing it is not running the sequence.  Something to do with reference the labels perhaps... **

import SpriteKit
import GameplayKit

//define physics categories
let DULabelCategory:UInt32 = 0x1 << 0 // 1
let ELLabelCategory:UInt32 = 0x1 << 1 // 2
let BorderCategory:UInt32 = 0x1 << 2 // 4

//let ELlabel = SKSpriteNode(imageNamed: "EL")

//main class
class MainMenu: SKScene, SKPhysicsContactDelegate {
   
    //did move to view event, fired when scene initiates
    override func didMoveToView(view: SKView) {
        
        //set scene gravity
        scene?.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        //set physics world
        self.physicsWorld.contactDelegate = self
        
        //format main menu
        FormatMainMenuAction()
        
    }
    
    //touches began class, called when user touches the main menu screen
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //test whether the user has touched the blue circle
        //declare touch and touch location
        let touch = touches.first
        let touchlocation = touch!.locationInNode(self)
        let body = physicsWorld.bodyAtPoint(touchlocation)
        
        //define begin action sound
        let beginaction = SKAction.playSoundFileNamed("Begin.aifc", waitForCompletion: false)
        
        if body?.node!.name == "bricks" {
            
            //run begin action
            runAction(beginaction)
        
            //controlling which game to navigate to
            let game:Bricks = Bricks(fileNamed: "Bricks")!
            
            //set scene scale mode i.e. fill to screen
            game.scaleMode = .AspectFill
    
            //set transition between screens
            let Transition:SKTransition = SKTransition.crossFadeWithDuration(2)
        
            //load game scene
            self.view?.presentScene(game, transition: Transition)
            
        }
            
        else if body?.node!.name == "droppingblocks" {
            
            //run begin action
            runAction(beginaction)
            
            //controlling which game to navigate to
            let game:DroppingBlocks = DroppingBlocks(fileNamed: "DroppingBlocks")!
            
            //set scene scale mode i.e. fill to screen
            game.scaleMode = .AspectFill
            
            //set transition between screens
            let Transition:SKTransition = SKTransition.crossFadeWithDuration(2)
            
            //load game scene
            self.view?.presentScene(game, transition: Transition)
            
        }
        
            
    }
    
    //format main menu, creates and runs opening animation
    func FormatMainMenuAction() {
        
        //set up frame around full game scene
        let borderBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        //set border friction to zero, removing physics
        borderBody.friction = 0
        //define physics for border
        self.physicsBody = borderBody
        borderBody.categoryBitMask = BorderCategory
        
        //add sprite node for DU element
        let DUlabel = SKSpriteNode(imageNamed: "DU")
        
        //set starting position, size and name
        DUlabel.position = CGPoint(x: 280, y: 1700)
        DUlabel.size = CGSize(width: 200, height: 200)
        DUlabel.name = "DU"
        //define physics body and set initial physic parameters
        DUlabel.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 200, height: 200))
        DUlabel.physicsBody!.allowsRotation = false
        DUlabel.physicsBody!.categoryBitMask = DULabelCategory
        DUlabel.physicsBody!.contactTestBitMask = ELLabelCategory|BorderCategory
        
        //add to scene
        self.addChild(DUlabel)
        
        //add sprite node for EL element
        let ELlabel = SKSpriteNode(imageNamed: "EL")
        
        //set starting position, size and name
        ELlabel.position = CGPoint(x:880, y:1700)
        ELlabel.size = CGSize(width: 200, height: 200)
        ELlabel.name = "EL"
        //define physics body and set initial physic parameters
        ELlabel.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 200, height: 200))
        ELlabel.physicsBody!.allowsRotation = false
        ELlabel.physicsBody!.categoryBitMask = ELLabelCategory
        ELlabel.physicsBody!.contactTestBitMask = DULabelCategory|BorderCategory
        
        //add to scene
        self.addChild(ELlabel)
        
        //OpeningSequence()
        //let DUlabel = SKSpriteNode(imageNamed: "DU")
        //let ELlabel = SKSpriteNode(imageNamed: "EL")
        
        //define sound action
        //let soundaction = SKAction.playSoundFileNamed("AreYouReady.aifc", waitForCompletion: false)
        //define move down action
        let MoveDown = SKAction.moveBy(CGVector(dx:0,dy: -600), duration: 2)
        //define right impulse action, x impulse is randomised using the randomInt function
        let RightImpulse = SKAction.applyImpulse(CGVector(dx: randomInt(500, max: 1500),dy: 0), duration: 0.5)
        //define left impulse action, x impulse is randomised using the randomInt function
        let LeftImpulse = SKAction.applyImpulse(CGVector(dx: randomInt(-1500, max: -500),dy: 0), duration: 0.5)
        //define rotate action
        let Rotate = SKAction.rotateByAngle(1.571, duration: 1)
        let Wait = SKAction.waitForDuration(0.5)
        
        //define sequences for labels, including a call to repeat action x number of times
        let DUSequence = SKAction.repeatAction(SKAction.sequence([RightImpulse,LeftImpulse]), count: 5)
        let ELSequence = SKAction.repeatAction(SKAction.sequence([LeftImpulse,RightImpulse]), count: 5)
        let DUFinalMove = SKAction.moveTo(CGPoint(x: 420, y: 1100), duration: 2.0)
        let ELRotate = SKAction.sequence([Wait, Rotate])
        
        //on DU label, run initial sequence of sound and move down action, once complete run the code within
        DUlabel.runAction(SKAction.sequence([MoveDown]),completion: {
            //once initial sequence is run, continue to run the defined DU sequence, once complete run the code within
            DUlabel.runAction(DUSequence, completion: {
                //pin DU label to negate physics and then set postition to the final one
                DUlabel.runAction(DUFinalMove)
                DUlabel.physicsBody?.pinned = true
                DUlabel.position = CGPoint(x: 420, y: 1100)
            })
        })
        
        //on EL label, run initial sequence of move down action, once complete run the code within
        ELlabel.runAction(MoveDown,completion: {
            //once the initial sequence is run, continue to run the defined EL sequenece, once complete run the code within
            ELlabel.runAction(ELSequence, completion: {
                //pin the EL label to negate physics and then set the position to the final and turn on rotation
                ELlabel.physicsBody?.pinned = true
                ELlabel.position = CGPoint(x: 680, y: 1100)
                ELlabel.physicsBody?.allowsRotation = true
                //run the rotate action, once complete run the code within
                ELlabel.runAction(ELRotate, completion: {
                    //set the zrotation of the label to 90 degrees anticlockwise
                    ELlabel.zRotation = 1.571
                    
                    //add two circles to direct gameplay
                    //define new sk sprite node with Ball.png as a base
                    let circle1 = SKShapeNode(circleOfRadius: 100)
                    circle1.physicsBody = SKPhysicsBody(circleOfRadius: 100)
                    circle1.fillColor = SKColor.blueColor()
                    //set location to the passed CGPoint
                    circle1.position = CGPoint(x: 300, y: 600)
                    circle1.name = "bricks"
                    self.addChild(circle1)
                    
                    //define new sk sprite node with Ball.png as a base
                    let circle2 = SKShapeNode(circleOfRadius: 100)
                    circle2.physicsBody = SKPhysicsBody(circleOfRadius: 100)
                    circle2.fillColor = SKColor.redColor()
                    //set location to the passed CGPoint
                    circle2.position = CGPoint(x: 600, y: 600)
                    circle2.name = "droppingblocks"
                    self.addChild(circle2)
                })
            })
        })
        
        
        

        
    }

    //returns a random integer between the passed min and maximum values
    func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    func OpeningSequence()  {
        print ("Entered")
        let ELlabel = SKSpriteNode(imageNamed: "EL")
        ELlabel.position = CGPoint(x: 680, y: 1100)
        //define sound action
        let soundaction = SKAction.playSoundFileNamed("AreYouReady.aifc", waitForCompletion: false)
        runAction(soundaction)
        
    }
    
    func RunOpeningSequence() {
        
        print ("In opening sequence")
        
        let DUlabel = SKSpriteNode(imageNamed: "DU")
        let ELlabel = SKSpriteNode(imageNamed: "EL")
        
        //define sound action
        let soundaction = SKAction.playSoundFileNamed("AreYouReady.aifc", waitForCompletion: false)
        //define move down action
        let MoveDown = SKAction.moveBy(CGVector(dx:0,dy: -600), duration: 2)
        //define right impulse action, x impulse is randomised using the randomInt function
        let RightImpulse = SKAction.applyImpulse(CGVector(dx: randomInt(500, max: 1500),dy: 0), duration: 0.5)
        //define left impulse action, x impulse is randomised using the randomInt function
        let LeftImpulse = SKAction.applyImpulse(CGVector(dx: randomInt(-1500, max: -500),dy: 0), duration: 0.5)
        //define rotate action
        let Rotate = SKAction.rotateByAngle(1.571, duration: 1)
        let Wait = SKAction.waitForDuration(0.5)
        
        //define sequences for labels, including a call to repeat action x number of times
        let DUSequence = SKAction.repeatAction(SKAction.sequence([RightImpulse,LeftImpulse]), count: 5)
        let ELSequence = SKAction.repeatAction(SKAction.sequence([LeftImpulse,RightImpulse]), count: 5)
        let DUFinalMove = SKAction.moveTo(CGPoint(x: 420, y: 1100), duration: 2.0)
        let ELRotate = SKAction.sequence([Wait, Rotate])
        
        //on DU label, run initial sequence of sound and move down action, once complete run the code within
        DUlabel.runAction(SKAction.sequence([soundaction, MoveDown]),completion: {
            //once initial sequence is run, continue to run the defined DU sequence, once complete run the code within
            DUlabel.runAction(DUSequence, completion: {
                //pin DU label to negate physics and then set postition to the final one
                DUlabel.runAction(DUFinalMove)
                DUlabel.physicsBody?.pinned = true
                DUlabel.position = CGPoint(x: 420, y: 1100)
            })
        })
        
        //on EL label, run initial sequence of move down action, once complete run the code within
        ELlabel.runAction(MoveDown,completion: {
            //once the initial sequence is run, continue to run the defined EL sequenece, once complete run the code within
            ELlabel.runAction(ELSequence, completion: {
                //pin the EL label to negate physics and then set the position to the final and turn on rotation
                ELlabel.physicsBody?.pinned = true
                ELlabel.position = CGPoint(x: 680, y: 1100)
                ELlabel.physicsBody?.allowsRotation = true
                //run the rotate action, once complete run the code within
                ELlabel.runAction(ELRotate, completion: {
                    //set the zrotation of the label to 90 degrees anticlockwise
                    ELlabel.zRotation = 1.571
    
                })
            })
        })
        
        
    }
}