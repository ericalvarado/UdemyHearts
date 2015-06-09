//
//  GameScene.swift
//  Hearts
//
//  Created by Eric Alvarado on 6/8/15.
//  Copyright (c) 2015 Eric Alvarado. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    override init(size: CGSize){
        super.init(size: size)
        
        self.backgroundColor = UIColor.greenColor()
        
        // Testing the Card class
        let card = Card(rank: 14, suit: "diamond", faceUp: false)
        card.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.addChild(card)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {

    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        // Testing the Card Class
        
        // For statement creates a variable 'touch' based on the touches set
        for touch: AnyObject in touches {
            
            // Set the CGPoint of the touch location
            let location = touch.locationInNode(self)
            
            // Test the set of the node to the class of Card, if true execute flip, if not println 'Not Card'
            if let node = nodeAtPoint(location) as? Card {
                node.flip()
            } else {
                println("Not Card")
            }
        }
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
