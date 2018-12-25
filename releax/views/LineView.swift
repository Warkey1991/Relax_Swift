//
//  LineView.swift
//  releax
//
//  Created by songyuanjin on 2018/12/21.
//  Copyright © 2018 songyuanjin. All rights reserved.
//

import UIKit
class LineView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawLine()
    }
    
    required init?(coder:NSCoder) {
        super.init(coder: coder)
        drawLine()
    }
    
    
    func drawLine() {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: self.frame.origin.x, y: 0))
        linePath.addLine(to: CGPoint(x: self.frame.width, y: 0))
        line.path = linePath.cgPath
        line.strokeColor = UIColor.gray.cgColor
        line.lineWidth = 0.1
        line.lineJoin = CAShapeLayerLineJoin.round
        self.layer.addSublayer(line)
    }
}

