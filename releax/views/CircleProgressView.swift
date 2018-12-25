//
//  CircleProgressView.swift
//  releax
//
//  Created by songyuanjin on 2018/12/21.
//  Copyright © 2018 songyuanjin. All rights reserved.
//

import UIKit
class CircleProgressView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawCircle()
    }
    
    required init?(coder:NSCoder) {
      super.init(coder: coder)
      drawCircle()
    }
    
    
    func drawCircle() {
        /*
         参数解释：
         1.center: CGPoint  中心点坐标
         2.radius: CGFloat  半径
         3.startAngle: CGFloat 起始点所在弧度
         4.endAngle: CGFloat   结束点所在弧度
         5.clockwise: Bool     是否顺时针绘制
         7.画圆时，没有坐标这个概念，根据弧度来定位起始点和结束点位置。M_PI即是圆周率。画半圆即(0,M_PI),代表0到180度。全圆则是(0,M_PI*2)，代表0到360度
         */
        let radius = self.frame.width / 2
        let x = self.frame.origin.x + radius
        let y = self.frame.origin.y + radius
        let mainPath = UIBezierPath(arcCenter: CGPoint(x: 0, y: y), radius: radius, startAngle: CGFloat(M_PI) * 0, endAngle: CGFloat(M_PI) * 2, clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = mainPath.cgPath //存入UIBezierPath的路径
        shapeLayer.fillColor = UIColor.clear.cgColor //设置填充色
        shapeLayer.lineWidth = 2  //设置路径线的宽度
        shapeLayer.strokeColor = UIColor.white.cgColor //路径颜色
        self.layer.addSublayer(shapeLayer)
    }
}
