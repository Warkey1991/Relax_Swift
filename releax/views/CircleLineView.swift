//
//  CircleLineView.swift
//  releax
//
//  Created by songyuanjin on 2019/1/8.
//  Copyright © 2019 songyuanjin. All rights reserved.
//

import UIKit



class CircleLineView: UIView {

    var circleLineLayer: CAShapeLayer?
    
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
        let mainPath = UIBezierPath(arcCenter: CGPoint(x: self.frame.width / 2, y: self.frame.height / 2), radius: self.frame.height / 2, startAngle: -(CGFloat.pi  / 2), endAngle: CGFloat.pi * 3 / 2, clockwise: true)
        circleLineLayer = CAShapeLayer()
        circleLineLayer?.path = mainPath.cgPath
        circleLineLayer?.lineWidth = 1
        circleLineLayer?.frame = self.bounds
        circleLineLayer?.fillColor = UIColor.clear.cgColor
        circleLineLayer?.strokeColor = UIColor.white.cgColor
        self.layer.addSublayer(circleLineLayer!)
    }
    
    public func startAnimation() {
        let scaleAnn = createScaleAnimation(keyPath: "transform.scale", toValue: 1.3)
        let alphaAnn = createAlphaAnimation()

        let group = CAAnimationGroup()
        group.duration = 2
        group.repeatCount = Float(CGFloat.greatestFiniteMagnitude)
        group.fillMode = .forwards
        group.animations = [scaleAnn, alphaAnn]
        
        self.circleLineLayer?.add(group, forKey: nil)
        
    }
    
    // 创建基础Animation
    func createScaleAnimation(keyPath: String, toValue: CGFloat) -> CABasicAnimation {
        //circleLineLayer?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        //创建动画对象
        let scaleAni = CABasicAnimation()
        //设置动画属性
        scaleAni.keyPath = keyPath
        //设置动画的起始位置。也就是动画从哪里到哪里。不指定起点，默认就从positoin开始
        scaleAni.toValue = toValue
        //动画持续时间
        scaleAni.duration = 2
        //动画重复次数
        scaleAni.repeatCount = Float(CGFloat.greatestFiniteMagnitude)
        return scaleAni
    }
    
    func createAlphaAnimation() -> CABasicAnimation{
        let showViewAnn = CABasicAnimation()
        showViewAnn.keyPath = "opacity"
        showViewAnn.fromValue = 1.0
        showViewAnn.toValue = 0.0
        showViewAnn.duration = 2
        showViewAnn.fillMode = .forwards
        showViewAnn.autoreverses = true
        return showViewAnn
    }
    
}
