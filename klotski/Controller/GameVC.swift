//
//  ViewController.swift
//  klotski
//
//  Created by Shawn Xu on 5/2/19.
//  Copyright © 2019 Nankai Univsity. All rights reserved.
//

import UIKit
import RoughSwift


class GameVC: UIViewController {
    

    
    @IBOutlet weak var gameView: UIView!
    

    var blockSize: CGFloat!
    
    var board = GameBoard()
    
    var champions:[Card] = []
    var towers:[Card] = []
    var minions:[Card] = []
    
    var cards:[Card] = []
    
//    var cardViews:[UICard] = []
    
    
    var beginPostion:CGPoint = CGPoint(x: 1, y: 1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.black
        let boardWidth = gameView.frame.size.width
        blockSize = boardWidth / 4
        
        let champion = Card(champion: [(1,0), (2,0), (1,1), (2,1)])
        
        champions.append(champion)

        // var championView = UICard(with: champion, in: board, scale: blockSize)
        
        
        var towers:[Card] = []
        
        towers.append(Card(tower: [(0,0), (0,1)]))
        towers.append(Card(tower: [(3,0), (3,1)]))
        towers.append(Card(tower: [(0,2), (0,3)]))
        towers.append(Card(tower: [(3,2), (3,3)]))
        towers.append(Card(tower: [(1,2), (2,2)]))
        
        minions.append(Card(minion: [(0,4)]))
        minions.append(Card(minion: [(1,3)]))
        minions.append(Card(minion: [(2,3)]))
        minions.append(Card(minion: [(3,4)]))
        
        cards += champions
        cards += towers
        cards += minions
        
        board.updateMap(all: cards)
        
//        board.printMap(debug: "---Map--Init--")
        
        
        
        for (index, card) in cards.enumerated() {
            
            let cardView = UICard(with: card, in: board, scale: blockSize)
            
            // Rough Swift Part, CGLayer -> CGView
            let size = CGSize(width: 300, height: 200)
            let layer = draw(size: size, using: { generator in
                var options = Options()
                options.stroke = UIColor.blue
                options.fill = UIColor.orange
                options.fillStyle = .zigzagLine
                generator.rectangle(x: 0, y: 0, width: Float(cardView.frame.width), height: Float(cardView.frame.height), options: options)
            })
            cardView.layer.addSublayer(layer)
            
//            cardView.text = String(index)
//            cardView.textAlignment = .center
            cardView.tag = index
            // cardViews.append(cardView)
            
            let directions: [UISwipeGestureRecognizer.Direction] = [.right, .left, .up, .down]
            for direction in directions {
                let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
                gesture.direction = direction
                cardView.addGestureRecognizer(gesture)
            }

            gameView.addSubview(cardView)
            
        }
        
    }
    
    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        // print(sender.direction)
        // print(sender.location(in: self.view))
//        var cardView = sender.view as! UICard
//        print(cardView.card.location)
        // print(sender.view?.tag)
        
        switch sender.direction {
        case .down:
            
            let CardView = sender.view as! UICard
            let card = cards[sender.view!.tag]
            
//            print(card.location)
            
//            board.printMap(debug: "--- So, what cannot move down? ---")
            
            if card.canMoveDown(in: board) {
//                print("Yeah~")
                card.moveDown(block: 1)
                board.updateMap(all: cards)
//                board.printMap(debug: "Now the Map is......")
                
                UIView.beginAnimations(nil, context: nil)
                UIView.setAnimationDuration(0.5)
                CardView.redraw(with: card, in: board, scale: blockSize)
                UIView.commitAnimations()
            }
            
        case .up:
            let cardView = sender.view as! UICard
            let card = cards[sender.view!.tag]
            
            if card.canMoveUp(in: board) {
                card.moveUp(block: 1)
                board.updateMap(all: cards)
                
                UIView.beginAnimations(nil, context: nil)
                UIView.setAnimationDuration(0.5)
                cardView.redraw(with: card, in: board, scale: blockSize)
                UIView.commitAnimations()
            }
            
        case .left:
            
            let cardView = sender.view as! UICard
            let card = cards[sender.view!.tag]
            
            if card.canMoveLeft(in: board) {
                card.moveLeft(block: 1)
                board.updateMap(all: cards)
                
                UIView.beginAnimations(nil, context: nil)
                UIView.setAnimationDuration(0.5)
                cardView.redraw(with: card, in: board, scale: blockSize)
                UIView.commitAnimations()
            }
        case .right:
            
            let cardView = sender.view as! UICard
            let card = cards[sender.view!.tag]
            
            if card.canMoveRight(in: board) {
                card.moveRight(block: 1)
                board.updateMap(all: cards)
                
                UIView.beginAnimations(nil, context: nil)
                UIView.setAnimationDuration(0.5)
                cardView.redraw(with: card, in: board, scale: blockSize)
                UIView.commitAnimations()
            }
            
            
        default:
            print("What the Heck")
        }
        
    }
    
    @IBAction func backTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    


}

