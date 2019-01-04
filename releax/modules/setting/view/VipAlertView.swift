//
//  VipAlertView.swift
//  releax
//
//  Created by songyuanjin on 2019/1/3.
//  Copyright © 2019 songyuanjin. All rights reserved.
//

import UIKit

class VipAlertView: UIView {
    var vipImageView: UIImageView!
    var closeButton: UIButton!
    var topImageView: UIImageView!
    var descLabel: UILabel!
    var priceButton:UIButton!
    var delegate: VipAlertOperationProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    func initView() {
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: 280, height: 280))
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = UIColor.white
        self.addSubview(contentView)
        
        topImageView = UIImageView(image: UIImage(named:"premium_purchase_bg"))
        contentView.addSubview(topImageView)
        topImageView.snp.makeConstraints{make->Void in
            
        }
        
        contentView.snp.makeConstraints{make->Void in
            make.width.equalTo(topImageView.frame.width)
            make.height.equalTo(300)
            make.center.equalToSuperview()
        }
        
        vipImageView = UIImageView(image:UIImage(named: "premium_purchase_icon"))
        self.addSubview(vipImageView)

        vipImageView.snp.makeConstraints{make->Void in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(contentView).offset(-16)
        }
        
        descLabel = UILabel(frame: CGRect(x: 0, y: 0, width: topImageView.frame.width, height: 30))
        descLabel.numberOfLines = 2
        descLabel.lineBreakMode = .byWordWrapping

        descLabel.text = "Upgrade to Premium, unlock all musics and guided medtation"
        descLabel.textAlignment = .center
        contentView.addSubview(descLabel)
        
        descLabel.snp.makeConstraints{make->Void in
            make.top.equalTo(topImageView.snp.bottom).offset(16)
            make.width.equalTo(topImageView.frame.width)
        }
        
        closeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 50))
        closeButton.setImage(UIImage(named: "sm_dialog_close_icon")?.withRenderingMode(.alwaysOriginal), for: UIControl.State.normal)
        contentView.addSubview(closeButton)
        closeButton.snp.makeConstraints{make->Void in
            make.right.equalTo(-10)
            make.top.equalTo(10)
        }
        
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        
        priceButton = UIButton(frame: CGRect(x: 0, y: 0, width: topImageView.frame.width - 40, height: 60))
        priceButton.backgroundColor = UIColor.purple
        priceButton.layer.cornerRadius = 25
        priceButton.clipsToBounds = true
        priceButton.setTitle("HK$15.0/Month", for: UIControl.State.normal)
        priceButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        priceButton.addTarget(self, action: #selector(goPurchase), for: .touchUpInside)
        
        contentView.addSubview(priceButton)
        priceButton.snp.makeConstraints{make->Void in
            make.left.equalTo(20)
            make.width.equalTo(topImageView.frame.width - 40)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    @objc func closeAction() {
        if delegate != nil {
            delegate?.closeAlert()
        }
    }
    
    @objc func goPurchase() {
        if delegate != nil {
            delegate?.goPurchase()
        }
    }
}
