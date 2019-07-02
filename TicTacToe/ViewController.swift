//
//  ViewController.swift
//  TicTacToe
//
//  Created by Mahjeed Marrow on 4/28/19.
//  Copyright © 2019 Mahjeed Marrow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: UIView Collection outlet
    @IBOutlet var squareCollection: [UIImageView]!
    
    //MARK: InfoView outlets
    @IBOutlet weak var infoViewLabel: UILabel!
    @IBOutlet weak var infoViewObject: InfoView!
    
    //MARK: Game piece outlets
    @IBOutlet weak var xPiece: GamePiece!
    @IBOutlet weak var oPiece: GamePiece!
    
    //set initial turn
    var userTurnIsX: Bool = true
    
    //MARK: create object instances
    var gameGrid: Grid = Grid()
    
    //MARK: view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set game piece images
        xPiece.image = UIImage(named: "X Piece")
        oPiece.image = UIImage(named: "O Piece")
        
        xPiece.layer.zPosition = 1
        oPiece.layer.zPosition = 1
        
        //begin game
        turnHandler(turn: userTurnIsX)
    }
    
    //MARK: Pan Gesture Recognizer
    @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        
        if let view = recognizer.view {
            view.center = CGPoint(x: view.center.x + translation.x,
                                  y: view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        if recognizer.state == .ended {
            checkPlacementOfPiece(turn: self.userTurnIsX, grid: self.squareCollection)
        }
    }
    //MARK: Info Button handling
    @IBAction func didTapInfoButton(_ sender: Any) {
        infoViewObject.animateInfoView()
    }
}

//MARK: Handle START of a turn
extension ViewController {
    func turnHandler(turn: Bool){
        if (turn) {
            //set oPiece inactive properties
            self.oPiece.alpha = 0.5
            self.oPiece.isUserInteractionEnabled = false
            self.xPiece.isUserInteractionEnabled = true
            
            animateXPiece()
        } else {
            self.xPiece.alpha = 0.5
            self.xPiece.isUserInteractionEnabled = false
            self.oPiece.isUserInteractionEnabled = true
            
            animateOPiece()
        }
    }
    //MARK: Animate pieces at start of turn
    func animateXPiece(){
        let xSpinAnimator = UIViewPropertyAnimator(
            duration: 1.0,
            curve: .easeIn) { self.xPiece.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                self.xPiece.alpha = 1
        }
        xSpinAnimator.startAnimation()
    }
    
    func animateOPiece(){
        let oSpinAnimator = UIViewPropertyAnimator(
            duration: 1.0,
            curve: .easeIn) { self.oPiece.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                self.oPiece.alpha = 1
        }
        oSpinAnimator.startAnimation()
    }
}

//MARK: Handle MIDDLE of a turn
extension ViewController{
    //MARK: check square placement
    func checkPlacementOfPiece(turn: Bool, grid: [UIImageView]!){
        //MARK: handle X piece mid-turn
        if turn {
            let piece = self.xPiece.frame
            
            for square in grid {
                if piece.intersects(square.frame){
                    let selectedSquare = square
                    //check if a square is already occupied
                    //user made valid move
                    if selectedSquare.accessibilityHint == "false" {
                        selectedSquare.image = UIImage(named: "X Piece")
                        returnXToSpot(gamePiece: self.xPiece)
                        
                        selectedSquare.accessibilityHint = "true"
                        gameGrid.appendToX(square: selectedSquare.accessibilityLabel ?? "0")
                        
                        //check if X won the game
                        checkIfXWon()
                        
                        //change turn
                        self.userTurnIsX = false
                        turnHandler(turn: self.userTurnIsX)
                        break
                    }
                    //user made invalid move
                    else {
                        returnXToSpot(gamePiece: self.xPiece)
                        self.xPiece.alpha = 1.0
                        break
                        }
                    }
                }
            //reset position if piece is released outside of grid
            returnXToSpot(gamePiece: self.xPiece)
            }
        //MARK: Handle O piece mid-turn
        else {
            let piece = self.oPiece.frame
        
            for square in grid {
                if piece.intersects(square.frame){
                    let selectedSquare = square
                    //check if a square is already occupied
                    //user made valid move
                    if selectedSquare.accessibilityHint == "false" {
                        selectedSquare.image = UIImage(named: "O Piece")
                        returnOToSpot(gamePiece: self.oPiece)
                        
                        selectedSquare.accessibilityHint = "true"
                        gameGrid.appendToO(square: selectedSquare.accessibilityLabel ?? "0")
                        
                        //check if X won the game
                        checkIfOWon()
                        
                        //change turn
                        self.userTurnIsX = true
                        turnHandler(turn: self.userTurnIsX)
                        break
                        }
                    //user made invalid move
                    else {
                        returnOToSpot(gamePiece: self.oPiece)
                        self.oPiece.alpha = 1.0
                        break
                        }
                    }
                }
            //reset position if piece is released outside of grid
            returnOToSpot(gamePiece: self.oPiece)
            }
        }
    //MARK: return game pieces to original spot after turn
    func returnXToSpot(gamePiece: UIImageView){
        gamePiece.alpha = 0
        
        let returnAnimator = UIViewPropertyAnimator(
            duration: 0.2,
            curve: .easeIn) {
                gamePiece.frame.origin.x = 20
                gamePiece.frame.origin.y = 530
                gamePiece.alpha = 0.5}
        
        returnAnimator.startAnimation()
    }
    
