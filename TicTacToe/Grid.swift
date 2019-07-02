//
//  Grid.swift
//  TicTacToe
//
//  Created by Mahjeed Marrow on 4/30/19.
//  Copyright © 2019 Mahjeed Marrow. All rights reserved.
//

import UIKit

//MARK: game logic representation of grid
class Grid {
    
    let winningCombinations =  [[1, 2, 3],[4, 5, 6],[7, 8, 9],
                                [1, 4, 7],[2, 5, 8],[3, 6, 9],
                                [1, 5, 9],[3, 5, 7]]
    
    var xSquares: [Int] = []
    var oSquares: [Int] = []
    
    //MARK: check if X won
    func didXWin() -> Bool {
        //source: stackoverflow.com/questions/25714985/how-to-determine-if-one-array-contains-all-elements-of-another-array-in-swift
        for combo in winningCombinations{
            let comboSet = Set(combo)
            let squareSet = Set(xSquares)
            
            if comboSet.isSubset(of: squareSet) {
                return true
            }
        }
        return false
    }
    
    //MARK: check if O won
    func didOWin() -> Bool {
        for combo in winningCombinations{
            let comboSet = Set(combo)
            let squareSet = Set(oSquares)
            
            if comboSet.isSubset(of: squareSet) {
                return true
            }
        }
        return false
    }
    
    //MARK: check if a given square is full
    func isSquareOccupied(square: UIImageView!) -> Bool {
        if square.accessibilityHint == "true" {
            return true
        } else {
            return false
        }
    }
    
    //MARK: check for tie game
    func isGridFull(grid: [UIImageView]!) -> Bool {
        for square in grid {
            if square.accessibilityHint == "false" {
                return false
            }
        }
        return true
    }
    
    //MARK: append to array of occupied squares
    func appendToX(square: String){
        let gridNumber:Int = Int(square) ?? 0
        xSquares.append(gridNumber)
    }
    
    func appendToO(square: String){
        let gridNumber:Int = Int(square) ?? 0
        oSquares.append(gridNumber)
    }
}
