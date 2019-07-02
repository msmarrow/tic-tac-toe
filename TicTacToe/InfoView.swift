//
//  InfoView.swift
//  TicTacToe
//
//  Created by Mahjeed Marrow on 4/29/19.
//  Copyright © 2019 Mahjeed Marrow. All rights reserved.
//

import UIKit

class InfoView: UIView {
    
    override func awakeFromNib() {
        setUpLayer()
        setPosition()
    }
    
    //MARK: set InfoView layer properties
    func setUpLayer(){
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = 10.0
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
    }
    
    //MARK: set intiial position of InfoView
    func setPosition(){
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        self.frame.origin.x = screenWidth / 5
        self.frame.origin.y = -150
    }
    
    //MARK: move info view to center
    func animateInfoView(){
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        let infoViewAnimator = UIViewPropertyAnimator (
            duration: 0.5,
            curve: .easeIn) {
                self.frame.origin.y = 275
                self.frame.origin.x = screenWidth / 5
                self.layer.zPosition = 3
                
                //source: stackoverflow.com/questions/28821722/delaying-function-in-swift
                Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: Selector(("resetInfoViewPosition")), userInfo: nil, repeats: false)
        }
        infoViewAnimator.startAnimation()
    }
    
    @objc func resetInfoViewPosition(){
        let resetViewAnimator = UIViewPropertyAnimator (
            duration: 1.0,
            curve: .easeIn){
                self.frame.origin.y = -150
            }
        resetViewAnimator.startAnimation()
    }
}
