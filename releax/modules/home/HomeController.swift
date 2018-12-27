//
//  HomeController.swift
//  releax
//
//  Created by songyuanjin on 2018/12/20.
//  Copyright © 2018 songyuanjin. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class HomeController: UIViewController,  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SelectorProtocol {
    
    var adImageViewBG: UIImageView = UIImageView()
    var adImageView: UIImageView = UIImageView()
    var adGifImageView: UIImageView = UIImageView()
    var titleLabel: UILabel = UILabel()
    var functionView: FunctionController!
    var layout = UICollectionViewFlowLayout()
    var musicData = Array<[String: Music]>()
    var tableView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageBg = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        imageBg.image = UIImage(named: "main_background")
        view.insertSubview(imageBg, at: 0)
    
        initViews()
        initClickListener()
        
        initDatas()
    }
    
    //MARK: Private method
    //初始化布局
    func initViews() {
        let cellWidth = (self.view.frame.width) / 3
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: cellWidth, height: 140)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        tableView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.register(UINib(nibName: "MusicCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "music_Cell")
        // 注册一个headView
        tableView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header_view")

        view.addSubview(tableView)
        
        let topBarView = UIView(frame: CGRect(x: 0, y: 30, width: view.frame.width, height: 60))
        view.addSubview(topBarView)
        titleLabel = UILabel()
        titleLabel.text = "Relax Music"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont(name: self.titleLabel.font.fontName, size: 20)
        topBarView.addSubview(self.titleLabel)
        
        titleLabel.snp.makeConstraints{(make)->Void in
            make.height.equalTo(40)
            make.left.equalTo(16)
            make.centerY.equalTo(topBarView)
        }
        
        adImageViewBG = UIImageView(image: UIImage(named: "appwall_2"))
        topBarView.addSubview(adImageViewBG)
        adImageViewBG.snp.makeConstraints{make->Void in
            make.width.height.equalTo(20)
            make.right.equalTo(-16)
            make.centerY.equalTo(topBarView)
        }
        
        adImageView = UIImageView(image: UIImage(named: "appwall_1"))
        topBarView.addSubview(adImageView)
        adImageView.snp.makeConstraints{(make)->Void in
            make.width.height.equalTo(20)
            make.center.equalTo(adImageViewBG)
            make.centerY.equalTo(topBarView)
        }
        topBarView.addSubview(adGifImageView)
        adGifImageView.snp.makeConstraints{(make)->Void in
            make.width.height.equalTo(30)
            make.right.equalTo(adImageViewBG.snp.left).offset(-16)
            make.centerY.equalTo(topBarView)
        }
        
        tableView.backgroundView = nil
        tableView.snp.makeConstraints{make->Void in
            make.height.equalTo(self.view.frame.height - topBarView.frame.height - 50)
            make.top.equalTo(topBarView.snp.bottom)
            make.width.equalToSuperview()
        }
        
        functionView = FunctionController(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 90))
        adImageViewRotationAnimation()
        

        if let url = URL(string: "http://ime.cdn.cootekservice.com/default/family/image/default/christmas_appwall_icon.gif") {
            adGifImageView.kf.setImage(with: url)
        }
    }
    
    func adImageViewRotationAnimation() {
        // 1. 创建动画
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        // 2. 设置动画属性
        rotationAnim.fromValue = 0 // 开始角度
        rotationAnim.toValue = Double.pi * 2 //结束角度
        rotationAnim.repeatCount = MAXFLOAT // 重复次数
        rotationAnim.duration = 2 // 一圈所需要的时间
        rotationAnim.isRemovedOnCompletion = false //默认是true，切换到其他控制器再回来，动画效果会消失，需要设置成false，动画就不会停
        adImageViewBG.layer.add(rotationAnim, forKey: nil) // 给需要旋转的view增加动画
    }
    
    //MARK: 设置监听事件
    func initClickListener() {
        //由于是imageview所以需要添加手势事件
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(adView1Click))
        adImageView.addGestureRecognizer(singleTapGesture)
        adImageView.isUserInteractionEnabled = true
        
        functionView?.delegate = self
    }
    
    @objc func adView1Click() {
       
    }
    
    func onClickResponse(index: Int) {
        let playController = PlayController()
        playController.index = index + 1
        playController.count = 4
        let nav = UINavigationController.init(rootViewController: playController)
        self.present(nav, animated: true, completion: nil)
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return musicData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let music = musicData[section]
        var count = 0
        for (_,value) in music {
            count = value.musics?.count ?? 0
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "music_Cell", for: indexPath as IndexPath) as! MusicCollectionViewCell
        let music = musicData[indexPath.section]
        var key: String=""
        for (k, _) in music {
            key = k
            break
        }
        let musicItems = music[key]?.musics
        let item = musicItems?[indexPath.row]
        
        cell.initData(imageUrl: item?.thumb_url, name: item?.title)
        return cell
    }
    
    //设置header 的宽高
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize.init(width: functionView?.frame.width ?? 0, height: functionView?.frame.height ?? 0)
        } else {
            return CGSize.init(width: 400, height: 60)
        }
    }
    
    //添加headerView 的布局
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableview: UICollectionReusableView!
        if kind == UICollectionView.elementKindSectionHeader {
            reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header_view", for: indexPath)
            for view in reusableview.subviews {
                view.removeFromSuperview()
            }
            if indexPath.section != 0 {
                let headerView = CollectionReusableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 90))
                let music = musicData[indexPath.section]
                for (key, _) in music {
                    headerView.setText(text: key)
                    break
                }
                reusableview.addSubview(headerView)
            } else {
                reusableview.addSubview(functionView!)
            }
        }
        return reusableview
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let playController = PlayController()
        playController.index = indexPath.row + 1
        let music = musicData[indexPath.section]
        var count = 0
        var musicItems: [MusicItem]?
        for (_,value) in music {
            count = value.show_nums ?? 0
            musicItems = value.musics
        }
        playController.count = count
        playController.musicItems = musicItems
        let nav = UINavigationController.init(rootViewController: playController)
        self.present(nav, animated: true, completion: nil)
    }

    func initDatas() {
        let jsonMusicDict = JsonConvertModel.jsonConvertMusic("sleep_music_course_list.json", "sleep_music_natural.json","sleep_music_wake_up.json","sleep_series_default.json","tab_home_default_source.json")
        musicData.insert([String:Music](), at: 0)
        musicData.insert(contentsOf: jsonMusicDict, at: 1)
        tableView.reloadData()
    }
}
