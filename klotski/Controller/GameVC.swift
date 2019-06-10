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
    
    
    var levelChosen = 0

    var blockSize: CGFloat!
    
    var board = GameBoard()

    var cards:[Card] = []
    
    
    
    var beginPostion:CGPoint = CGPoint(x: 1, y: 1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.black
        let boardWidth = gameView.frame.size.width
        blockSize = boardWidth / 4
        

        cards = LevelSetup.initLevel4()
        
        board.updateMap(all: cards)
        
        
        
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
        
        print("It seems you are leaving")
        
        var savedDataChampions: [Int] = []
        var savedDataTowers: [Int] = []
        var savedDataMinions: [Int] = []
        
        for card in cards {
            switch card.type {
            case .champion:
                savedDataChampions += LevelSetup.tuplesToInts(card.location)
            case .tower:
                savedDataTowers += LevelSetup.tuplesToInts(card.location)
            case .minion:
                savedDataMinions += LevelSetup.tuplesToInts(card.location)
            }
        }
        
        print(savedDataChampions)
        print(savedDataTowers)
        print(savedDataMinions)
        print("---TADA---Real Data-----")
        print(cards)
        print("---TADA---ReProduce Data-----")
        print(LevelSetup.intsToCards(champion: savedDataChampions, tower: savedDataTowers, minion: savedDataMinions))
    }
    



}

