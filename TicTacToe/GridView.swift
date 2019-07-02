//
//  GridView.swift
//  TicTacToe
//
//  Created by Mahjeed Marrow on 4/28/19.
//  Copyright © 2019 Mahjeed Marrow. All rights reserved.
//

import UIKit

class GridView: UIView {

    //MARK: draw grid
    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        
        let lines = UIBezierPath()
        
        //draw horizontal lines first
        lines.move(to: CGPoint(x: 0.0, y: height/3))
        lines.addLine(to: CGPoint(x: width, y: height/3))
        
        lines.move(to: CGPoint(x: 0.0, y: 2 * height/3))
        lines.addLine(to: CGPoint(x: width, y: 2 * height/3))
        
        //now vertical lines
        lines.move(to: CGPoint(x: width/3, y: 0.0))
        lines.addLine(to: CGPoint(x: width/3, y: height))
        
        lines.move(to: CGPoint(x: 2 * width/3, y: 0.0))
        lines.addLine(to: CGPoint(x: 2 * width/3, y: height))
        
        //set line width and draw all of the lines
        lines.lineWidth = 5
        lines.stroke()
    }
}
