//
//  GameScene.swift
//  Fireworks
//
//  Created by jhampac on 2/5/16.
//  Copyright (c) 2016 jhampac. All rights reserved.
//

import SpriteKit

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
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
       
    }
   
    override func update(currentTime: CFTimeInterval)
    {
        
    }
}
