//
//  GameScene.swift
//  Fireworks
//
//  Created by jhampac on 2/5/16.
//  Copyright (c) 2016 jhampac. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene
{
    var gameTimer: NSTimer!
    var fireworks = [SKNode]()
    
    let leftEdge = -22
    let bottomEdge = -22
    let rightEdge = 1024 + 22
    
    var score: Int = 0 {
        didSet{
            
        }
    }
    
    override func didMoveToView(view: SKView)
    {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .Replace
        background.zPosition = -1
        addChild(background)
        
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(6, target: self, selector: "launchFireworks", userInfo: nil, repeats: true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        super.touchesBegan(touches, withEvent: event)
        checkForTouches(touches)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        super.touchesMoved(touches, withEvent: event)
        checkForTouches(touches)
    }
   
    override func update(currentTime: CFTimeInterval)
    {
        for (index, firework) in fireworks.enumerate().reverse()
        {
            if firework.position.y > 900
            {
                fireworks.removeAtIndex(index)
                firework.removeFromParent()
            }
        }
    }
    
    func launchFireworks()
    {
        let movementAmount: CGFloat = 1800
        
        switch GKRandomSource.sharedRandom().nextIntWithUpperBound(4)
        {
            case 0:
            // fire five, straight up
                createFirework(xMovement: 0, x: 512, y: bottomEdge)
                createFirework(xMovement: 0, x: 512 - 200, y: bottomEdge)
                createFirework(xMovement: 0, x: 512 - 100, y: bottomEdge)
                createFirework(xMovement: 0, x: 512 + 100, y: bottomEdge)
                createFirework(xMovement: 0, x: 512 + 200, y: bottomEdge)
            
            case 1:
            // fire five, in a fan
                createFirework(xMovement: 0, x: 512, y: bottomEdge)
                createFirework(xMovement: -200, x: 512 - 200, y: bottomEdge)
                createFirework(xMovement: -100, x: 512 - 100, y: bottomEdge)
                createFirework(xMovement: 100, x: 512 + 100, y: bottomEdge)
                createFirework(xMovement: 200, x: 512 + 200, y: bottomEdge)
            
            case 2:
            // fire five, from the left to the right
                createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 400)
                createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 300)
                createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 200)
                createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 100)
                createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge)
            
            case 3:
            // fire five, from the right to the left
                createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 400)
                createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 300)
                createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 200)
                createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 100)
                createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge)
            
            default:
                break
        }
    }
    
    func createFirework(xMovement xMovement: CGFloat, x: Int, y: Int)
    {
        let node = SKNode()
        node.position = CGPoint(x: x, y: y)
        
        let firework = SKSpriteNode(imageNamed: "rocket")
        firework.name = "firework"
        node.addChild(firework)
        
        switch GKRandomSource.sharedRandom().nextIntWithUpperBound(3)
        {
            case 0:
                firework.color = UIColor.cyanColor()
                firework.colorBlendFactor = 1
            
            case 1:
                firework.color = UIColor.greenColor()
                firework.colorBlendFactor = 1
            
            case 2:
                firework.color = UIColor.redColor()
                firework.colorBlendFactor = 1
            
            default:
                break
        }
        
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: 0))
        path.addLineToPoint(CGPoint(x: xMovement, y: 1000))
        
        let move = SKAction.followPath(path.CGPath, asOffset: true, orientToPath: true, speed: 200)
        node.runAction(move)
        
        let emitter = SKEmitterNode(fileNamed: "fuse")!
        emitter.position = CGPoint(x: 0, y: -22)
        node.addChild(emitter)
        
        fireworks.append(node)
        addChild(node)
    }
    
    func checkForTouches(touches: Set<UITouch>)
    {
        guard let touch = touches.first else { return }
        
        let location = touch.locationInNode(self)
        let nodes = nodesAtPoint(location)
        
        for node in nodes
        {
            if node.isKindOfClass(SKSpriteNode.self)
            {
                let sprite = node as! SKSpriteNode
                
                if sprite.name == "firework"
                {
                    for parent in fireworks
                    {
                        let firework = parent.children[0] as! SKSpriteNode
                        
                        if firework.name == "selected" && firework.color != sprite.color
                        {
                            firework.name = "firework"
                            firework.colorBlendFactor = 1
                        }
                    }
                    
                    sprite.name = "selected"
                    sprite.colorBlendFactor = 0
                }
                
            }
        }
    }
}