    func returnOToSpot(gamePiece: UIImageView){
        gamePiece.alpha = 0
        
        let returnAnimator = UIViewPropertyAnimator(
            duration: 0.2,
            curve: .easeIn) {
                gamePiece.frame.origin.x = 255
                gamePiece.frame.origin.y = 530
                gamePiece.alpha = 0.5}
        
        returnAnimator.startAnimation()
        }
}

//MARK: handle end of game logic
extension ViewController{
    //MARK: implement game outcome functions
    func checkIfXWon(){
        if gameGrid.didXWin(){
            let xWonText = "Player X Wins!"
            replayViewAnimator(labelText: xWonText)
            
            Timer.scheduledTimer(timeInterval: TimeInterval(3), target: self, selector: Selector(("clearBoard")), userInfo: nil, repeats: false)
            
        } else {
            checkIfItsATie()
        }
    }
    
    func checkIfOWon(){
        if gameGrid.didOWin(){
            let oWonText = "Player O Wins!"
            replayViewAnimator(labelText: oWonText)
            
            Timer.scheduledTimer(timeInterval: TimeInterval(3), target: self, selector: Selector(("clearBoard")), userInfo: nil, repeats: false)
        } else {
            checkIfItsATie()
        }
    }
    
    func checkIfItsATie(){
        if gameGrid.isGridFull(grid: squareCollection){
            let tieText = "Tie Game!"
            replayViewAnimator(labelText: tieText)
            
            Timer.scheduledTimer(timeInterval: TimeInterval(3), target: self, selector: Selector(("clearBoard")), userInfo: nil, repeats: false)
        }
    }
    
    //MARK: animate info view after game ends
    func replayViewAnimator(labelText: String){
        self.infoViewLabel.text = labelText
        infoViewObject.animateInfoView()
    }
    
    //MARK: clear the board for a new game
    @objc func clearBoard(){
        resetInitialGameConditions()
        removeImagesFromGrid()
        createNewGrid()
    }
    
    //MARK: reset initial turn logic
    func resetInitialGameConditions(){
        self.userTurnIsX = true
        self.xPiece.alpha = 1.0
        self.oPiece.alpha = 0.5
        self.oPiece.isUserInteractionEnabled = false
        self.xPiece.isUserInteractionEnabled = true
        animateXPiece()
        self.infoViewLabel.text = "Get 3 in a row to win!"
    }
    
    //MARK: reset grid in GUI
    func removeImagesFromGrid(){
        for square in squareCollection{
            square.image = nil
        }
    }
    
    //MARK: reset grid logic
    func createNewGrid(){
        gameGrid = Grid()
        
        for square in squareCollection{
            square.accessibilityHint = "false"
        }
    }
}

