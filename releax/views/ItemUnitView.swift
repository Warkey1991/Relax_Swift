//
//  ItemUnitView.swift
//  releax
//
//  Created by songyuanjin on 2018/12/20.
//  Copyright © 2018 songyuanjin. All rights reserved.
//

import UIKit
class ItemUnitView: UIStackView {
    //MARK: initialzation
    override init(frame: CGRect) {
        super.init(frame:frame)
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setItem(image: UIImage?, title: String) {
        axis = .vertical
        spacing = 16
        alignment = .center
        let imageView = UIImageView(image: image)
        let label = UILabel()
        label.text = title
        label.textColor = UIColor.white
        label.font = UIFont.init(name: label.font.fontName, size: 12)
        addArrangedSubview(imageView)
        addArrangedSubview(label)
    }
    
}
