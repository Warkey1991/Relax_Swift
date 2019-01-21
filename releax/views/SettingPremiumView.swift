//
//  SettingPremiumView.swift
//  releax
//
//  Created by songyuanjin on 2018/12/24.
//  Copyright © 2018 songyuanjin. All rights reserved.
//

import UIKit
class SettingPremiumView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    func initView() {
        let titleAndImageView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 20))
        let titleLabel = UILabel()
        titleLabel.text = "Premium Account"
        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 16)
        titleLabel.textColor = UIColor.white
        
        let hotImageView = UIImageView(image: UIImage(named: "hot")?.withRenderingMode(.alwaysOriginal))
        titleAndImageView.addSubview(titleLabel)
        titleAndImageView.addSubview(hotImageView)
        addSubview(titleAndImageView)
        titleAndImageView.snp.makeConstraints{make->Void in
            make.top.equalToSuperview().offset(16)
        }
        titleLabel.snp.makeConstraints{make->Void in
             make.left.equalTo(self).offset(16)
             make.centerY.equalTo(titleAndImageView.center)
        }
        hotImageView.snp.makeConstraints{make->Void in
            make.left.equalTo(titleLabel.snp.right).offset(8)
            make.centerY.equalTo(titleAndImageView.center)
        }
        
        let labelOne = UILabel()
        labelOne.text = "1.Remove all ads"
        labelOne.font = UIFont(name: labelOne.font.fontName, size: 14)
        labelOne.textColor = UIColor.white
        addSubview(labelOne)
        labelOne.snp.makeConstraints{make->Void in
            make.top.equalTo(titleAndImageView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(16)
        }
        let labelTwo = UILabel()
        labelTwo.text = "2.Listen to all music(including paid items)for free"
        labelTwo.font = UIFont(name: labelTwo.font.fontName, size: 14)
        labelTwo.textColor = UIColor.white
        addSubview(labelTwo)
        labelTwo.snp.makeConstraints{make->Void in
            make.top.equalTo(labelOne.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(16)
        }
       
        
        let rightImageView = UIImageView(image: UIImage(named: "homepage_more_icon")?.withRenderingMode(.alwaysOriginal))
        addSubview(rightImageView)
        rightImageView.snp.makeConstraints{make->Void in
            make.centerY.equalTo(self.center)
            make.right.equalToSuperview().offset(-16)
        }
        
        let lineView = LineView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 1))
        lineView.backgroundColor = UIColor.white
        addSubview(lineView)
        lineView.snp.makeConstraints{make->Void in
            make.bottom.equalTo(0)
            make.left.equalTo(self).offset(16)
        }
    }
}
