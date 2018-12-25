//
//  MusicCollectionViewCell.swift
//  releax
//
//  Created by songyuanjin on 2018/12/24.
//  Copyright © 2018 songyuanjin. All rights reserved.
//

import UIKit
import Kingfisher

class MusicCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imagePic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imagePic.layer.cornerRadius = 8
        imagePic.layer.masksToBounds = true
    }
    
    func initData(imageUrl: String?, name: String?) {
        nameLabel.text = name
        guard imageUrl != nil else {
            fatalError("image url not nil")
        }
        if let url = URL(string: imageUrl!) {
            imagePic.kf.setImage(with: url)
        }
    }

}
