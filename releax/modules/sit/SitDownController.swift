//
//  SitDownController.swift
//  releax
//
//  Created by songyuanjin on 2018/12/20.
//  Copyright © 2018 songyuanjin. All rights reserved.
//

import UIKit
class SitDownController: UIViewController {
    var titleLabel: UILabel = UILabel()
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
        titleLabel.text = "Guided Relaxation"
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
    }
}
