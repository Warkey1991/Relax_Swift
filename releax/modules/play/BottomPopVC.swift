//
//  BottomPopVC.swift
//  releax
//
//  Created by songyuanjin on 2019/1/8.
//  Copyright © 2019 songyuanjin. All rights reserved.
//

import UIKit
let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height
class BottomPopVC: PresentBottomVC, UITableViewDelegate, UITableViewDataSource {
    override var controllerHeight: CGFloat {
        return 480
    }
    
    var musicItems: [MusicItem]?
    var musicTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        musicTable = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: controllerHeight))
        musicTable.backgroundColor = UIColor.clear
        musicTable.delegate = self
        musicTable.dataSource = self
        musicTable.bounces = false
        musicTable.register(UINib(nibName: "SongCellViewTableViewCell", bundle: .main), forCellReuseIdentifier: "music_Cell")
        musicTable.separatorColor = UIColor.clear
        view.addSubview(musicTable)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "music_Cell", for: indexPath as IndexPath) as! SongCellViewTableViewCell
        
        let item = musicItems?[indexPath.row]
        cell.bindData(musicItem: item!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
