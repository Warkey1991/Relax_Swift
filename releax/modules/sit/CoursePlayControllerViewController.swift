//
//  CoursePlayControllerViewController.swift
//  releax
//
//  Created by songyuanjin on 2018/12/29.
//  Copyright © 2018 songyuanjin. All rights reserved.
//

import UIKit
import AVFoundation
import Kingfisher
import MediaPlayer

class CoursePlayControllerViewController: UIViewController, MusicDownLoadProtocol, STKAudioPlayerDelegate {
    var progressView: CircleProgressView!
    var moveBgView: MoveView!
    var timeLabel:UILabel!
    var playImageButton: UIButton!
    var musicButton: UIButton!
    var courseItem: CourseItem?
    var imageBg:UIImageView!
    var pause: Bool = false
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
        if courseItem != nil {
            self.navigationItem.title = courseItem?.title
            if let url = URL(string: courseItem!.banner_url!) {
                imageBg.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: {(image, error, cacheType, imageUrl) in
                    let moveView = MoveView(frame: self.view.bounds)
                    self.view.insertSubview(moveView, at: 1)
                    moveView.image = image
                    moveView.initView()
                    moveView.doAnimation()
                })
            }
            
            let downLoadUrl = URL(fileURLWithPath: courseItem!.music_url ?? "" )
            if !HttpTools.fileExist(fileName: downLoadUrl.lastPathComponent) {
                HttpTools.downloadMp3(musicUrl: courseItem!.music_url ?? "", downLoadProtocol: self)
            } else {
                let ducumentPath = NSHomeDirectory() + "/Documents"
                var mp3Url = URL(fileURLWithPath: ducumentPath)
                mp3Url.appendPathComponent(downLoadUrl.lastPathComponent)
                audioPlayer.play(mp3Url)
            }
        }
    }
    
    
    private func initContentView() {
        progressView = CircleProgressView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width*2/3, height: self.view.frame.width*2/3))
        self.view.addSubview(self.progressView!)
        self.progressView?.snp.makeConstraints{make->Void in
            make.centerY.equalTo(self.view).offset(-180)
            make.centerX.equalTo(self.view)
        }
        
        timeLabel = UILabel()
        timeLabel.font = UIFont(name: timeLabel.font.fontName, size: 20)
        timeLabel.textColor = UIColor.white
        
        let circleContentView = UIStackView()
        circleContentView.axis = NSLayoutConstraint.Axis.vertical
        circleContentView.alignment = UIStackView.Alignment.center
        circleContentView.spacing = 8

        circleContentView.addArrangedSubview(timeLabel)
        self.progressView?.addSubview(circleContentView)
        
        //此处不理解
        circleContentView.snp.makeConstraints{make->Void in
            make.centerY.equalTo(self.progressView!.center)
            make.centerX.equalTo(self.progressView!)
        }
    }
    
    func addButtons() {
        let musicButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        musicButton.setImage(UIImage(named: "ic_premium_no_timer")?.withRenderingMode(.alwaysOriginal), for: .normal)
        musicButton.addTarget(self, action: #selector(setTimeClock), for: .touchUpInside)
        
        playImageButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        playImageButton.setImage(UIImage(named: "play_play_icon")?.withRenderingMode(.alwaysOriginal),for: .normal)
        playImageButton.addTarget(self, action: #selector(pauseOrResumeMusic(_:)), for: .touchUpInside)
        
        let emptyButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        let buttonStackView = UIStackView()
        buttonStackView.axis = NSLayoutConstraint.Axis.horizontal
        buttonStackView.alignment = UIStackView.Alignment.center
        buttonStackView.spacing = 60
        buttonStackView.addArrangedSubview(musicButton)
        buttonStackView.addArrangedSubview(playImageButton)
        buttonStackView.addArrangedSubview(emptyButton)
        
        self.view.addSubview(buttonStackView)
        
        buttonStackView.snp.makeConstraints{make->Void in
            make.bottom.equalTo(self.view).offset(-80)
            make.centerX.equalTo(self.view)
        }
    }
    
    private func initNavigation() {
        //设置title 颜色
        self.navigationItem.title = ""
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
        
        //toobar back 按钮设置
        let backButtonItem = UIBarButtonItem(image:UIImage(named: "toolbar_back")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButtonItem
        
        let rightButtonItem = UIBarButtonItem(image:UIImage(named: "ad")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: .plain, target: self, action: #selector(filterAd))
        
        self.navigationItem.rightBarButtonItem = rightButtonItem
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
            audioPlayer.pause()
            sender.setImage(UIImage(named: "play_play_icon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            audioPlayer.resume()
            sender.setImage(UIImage(named: "play_pause_btn")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
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
        timeLabel.font = UIFont(name: timeLabel.font.fontName, size: 40)
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
        let seconds = audioPlayer.duration
        showPlayTime(Int(seconds))
        playImageButton.setImage(UIImage(named: "play_pause_btn")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, didFinishBufferingSourceWithQueueItemId queueItemId: NSObject) {
        
    }
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, stateChanged state: STKAudioPlayerState, previousState: STKAudioPlayerState) {
    }
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, didFinishPlayingQueueItemId queueItemId: NSObject, with stopReason: STKAudioPlayerStopReason, andProgress progress: Double, andDuration duration: Double) {
        timer.invalidate()
        progressView?.drawAngle(progress: 1)
    }
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, unexpectedError errorCode: STKAudioPlayerErrorCode) {
        
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
    
}
