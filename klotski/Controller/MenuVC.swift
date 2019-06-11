//
//  ViewController.swift
//  klotskiMenu
//
//  Created by Shawn Xu on 6/3/19.
//  Copyright © 2019 Nankai Univsity. All rights reserved.
//

import UIKit
import VerticalCardSwiper

class MenuVC: UIViewController, VerticalCardSwiperDelegate, VerticalCardSwiperDatasource{
    

    @IBOutlet weak var levelSelector: VerticalCardSwiper!
    
    private var levelsData: [Level] = [
        Level("Level 0"),
        Level("Level 1"),
        Level("Level 2"),
        Level("Level 3"),
        Level("Level 4"),
        Level("Level 5"),
        Level("Level 6"),
        Level("Level 7"),
        Level("Level 8"),
        Level("Level 9"),
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
        levelSelector.delegate = self
        levelSelector.datasource = self
        
        levelSelector.register(nib: UINib(nibName: "LevelCard", bundle: nil), forCellWithReuseIdentifier: "LevelCard")
        
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    

    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        
        return levelsData.count
    }
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        
        if let levelCard = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "LevelCard", for: index) as? LevelCard {
            
            
//            levelsDetail = fetchCoreData()
            let level = levelsData[index]
            
            levelCard.setRandomBackgroundColor()
            levelCard.levelIndex.text = level.name
            levelCard.playButton.setTitle(String(level.pass), for: .normal)
            return levelCard
        }
        
        return LevelCard()
        
    }
    
    func willSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        // called right before the card animates off the screen.
        levelsData.remove(at: index)
    }
    
    func didSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        // called when a card has animated off screen entirely.
    }
    
    func didTapCard(verticalCardSwiperView: VerticalCardSwiperView, index: Int) {
        
        // Tells the delegate when the user taps a card (optional).
        
//        print("You tapped ", String(index))
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let gameVC = mainStoryboard.instantiateViewController(withIdentifier: "gamegame") as?
            GameVC else {
                print("Opps, couldn't find it")
                return
        }
        
        gameVC.levelChosen = index
        
        
        levelsData[index].pass = true
        
        levelSelector.reloadData()
        
        
        
        navigationController?.pushViewController(gameVC, animated: true)
        
        
    }


}

