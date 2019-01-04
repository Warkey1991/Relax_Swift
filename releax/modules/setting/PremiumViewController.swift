//
//  PremiumViewController.swift
//  releax
//
//  Created by songyuanjin on 2019/1/4.
//  Copyright © 2019 songyuanjin. All rights reserved.
//

import UIKit

class PremiumViewController: UIViewController, VipAlertOperationProtocol {
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .custom
        
        let vipView = VipAlertView()
        self.view.addSubview(vipView)
        vipView.delegate = self
        vipView.snp.makeConstraints{make->Void in
            make.width.equalTo(280)
            make.height.equalTo(280)
            make.center.equalToSuperview()
        }
    }
    
    
    func closeAlert() {
        self.dismiss(animated: false, completion: nil)
    }
    
    func goPurchase() {
        print("goPurchase")
    }
    

}
