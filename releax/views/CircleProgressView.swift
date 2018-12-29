//
//  CircleProgressView.swift
//  releax
//
//  Created by songyuanjin on 2018/12/21.
//  Copyright © 2018 songyuanjin. All rights reserved.
//

import UIKit
class CircleProgressView: UIView {
    var unfinishedCircleLayer: CAShapeLayer?
    var finishedCircleLayer: CAShapeLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawCircle()
    }
    
    required init?(coder:NSCoder) {
      super.init(coder: coder)
      drawCircle()
    }
    
    func drawCircle(progress: Double = 0) {
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
        let y = self.frame.origin.y + radius
        let mainPath = UIBezierPath(arcCenter: CGPoint(x: 0, y: y), radius: radius, startAngle: CGFloat(-M_PI_2), endAngle: CGFloat(M_PI*3.0/2.0), clockwise: true)
        unfinishedCircleLayer = CAShapeLayer()
        unfinishedCircleLayer?.path = mainPath.cgPath
        unfinishedCircleLayer?.lineWidth = 6
        unfinishedCircleLayer?.frame = self.bounds
        unfinishedCircleLayer?.fillColor = UIColor.clear.cgColor
        unfinishedCircleLayer?.strokeColor = UIColor.init(displayP3Red: 255, green: 255, blue: 255, alpha: 0.3).cgColor
        self.layer.addSublayer(unfinishedCircleLayer!)
        
        finishedCircleLayer = CAShapeLayer()
        finishedCircleLayer?.path = mainPath.cgPath
        finishedCircleLayer?.lineWidth = 6
        finishedCircleLayer?.frame = self.bounds
        finishedCircleLayer?.fillColor = UIColor.clear.cgColor
        finishedCircleLayer?.strokeColor = UIColor.init(displayP3Red: 255, green: 255, blue: 255, alpha: 1).cgColor
        finishedCircleLayer?.strokeEnd = 0
        self.layer.addSublayer(finishedCircleLayer!)
    }
    
    func drawAngle(progress: Double) {
        finishedCircleLayer?.strokeEnd = CGFloat(progress)
    }
}
