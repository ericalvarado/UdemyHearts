//
//  Card.swift
//  Hearts
//
//  Created by Eric Alvarado on 6/9/15.
//  Copyright (c) 2015 Eric Alvarado. All rights reserved.
//

import SpriteKit

class Card: SKSpriteNode {
    
    // Properties
    var rank:Int
    var suit:String
    var imageNameUp:String
    var textureUp:SKTexture
    var textureDown:SKTexture
    
    // Custom Initializer
    init(rank:Int, suit:String, faceUp:Bool){
        self.rank = rank
        self.suit = suit
        self.imageNameUp = "\(suit)_\(rank)"
        self.textureUp = SKTexture(imageNamed: imageNameUp)
        self.textureDown = SKTexture(imageNamed: "cardback")
        var texture = SKTexture()
        
        // Set the initial texture state of the card based on faceUp flag
        if faceUp {
            texture = textureUp
        } else {
            texture = textureDown
        }
        
        // Call the parent initializer passing texture, color, and size
        // - initWithTexture:color:size (Designated Initializer)
        super.init(texture:texture,color:nil,size:texture.size())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Methods
    
    // Flips the card texture to the up state
    func flip(){
        self.texture = textureUp
    }
    

}
