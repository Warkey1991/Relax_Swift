//
//  MoveView.swift
//  releax
//
//  Created by songyuanjin on 2018/12/28.
//  Copyright © 2018 songyuanjin. All rights reserved.
//

import UIKit

class MoveView: UIView {
    var imageView: UIImageView!
    var startFrame: CGRect?
    var endFrame: CGRect?
    var animationDuration: Int?
    var direction: EStartMoveDirection = .RIGHT
    var image: UIImage?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    enum EStartMoveDirection {
        case LEFT, RIGHT
    }
    
    func initView() {
        let height = self.frame.size.height;
        let imageSize = self.image?.size;
        let imageViewWidth = height / (imageSize?.height ?? 1) * (imageSize?.width ?? 1);
        // 获取到了尺寸
        imageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: imageViewWidth, height: height))
        imageView?.image = image!
        
        // 获取初始尺寸
        startFrame = imageView?.frame;
        endFrame = CGRect(x: self.frame.size.width - (imageView?.frame.size.width)!, y: 0, width: imageViewWidth, height: height)
        
       addSubview(imageView)
    }
    
    
    func doAnimation() {
        if (direction == .RIGHT) {
            imageView?.frame = startFrame!
        } else {
           imageView?.frame = endFrame!
        }
        // 获取动画时间
        animationDuration = (self.animationDuration ?? 80);
        // 开始动画
        startAnimation()
    }
    
    func startAnimation() {
        let options: UIView.AnimationOptions = [UIView.AnimationOptions.repeat,UIView.AnimationOptions.autoreverse,UIView.AnimationOptions.curveLinear]
        if (direction == .RIGHT) {
            UIView.animate(withDuration: TimeInterval(animationDuration!), delay: 0, options: options, animations: {
                self.imageView?.frame = self.endFrame!
            }, completion: {b->Void in
                
            })
        } else {
            UIView.animate(withDuration: TimeInterval(animationDuration!), delay: 0, options: options, animations: {
                self.imageView?.frame = self.startFrame!
            }, completion: {b->Void in
                
            })

        }
    }
     
}
