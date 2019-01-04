//
//  SettingController.swift
//  releax
//
//  Created by songyuanjin on 2018/12/20.
//  Copyright © 2018 songyuanjin. All rights reserved.
//

import UIKit

class SettingController: UIViewController {
    var titleLabel: UILabel = UILabel()
    let labels: [String] = ["Notification", "Like Us", "Feedback", "About Privacy"]
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageBg = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        imageBg.image = UIImage(named: "main_background")
        view.insertSubview(imageBg, at: 0)
        
        initViews()
    }
    
    func initViews() {
        let topBarView = UIView(frame: CGRect(x: 0, y: 30, width: view.frame.width, height: 60))
        view.addSubview(topBarView)
        titleLabel = UILabel()
        titleLabel.text = "Settings"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont(name: self.titleLabel.font.fontName, size: 20)
        topBarView.addSubview(self.titleLabel)
        
        let lineView = LineView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 1))
        lineView.backgroundColor = UIColor.white
        self.view.addSubview(lineView)
        
        titleLabel.snp.makeConstraints{(make)->Void in
            make.height.equalTo(40)
            make.left.equalTo(16)
            make.centerY.equalTo(topBarView)
        }
        
        lineView.snp.makeConstraints{make->Void in
              make.height.equalTo(1)
              make.bottom.equalTo(topBarView).offset(0)
        }
        
        //添加UIScrollview以保证所有条目都能显示
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - topBarView.frame.height))
        scrollView.bounces = true
       
        scrollView.alwaysBounceVertical = true
        scrollView.scrollsToTop = true
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints{make->Void in
            make.height.equalTo(self.view.frame.height - topBarView.frame.height)
            make.width.equalToSuperview()
            make.top.equalTo(lineView.snp.bottom).offset(0)
        }
        //内部内容。
        let contentView = UIStackView()
        contentView.axis = .vertical
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints{make->Void in
            make.width.equalToSuperview()
        }
        
        
        let premiumView = SettingPremiumView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        contentView.addArrangedSubview(premiumView)
        premiumView.snp.makeConstraints{make->Void in
            make.height.equalTo(100)
            make.width.equalToSuperview()
        }
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showVipALertView))
        premiumView.isUserInteractionEnabled = true
        premiumView.addGestureRecognizer(gestureRecognizer)
       
        
        //单个条目
        for i in 0..<labels.count {
            let itemView = SettingItemView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80))
            contentView.addArrangedSubview(itemView)
            itemView.setText(labels[i])
            itemView.snp.makeConstraints{make->Void in
                make.height.equalTo(80)
                make.width.equalToSuperview()
           }
        }
       
        let contentHeight = CGFloat(80 * labels.count + 160)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: contentHeight)
    }
    
    @objc func showVipALertView() {
        let premiumViewController = PremiumViewController()
        premiumViewController.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.present(premiumViewController, animated: true, completion: nil)
    }
    
  
}

