//
//  SettingItemView.swift
//  releax
//
//  Created by songyuanjin on 2018/12/21.
//  Copyright © 2018 songyuanjin. All rights reserved.
//

import UIKit
class SettingItemView: UIView {
    var text: String?
    var rightImage: UIImage?
    let textLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("height:\(frame.height)")
        initView()
    }
    
    required init?(coder:NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    func initView() {
        textLabel.text = "Notification"
        textLabel.font = UIFont(name: textLabel.font.fontName, size: 16)
        textLabel.textColor = UIColor.white
        
        let lineView = LineView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 1))
        lineView.backgroundColor = UIColor.white
        
        let rightImageView = UIImageView()
        rightImageView.image = UIImage(named:"homepage_more_icon")?.withRenderingMode(.alwaysOriginal)
        
        addSubview(textLabel)
        addSubview(rightImageView)
        addSubview(lineView)
        
        textLabel.snp.makeConstraints{make->Void in
            make.centerY.equalTo(self.center)
            make.left.equalTo(self).offset(16)
        }

        rightImageView.snp.makeConstraints{make->Void in
           make.centerY.equalToSuperview()
           make.right.equalToSuperview().offset(-16)
        }

        lineView.snp.makeConstraints{make->Void in
            make.bottom.equalTo(0)
            make.left.equalTo(self).offset(16)
        }
    }
    
    func setText(_ text: String) {
        textLabel.text = text
    }
    
}


