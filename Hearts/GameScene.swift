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
    var player1Cards = [Card]()
    var player2Cards = [Card]()
    var player3Cards = [Card]()
    var player4Cards = [Card]()
    
    var player1CardPostions = [CGPoint]()
    var player2CardPostions = [CGPoint]()
    var player3CardPostions = [CGPoint]()
    var player4CardPostions = [CGPoint]()
    
    let cardOffset = CGFloat(35.0)
    let sides = CGFloat(50.0)
    
    // Initializer
    override init(size: CGSize){
        super.init(size: size)
        
        self.backgroundColor = UIColor.greenColor()
        
        dealCards()

        // Testing positioning
//        var test = SKSpriteNode(imageNamed: "cardback")
//        
//        var leftEdge = test.size.width/2
//        var bottomEdge = test.size.height/2
//        var topEdge = 1.5 * test.size.height
//        var rightEdge = 1.5 * test.size.width
//        var handSize:CGFloat = 12
//        var testPosition:CGFloat = self.size.width/2 + self.cardOffset * (handSize/2 - CGFloat(12))
//        
//        println("Test: \(testPosition)")
//        
//        self.addChild(test)
//        test.position = CGPointMake(leftEdge, bottomEdge)
//
//        var test2 = SKSpriteNode(imageNamed: "spade_14")
//        self.addChild(test2)
//        test2.position = CGPointMake(testPosition, bottomEdge)
        
        /* Trying to breakdown logic
        - SKSpriteNode's origin is center
        - GameScene origin (0,0) is lower left
        - Halving the width will gain control over left edge
        - Halving the height will gain control over bottom edge
        - 150% of the width will gain control over right edge
        - 150% of the height will gain control over top edge
        - cardOffset controls the layering of the card
        - iPad2 self.size.width = 1024
        - First term in formula: (1024 + (35 * 12 + 80))/2 = 762
        - Second term in formula [80/2 - (cardCount - 1) * 35] = [40 - (cardCount - 1) * 35] >>
           For 1st card, second term is [-40 - 0 * 35] = -40
           For 13th card, second term is [-40 - 12 * 35] = -460
        - Therefore, first term - second term is:
           For 1st card, 722
           For 13th card, 382
        In english, half the screen size + half of the card width + half of the offsets, this sets the rightmost position for the 1st card... then works the cards by flexing the offsets
        
        I think it would have been better if:
        var handSize:CGFloat = 12
        var testPosition:CGFloat = self.size.width/2 + self.cardOffset * (handSize/2 - CGFloat(12))
        */
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
        
        // Start with first player
        var player = 1
        
        // Configure an SKAction block called "deal"
        let deal = SKAction.runBlock { () -> Void in
            
            // Loop through until deck is empty
            while self.deck.count > 0 {
                
                // Choose a random index
                let index = Int(arc4random_uniform(UInt32(self.deck.count)))
                
                // Check which player is the next player to have card dealt too
                if player == 1 {
                    
                    // Add the selected card to the array
                    self.player1Cards.append(self.deck[index])
                    
                    // Remove the card from the deck and store reference in "removedCard"
                    let removedCard = self.deck.removeAtIndex(index)
                    
                    // Place the card in the center to simulate being dealt from the deck
                    removedCard.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
                    
                    // Add card to screen
                    self.addChild(removedCard)
                    
                    // Flip card
                    removedCard.flip()
                    
                    // Calculate new X position -- adjusts with the initial position to the left of center
                    let newX = (self.size.width + (self.cardOffset * 12 + removedCard.size.width))/2 - removedCard.size.width/2 - CGFloat(self.player1Cards.count - 1) * self.cardOffset
                    
                    // Calculate new Y position -- equal distance from border
                    let newY = removedCard.size.height / 2 + self.sides
                    
                    // Store the position of the card to be used later when the cards are sorted
                    self.player1CardPostions.append(CGPointMake(newX, newY))
                    
                    // Animate the action
                    let move = SKAction.moveTo(CGPointMake(newX, newY), duration: 1.0)
                    removedCard.runAction(move)
                    
                } else if player == 2 {
                    
                    // Repeat from player one with the cards going down the left
                    self.player2Cards.append(self.deck[index])
                    let removedCard = self.deck.removeAtIndex(index)
                    removedCard.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
                    self.addChild(removedCard)
                    removedCard.flip()
                    let newX = removedCard.size.width/2 + self.sides
                    
                    let cardsHeight = self.cardOffset * 12 + removedCard.size.height
                    let bottomEdge = (self.size.height - cardsHeight)/2
                    let topEdge = (self.size.height - bottomEdge)
                    
                    let newY = topEdge - removedCard.size.height/2 - CGFloat(self.player2Cards.count - 1) * self.cardOffset
                    self.player2CardPostions.append(CGPointMake(newX, newY))
                    let move = SKAction.moveTo(CGPointMake(newX, newY), duration: 1.0)
                    removedCard.runAction(move)
                    
                    // Use this to rotate the cards
                    //let rotate = SKAction.rotateByAngle(-3.14/2, duration: 1)
                    //removedCard.runAction(rotate)
                    
                } else if player == 3 {
                    
                    // Repeat from player one with the cards going along the top
                    self.player3Cards.append(self.deck[index])
                    let removedCard = self.deck.removeAtIndex(index)
                    removedCard.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
                    self.addChild(removedCard)
                    removedCard.flip()
                    let newX = (self.size.width + (self.cardOffset * 12 + removedCard.size.width))/2 - removedCard.size.width/2 - CGFloat(self.player3Cards.count - 1) * self.cardOffset
                    let newY = self.size.height - self.sides - removedCard.size.height/2
                    self.player3CardPostions.append(CGPointMake(newX, newY))
                    let move = SKAction.moveTo(CGPointMake(newX, newY), duration: 1.0)
                    removedCard.runAction(move)
                    
                } else if player == 4 {
                    
                    // Repeat from player one with the cards going along the right
                    self.player4Cards.append(self.deck[index])
                    let removedCard = self.deck.removeAtIndex(index)
                    removedCard.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
                    self.addChild(removedCard)
                    removedCard.flip()
                    let newX = self.size.width - removedCard.size.width/2 - self.sides
                    
                    let cardsHeight = self.cardOffset * 12 + removedCard.size.height
                    let bottomEdge = (self.size.height - cardsHeight)/2
                    let topEdge = (self.size.height - bottomEdge)
                    
                    let newY = topEdge - removedCard.size.height/2 - CGFloat(self.player4Cards.count - 1) * self.cardOffset
                    self.player4CardPostions.append(CGPointMake(newX, newY))
                    let move = SKAction.moveTo(CGPointMake(newX, newY), duration: 1.0)
                    removedCard.runAction(move)
                    
                    // Use this to rotate the cards
                    //let rotate = SKAction.rotateByAngle(-3.14/2, duration: 1)
                    //removedCard.runAction(rotate)
                }
                
                // Increment the player counter
                player++
                
                // Reset the counter back to 1
                if player == 5 {
                    player = 1
                }
            }
        }
        
        self.runAction(deal)
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
