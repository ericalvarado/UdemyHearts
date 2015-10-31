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
    
    var player1PlayingPosition = CGPoint()
    var player1PlayingCard = [Card]()
    var player2PlayingPosition = CGPoint()
    var player2PlayingCard = [Card]()
    var player3PlayingPosition = CGPoint()
    var player3PlayingCard = [Card]()
    var player4PlayingPosition = CGPoint()
    var player4PlayingCard = [Card]()

    var currentMoveCards = [Card]()
    
    var player1Label = SKLabelNode()
    var player2Label = SKLabelNode()
    var player3Label = SKLabelNode()
    var player4Label = SKLabelNode()
    
    var player1ScoreLabel = SKLabelNode()
    var player2ScoreLabel = SKLabelNode()
    var player3ScoreLabel = SKLabelNode()
    var player4ScoreLabel = SKLabelNode()
    
    var player1Score = 0
    var player2Score = 0
    var player3Score = 0
    var player4Score = 0
    
    var currentPlayer = 0
    var gameInProgress = false
    var canPlayHearts = false
    
    let centerCard = SKSpriteNode(imageNamed: "cardback")
    
    // Initializer
    override init(size: CGSize){
        super.init(size: size)
        
        self.backgroundColor = UIColor.greenColor()
        
        dealCards()
        
        establishPlayerPositions()
        
        placePlayerLabels()
        
        placeScoreLabels()
        
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
        
        // Create a SKAction delay
        let delay = SKAction.waitForDuration(2.0)
        
        // Create a SKAction sort
        let sort = SKAction.runBlock { () -> Void in
            
            // Call sortCards function to sort the cards by rank
            self.player1Cards = self.sortCards(self.player1Cards)
            self.player2Cards = self.sortCards(self.player2Cards)
            self.player3Cards = self.sortCards(self.player3Cards)
            self.player4Cards = self.sortCards(self.player4Cards)
            
            // Loop though each player and set their z position by rank and suit, the move each card to the new position
            for i in 0...self.player1Cards.count - 1 {
                self.player1Cards[i].zPosition = CGFloat(self.player1Cards[i].rank) + self.cardType(self.player1Cards[i].suit)
                let move = SKAction.moveTo(self.player1CardPostions[i], duration: 1.0)
                self.player1Cards[i].runAction(move)
            }
            for i in 0...self.player2Cards.count - 1 {
                self.player2Cards[i].zPosition = CGFloat(self.player2Cards[i].rank) + self.cardType(self.player2Cards[i].suit)
                let move = SKAction.moveTo(self.player2CardPostions[i], duration: 1.0)
                self.player2Cards[i].runAction(move)
            }
            for i in 0...self.player3Cards.count - 1 {
                self.player3Cards[i].zPosition = CGFloat(self.player3Cards[i].rank) + self.cardType(self.player3Cards[i].suit)
                let move = SKAction.moveTo(self.player3CardPostions[i], duration: 1.0)
                self.player3Cards[i].runAction(move)
            }
            for i in 0...self.player4Cards.count - 1 {
                self.player4Cards[i].zPosition = CGFloat(self.player4Cards[i].rank) + self.cardType(self.player4Cards[i].suit)
                let move = SKAction.moveTo(self.player4CardPostions[i], duration: 1.0)
                self.player4Cards[i].runAction(move)
            }
        }
        
        // Establish SKAction sequence block
        let sequence = SKAction.sequence([deal,delay,sort,delay])
        
        // Run block
        self.runAction(sequence, completion: { () -> Void in
            let move = SKAction.moveTo(self.player1PlayingPosition, duration: 1)
            self.player1Cards[0].runAction(move)
            
            let move2 = SKAction.moveTo(self.player2PlayingPosition, duration: 1)
            self.player2Cards[0].runAction(move2)
            
            let move3 = SKAction.moveTo(self.player3PlayingPosition, duration: 1)
            self.player3Cards[0].runAction(move3)
            
            let move4 = SKAction.moveTo(self.player4PlayingPosition, duration: 1)
            self.player4Cards[0].runAction(move4)
        })
    }
    
    // Method to establish a suit's base z-position
    func cardType(suit: String) -> CGFloat {
        var type:CGFloat = 0
        
        switch suit {
            case "spade":
                type = 0
            case "heart":
                type = 13
            case "club":
                type = 26
            case "diamond":
                type = 39
        default:
            type = 0
        }
        
        return type
    }
    
    // Method to sort cards
    func sortCards(playerCards: [Card]) -> [Card]{
        
        // Set local properties
        var spadeCards = [Card]()
        var heartCards = [Card]()
        var clubCards = [Card]()
        var diamondCards = [Card]()
        var sortedPlayerCards = [Card]()
        
        // Categorize each card and add to respective suit arrays
        for card in playerCards {
            switch card.suit {
                case "spade":
                    spadeCards.append(card)
                case "heart":
                    heartCards.append(card)
                case "club":
                    clubCards.append(card)
                case "diamond":
                    diamondCards.append(card)
            default:
                break
            }
        }
        
        // Walk through each suit array and perform a bubble sort, then add the cards to the return card array
        if spadeCards.count > 1 {
            for _ in 1...spadeCards.count {
                for j in 0...spadeCards.count - 2 {
                    if spadeCards[j+1].rank < spadeCards[j].rank {
                        let temp = spadeCards[j]
                        spadeCards[j] = spadeCards[j+1]
                        spadeCards[j+1] = temp
                    }
                }
            }
            
            for i in 0...spadeCards.count - 1{
                sortedPlayerCards.append(spadeCards[i])
            }
        }
        
        if heartCards.count > 1 {
            for _ in 1...heartCards.count {
                for j in 0...heartCards.count - 2 {
                    if heartCards[j+1].rank < heartCards[j].rank {
                        let temp = heartCards[j]
                        heartCards[j] = heartCards[j+1]
                        heartCards[j+1] = temp
                    }
                }
            }
            
            for i in 0...heartCards.count - 1{
                sortedPlayerCards.append(heartCards[i])
            }
        }
        
        if clubCards.count > 1 {
            for _ in 1...clubCards.count {
                for j in 0...clubCards.count - 2 {
                    if clubCards[j+1].rank < clubCards[j].rank {
                        let temp = clubCards[j]
                        clubCards[j] = clubCards[j+1]
                        clubCards[j+1] = temp
                    }
                }
            }
            
            for i in 0...clubCards.count - 1{
                sortedPlayerCards.append(clubCards[i])
            }
        }
        
        if diamondCards.count > 1 {
            for _ in 1...diamondCards.count {
                for j in 0...diamondCards.count - 2 {
                    if diamondCards[j+1].rank < diamondCards[j].rank {
                        let temp = diamondCards[j]
                        diamondCards[j] = diamondCards[j+1]
                        diamondCards[j+1] = temp
                    }
                }
            }
            
            for i in 0...diamondCards.count - 1{
                sortedPlayerCards.append(diamondCards[i])
            }
        }
        
        return sortedPlayerCards
    }
    
    // Method to determine the position to where the played card resides
    func establishPlayerPositions(){
        // Set up center card
        
        centerCard.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.addChild(centerCard)
        
        //Player 1
        let newX1 = centerCard.position.x
        let newY1 = centerCard.position.y - centerCard.size.height/2 - cardOffset - centerCard.size.height/2
        player1PlayingPosition = CGPoint(x: newX1, y: newY1)
        
        // Player 2
        let newX2 = centerCard.position.x - centerCard.size.width/2 - cardOffset - centerCard.size.width/2
        let newY2 = centerCard.position.y
        player2PlayingPosition = CGPoint(x: newX2, y: newY2)
        
        //Player 3
        let newX3 = centerCard.position.x
        let newY3 = centerCard.position.y + centerCard.size.height/2 + cardOffset + centerCard.size.height/2
        player3PlayingPosition = CGPoint(x: newX3, y: newY3)
        
        // Player 4
        let newX4 = centerCard.position.x + centerCard.size.width/2 + cardOffset + centerCard.size.width/2
        let newY4 = centerCard.position.y
        player4PlayingPosition = CGPoint(x: newX4, y: newY4)
    }
    
    // Method to place player labels on the screen
    func placePlayerLabels(){
        
        // Label Nodes
        player1Label = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        player1Label.fontColor = SKColor.brownColor()
        player1Label.fontSize = 40
        player1Label.text = "1"
        player1Label.position = CGPointMake(CGRectGetMidX(self.frame) - player1Label.frame.width/2,sides/2 - player1Label.frame.height/2)
        self.addChild(player1Label)
        
        player2Label = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        player2Label.fontColor = SKColor.brownColor()
        player2Label.fontSize = 40
        player2Label.text = "2"
        player2Label.position = CGPointMake(sides/2,CGRectGetMidY(self.frame) + player2Label.frame.height/2)
        self.addChild(player2Label)
        
        player3Label = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        player3Label.fontColor = SKColor.brownColor()
        player3Label.fontSize = 40
        player3Label.text = "3"
        player3Label.position = CGPointMake(CGRectGetMidX(self.frame) - player3Label.frame.width/2, self.frame.height - sides/2 - player3Label.frame.height/2)
        self.addChild(player3Label)
        
        player4Label = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        player4Label.fontColor = SKColor.brownColor()
        player4Label.fontSize = 40
        player4Label.text = "4"
        player4Label.position = CGPointMake(self.frame.width - sides/2,CGRectGetMidY(self.frame) + player4Label.frame.height/2)
        self.addChild(player4Label)
        
    }
    
    func placeScoreLabels(){
        player1ScoreLabel = SKLabelNode(fontNamed: "Courier-Bold")
        player1ScoreLabel.fontSize = 35
        player1ScoreLabel.fontColor = SKColor.blackColor()
        player1ScoreLabel.text = "Score:\(player1Score)"
        player1ScoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.sides + centerCard.frame.height + 20)
        self.addChild(player1ScoreLabel)
        
        player2ScoreLabel = SKLabelNode(fontNamed: "Courier-Bold")
        player2ScoreLabel.fontSize = 35
        player2ScoreLabel.fontColor = SKColor.blackColor()
        player2ScoreLabel.text = "Score:\(player2Score)"
        player2ScoreLabel.position = CGPointMake(self.sides + centerCard.frame.width/2 + cardOffset + player2ScoreLabel.frame.width/2 + 20,CGRectGetMidY(self.frame))
        self.addChild(player2ScoreLabel)
        
        player3ScoreLabel = SKLabelNode(fontNamed: "Courier-Bold")
        player3ScoreLabel.fontSize = 35
        player3ScoreLabel.fontColor = SKColor.blackColor()
        player3ScoreLabel.text = "Score:\(player3Score)"
        player3ScoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.height - self.sides - centerCard.frame.height - 20 - player3ScoreLabel.frame.height/2)
        self.addChild(player3ScoreLabel)
        
        player4ScoreLabel = SKLabelNode(fontNamed: "Courier-Bold")
        player4ScoreLabel.fontSize = 35
        player4ScoreLabel.fontColor = SKColor.blackColor()
        player4ScoreLabel.text = "Score:\(player4Score)"
        player4ScoreLabel.position = CGPointMake(self.frame.width - self.sides - centerCard.frame.width/2 - cardOffset - player2ScoreLabel.frame.width/2 - 20,CGRectGetMidY(self.frame))
        self.addChild(player4ScoreLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {

    }
    
    // Updated code to Swift 2.0 - http://stackoverflow.com/questions/30892254/override-func-error-in-swift-2
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
