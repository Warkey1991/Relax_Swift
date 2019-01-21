//
//  PlayController.swift
//  releax
//
//  Created by songyuanjin on 2018/12/21.
//  Copyright © 2018 songyuanjin. All rights reserved.
//

import UIKit
import AVFoundation
import Kingfisher
import MediaPlayer

class PlayController: UIViewController, MusicDownLoadProtocol, STKAudioPlayerDelegate {
    
    var itemLabel = UILabel()
    var timeLabel = UILabel()
    var playButton: UIButton!
    var index: Int = 0
    var count: Int = 0
    var progressView: CircleProgressView?
    var pause: Bool = false
    var imageBg:UIImageView!
    var musicItems: [MusicItem]?
    let audioPlayer = STKAudioPlayer()
    var timer: Timer = Timer()
    var canPlay: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        imageBg = UIImageView(frame: self.view.bounds)
        imageBg.backgroundColor = UIColor.black
        imageBg.contentMode = .scaleAspectFill
        view.addSubview(imageBg)
        
        let viewBG = UIView(frame: self.view.bounds)
        viewBG.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 0.4)
        view.addSubview(viewBG)
        initNavigation()
        initContentView()
        addButtons()
        
        initData()
        audioPlayer.delegate = self
    }
    
    private func initData() {
        if musicItems != nil {
            guard let music = musicItems?[index - 1] else {
                fatalError("music nil")
            }
            itemLabel.text = music.title
            if let url = URL(string: music.banner_url!) {
                imageBg.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: {(image, error, cacheType, imageUrl) in
                    let moveView = MoveView(frame: self.view.bounds)
                    self.view.insertSubview(moveView, at: 1)
                    moveView.image = image
                    moveView.initView()
                    moveView.doAnimation()
                })
            }
            
            let downLoadUrl = URL(fileURLWithPath: music.music_url ?? "" )
            if !HttpTools.fileExist(fileName: downLoadUrl.lastPathComponent) {
                HttpTools.downloadMp3(musicUrl: music.music_url ?? "", downLoadProtocol: self)
            } else {
                let ducumentPath = NSHomeDirectory() + "/Documents"
                var mp3Url = URL(fileURLWithPath: ducumentPath)
                mp3Url.appendPathComponent(downLoadUrl.lastPathComponent)
                audioPlayer.play(mp3Url)
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
        
        let circleLineView = CircleLineView(frame: CGRect(x: 0 , y: 0, width: self.view.frame.width*2/3, height: self.view.frame.width*2/3))
        self.view.addSubview(circleLineView)
//        circleLineView.snp.makeConstraints{make->Void in
//            make.centerY.equalTo(self.view).offset(-220)
//            make.centerX.equalTo(self.view)
//        }
        circleLineView.startAnimation()
        
        
        itemLabel.textColor = UIColor.white
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
        
        playButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
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
        let premiumViewController = PremiumViewController()
        premiumViewController.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.present(premiumViewController, animated: true, completion: nil)
    }
    
    @objc func backPressed() {
       self.dismiss(animated: true, completion: nil)
    }
    
    @objc func setTimeClock() {
        
    }
    
    @objc func pauseOrResumeMusic(_ sender: UIButton) {
        pause = !pause
        if pause {
            audioPlayer.pause()
            sender.setImage(UIImage(named: "play_play_icon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            audioPlayer.resume()
            sender.setImage(UIImage(named: "play_pause_btn")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    @objc func showSongList() {
        let bottomVC = BottomPopVC()
        bottomVC.musicItems = musicItems
        self.presentBottom(bottomVC)
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
        
        canPlay = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        audioPlayer.stop()
        audioPlayer.clearQueue()
        timer.invalidate()
    }
    
    func progress(pogress pogressDouble: Double) {
        let result = pogressDouble * 100
        DispatchQueue.main.async {
            self.timeLabel.text = "DownLoading(\(Int(result))%)"
        }
    }
    
    func downLoaded(saveUrl: URL) {
        if canPlay {
            audioPlayer.play(saveUrl)
        }
    }
    
    func secondsConvertMinuteAndSeconds(seconds: Int) -> (minute: Int, second: Int) {
        if seconds < 3600 {
            let minute = seconds / 60
            let second = seconds % 60
            return (minute, second)
        }
        return (0, 0)
    }
    
    func timeConvertString(minute: Int, second: Int)-> String {
        var showTime = ""
        if minute < 10 {
            showTime.append("0")
        }
        showTime.append(String(minute))
        showTime.append(":")
        if second < 10 {
            showTime.append("0")
        }
        showTime.append(String(second))
        
        return showTime
    }
    
    
    @objc func updateProgress() {
        let playProgress = Int(audioPlayer.progress)
        let duration = Int(audioPlayer.duration)
        showPlayTime(duration - playProgress)
        progressView?.drawAngle(progress: audioPlayer.progress / audioPlayer.duration)
    }
    
    func showPlayTime(_ hasSecond: Int) {
        let (minute, second) = secondsConvertMinuteAndSeconds(seconds: hasSecond)
        timeLabel.text = timeConvertString(minute: minute, second: second)
    }
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, didStartPlayingQueueItemId queueItemId: NSObject) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
        let seconds = audioPlayer.duration
        showPlayTime(Int(seconds))
        playButton.setImage(UIImage(named: "play_pause_btn")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, didFinishBufferingSourceWithQueueItemId queueItemId: NSObject) {
        
    }
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, stateChanged state: STKAudioPlayerState, previousState: STKAudioPlayerState) {
    }
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, didFinishPlayingQueueItemId queueItemId: NSObject, with stopReason: STKAudioPlayerStopReason, andProgress progress: Double, andDuration duration: Double) {
        timer.invalidate()
        progressView?.drawAngle(progress: 1)
        showPlayTime(0)
    }
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, unexpectedError errorCode: STKAudioPlayerErrorCode) {
        
    }
}
