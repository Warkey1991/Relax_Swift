//
//  CollectionReusableView.swift
//  releax
//
//  Created by songyuanjin on 2018/12/24.
//  Copyright © 2018 songyuanjin. All rights reserved.
//

import UIKit

class CollectionReusableView: UIView {
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    private func initView() {
        self.addSubview(label)
        label.textColor = UIColor.white
        label.snp.makeConstraints{make->Void in
            make.height.equalTo(40)
            make.width.equalTo(self.frame.width)
            make.left.equalTo(16)
            make.top.equalTo(20)
        }
    }
    
    public func setText(text: String) {
        label.text = text
    }
    
}
