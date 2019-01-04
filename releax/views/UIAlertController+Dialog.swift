//
//  UIAlertController+Dialog.swift
//  releax
//
//  Created by songyuanjin on 2019/1/3.
//  Copyright © 2019 songyuanjin. All rights reserved.
//

import UIKit
import SnapKit

extension UIAlertController {
    
    public convenience init(customView : UIView, closure:@escaping (_ make: ConstraintMaker) -> Void){
        self.init(title:nil, message:nil, preferredStyle: UIAlertController.Style.alert)
        view.clipsToBounds = false
        
        customView.tag = 1111
        view.addSubview(customView)

        // 这里需要加一个action 不然会报错
        let action = UIAlertAction(title:"", style: .default, handler:nil)
        addAction(action)

        //约束
        customView.snp.makeConstraints { (make) in
            closure(make)
        }

        // 隐藏系统的View
        _ = self.view.subviews.compactMap { (view) -> Void in
            if view.tag != 1111 {
                view.isHidden = true
            }else {
                view.isHidden = false
            }
        }
    }
    
    
    public func show(animated: Bool = true, style: UIBlurEffect.Style? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: animated, completion: completion)
        }
    }

}
