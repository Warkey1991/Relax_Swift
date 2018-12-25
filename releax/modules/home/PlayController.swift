//
//  PlayController.swift
//  releax
//
//  Created by songyuanjin on 2018/12/21.
//  Copyright © 2018 songyuanjin. All rights reserved.
//

import UIKit
import Kingfisher

class PlayController: UIViewController {
    var index: Int = 0
    var count: Int = 0
    var progressView: CircleProgressView?
    var pause: Bool = false
    var imageBg:UIImageView!
    var musicItems: [MusicItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageBg = UIImageView(frame: self.view.bounds)
        imageBg.backgroundColor = UIColor.black
        imageBg.contentMode = .scaleAspectFill
        view.addSubview(imageBg)
        
        initNavigation()
        initContentView()
        addButtons()
        
        initData()
    }
    
    private func initData() {
        if musicItems != nil {
            guard let music = musicItems?[index - 1] else {
                fatalError("music nil")
            }
            
            if let url = URL(string: music.banner_url!) {
                imageBg.kf.setImage(with: url)
//                imageBg.kf.setImage(with: url, placeholder: UIImage(named: "play_bg"), options: nil, progressBlock: nil, completionHandler: nil)
            }
       }
    }
    
    private func initNavigation() {
        //设置title 颜色
        self.navigationItem.title = "\(index)/\(count)"
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
        
        //toobar back 按钮设置
        let backButtonItem = UIBarButtonItem(image:UIImage(named: "toolbar_back")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButtonItem
        
        let rightButtonItem = UIBarButtonItem(image:UIImage(named: "ad")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: .plain, target: self, action: #selector(filterAd))
        
        self.navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    private func initContentView() {
        progressView = CircleProgressView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width*2/3, height: self.view.frame.width*2/3))
        self.view.addSubview(self.progressView!)
        self.progressView?.snp.makeConstraints{make->Void in
            make.centerY.equalTo(self.view).offset(-220)
            make.centerX.equalTo(self.view)
        }
        
        let itemLabel = UILabel()
        itemLabel.text = "Sleep"
        itemLabel.textColor = UIColor.white
        
        let timeLabel = UILabel()
        timeLabel.text = "04:08"
        timeLabel.font = UIFont(name: timeLabel.font.fontName, size: 20)
        timeLabel.textColor = UIColor.white
        
        let circleContentView = UIStackView()
        circleContentView.axis = NSLayoutConstraint.Axis.vertical
        circleContentView.alignment = UIStackView.Alignment.center
        circleContentView.spacing = 8
        
        circleContentView.addArrangedSubview(itemLabel)
        circleContentView.addArrangedSubview(timeLabel)
        self.progressView?.addSubview(circleContentView)
        
        //此处不理解
        circleContentView.snp.makeConstraints{make->Void in
            make.centerY.equalTo(self.progressView!.center)
            make.centerX.equalTo(self.progressView!)
        }
    }
    
    func addButtons() {
        let timeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        timeButton.setImage(UIImage(named: "ic_premium_no_timer")?.withRenderingMode(.alwaysOriginal), for: .normal)
        timeButton.addTarget(self, action: #selector(setTimeClock), for: .touchUpInside)
        
        let playButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        playButton.setImage(UIImage(named: "play_play_icon")?.withRenderingMode(.alwaysOriginal),for: .normal)
        playButton.addTarget(self, action: #selector(pauseOrResumeMusic(_:)), for: .touchUpInside)
        
        let musicButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        musicButton.setImage(UIImage(named: "song_list")?.withRenderingMode(.alwaysOriginal),for: .normal)
        musicButton.addTarget(self, action: #selector(showSongList), for: .touchUpInside)
        
        let buttonStackView = UIStackView()
        buttonStackView.axis = NSLayoutConstraint.Axis.horizontal
        buttonStackView.alignment = UIStackView.Alignment.center
        buttonStackView.spacing = 60
        buttonStackView.addArrangedSubview(timeButton)
        buttonStackView.addArrangedSubview(playButton)
        buttonStackView.addArrangedSubview(musicButton)
        
        self.view.addSubview(buttonStackView)
        
        buttonStackView.snp.makeConstraints{make->Void in
            make.bottom.equalTo(self.view).offset(-80)
            make.centerX.equalTo(self.view)
        }
    }
    
    @objc func filterAd() {
        
    }
    @objc func backPressed() {
       self.dismiss(animated: true, completion: nil)
    }
    
    @objc func setTimeClock() {
        
    }
    
    @objc func pauseOrResumeMusic(_ sender: UIButton) {
        pause = !pause
        if pause {
             sender.setImage(UIImage(named: "play_pause_btn")?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            sender.setImage(UIImage(named: "play_play_icon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    @objc func showSongList() {
        
    }
    
    //视图将要显示
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //设置导航栏背景透明
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    //视图将要消失
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //重置导航栏背景
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
}
