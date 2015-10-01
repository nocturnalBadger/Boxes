//
//  GameScene.swift
//  Boxes
//
//  Created by Jeremy Schmidt on 10/1/15.
//  Copyright (c) 2015 Jeremy Schmidt. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var rotationOn: Bool = true
    var bounciness: CGFloat = 0.2
    var gravity: Float = -2
    var friction: Float = 0.2
    var maxSize: UInt32 = 100
    var boxes: Array<SKSpriteNode> = []
    let colorOptions: Array<SKColor> = [SKColor.redColor(), SKColor.greenColor(), SKColor.blueColor(), SKColor.yellowColor(), SKColor.purpleColor(), SKColor.orangeColor(), SKColor.whiteColor(), SKColor.blackColor()]
    var currentColorIndex: Int = 0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let centerScreen = CGPoint(x: (self.size.width / 2), y: (self.size.height / 2))
        let ground = SKSpriteNode(color: SKColor.purpleColor(), size: CGSize(width: self.size.width, height: 50))
        ground.position = CGPoint(x: centerScreen.x, y: 25)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: ground.size)
        ground.physicsBody!.dynamic = false
        self.addChild(ground)
        
        changeGravity(gravity)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)
            
            let box = SKSpriteNode(color: colorOptions[currentColorIndex], size: CGSize(width: CGFloat(arc4random_uniform(maxSize) + maxSize / 5), height: CGFloat(arc4random_uniform(maxSize) + maxSize / 5)))
            
            box.xScale = 0.5
            box.yScale = 0.5
            box.position = location
            
            box.physicsBody = SKPhysicsBody(rectangleOfSize: box.size)
            
            if box.physicsBody != nil
            {
                box.physicsBody!.allowsRotation = rotationOn
                if (box.physicsBody!.allowsRotation == false) { box.color = SKColor.greenColor() }
                box.physicsBody!.restitution = bounciness
                box.physicsBody!.friction = CGFloat(friction)
            }
            
            boxes.append(box)
            self.addChild(box)
        }
    }
    
    func changeGravity(newGravValue: Float)
    {
        physicsWorld.gravity = CGVectorMake(0, CGFloat(newGravValue))
    }
    
    override func update(currentTime: CFTimeInterval)
    {
        if boxes.count > 50
        {
            checkBoxesInView()
        }
    }
    
    func removeAllBoxes()
    {
        for box in boxes
        {
            box.removeFromParent()
        }
        removeChildrenInArray(boxes)
    }
    
    func changeColor() -> SKColor
    {
        if currentColorIndex >= colorOptions.count - 1
        {
            currentColorIndex = 0
        }
        else
        {
            currentColorIndex += 1
        }
        return colorOptions[currentColorIndex]
    }
    
    func getAllProperties() -> String
    {
        return "MaxSize: \(maxSize) \n Friction: \(friction) \n Bounciness: \(bounciness)"
    }
    
    
    func checkBoxesInView()
    {
        var i = 0
        for box in boxes
        {
            if !self.frame.contains(box.frame)
            {
                box.removeFromParent()
                boxes.removeAtIndex(i)
            }
            else
            {
                ++i
            }
        }
    }
}
