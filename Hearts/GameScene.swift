//
//  GameScene.swift
//  Hearts
//
//  Created by Eric Alvarado on 6/8/15.
//  Copyright (c) 2015 Eric Alvarado. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    // Properties
    let suits = ["spade","heart","diamond","club"] // Moved the initizliation of suits to the properties section
    var deck = [Card]()
    
    override init(size: CGSize){
        super.init(size: size)
        
        self.backgroundColor = UIColor.greenColor()
        
        dealCards()

    }

    // Method to initialize deck with suit and rank
    func dealCards(){
        
        // Changed code from lesson to for-in's rather than using counting/range for loops
        for suit in suits {
            for rank in 2...14 {
                let card = Card(rank: rank, suit: suit, faceUp: false)
                deck.append(card)
            }
        }
        
        // Testing deck build
        for card in deck{
            println("\(card.suit)_\(card.rank)")
        }
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
