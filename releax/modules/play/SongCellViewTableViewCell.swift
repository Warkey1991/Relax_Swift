//
//  SongCellViewTableViewCell.swift
//  releax
//
//  Created by songyuanjin on 2019/1/8.
//  Copyright © 2019 songyuanjin. All rights reserved.
//

import UIKit
import Kingfisher

class SongCellViewTableViewCell: UITableViewCell {
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let selectedView =  UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        selectedView.backgroundColor = UIColor.black.withAlphaComponent(1)
        self.selectedBackgroundView = selectedView
        self.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        pictureImageView.snp.makeConstraints{make in
            make.size.equalTo(50)
            make.centerY.equalTo(self.center)
            make.left.equalTo(16)
        }
        pictureImageView.layer.cornerRadius = 6
        pictureImageView.layer.masksToBounds = true
        nameLabel.textColor = UIColor.white
        nameLabel.numberOfLines = 1
        nameLabel.text="Message "
        nameLabel.sizeToFit()
        nameLabel.snp.makeConstraints{make in
            make.centerY.equalTo(self.center)
            make.left.equalTo(pictureImageView.snp.right).offset(12)
        }
        
        playButton.setTitle(nil, for: UIControl.State.normal)
        playButton.setImage(UIImage(named: "homepage_musiclist_item_play_icon")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: UIControl.State.normal)
        playButton.snp.makeConstraints{make in
            make.centerY.equalTo(self.center)
            make.right.equalTo(-16)
        }
    }
    
    func bindData(musicItem: MusicItem) {
        if let picUrl = URL(string: musicItem.thumb_url!) {
            pictureImageView.kf.setImage(with: picUrl)
        }
        nameLabel.text = musicItem.title
    }
    
}
