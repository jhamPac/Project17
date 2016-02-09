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
        
        //gameTimer = NSTimer.scheduledTimerWithTimeInterval(6, target: self, selector: "launchFireworks", userInfo: nil, repeats: true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
       
    }
   
    override func update(currentTime: CFTimeInterval)
    {
        
    }
    
    func launchFireworks()
    {
        
    }
}
