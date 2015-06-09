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
        
        // Testing by placing card in the middle
        let texture = SKTexture(imageNamed: "spade_2")
        let card = SKSpriteNode(texture: texture)
        card.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.addChild(card)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {

    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
