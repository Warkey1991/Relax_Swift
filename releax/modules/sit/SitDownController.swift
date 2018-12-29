//
//  SitDownController.swift
//  releax
//
//  Created by songyuanjin on 2018/12/20.
//  Copyright © 2018 songyuanjin. All rights reserved.
//

import UIKit
class SitDownController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    var titleLabel: UILabel = UILabel()
    var courseCollectionView: UICollectionView!
    var layout = UICollectionViewFlowLayout()
    var courses: [Course]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageBg = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        imageBg.image = UIImage(named: "main_background")
        view.insertSubview(imageBg, at: 0)
        
        initViews()
        initData()
    }
    
    func initViews() {
        let topBarView = UIView(frame: CGRect(x: 0, y: 30, width: view.frame.width, height: 60))
        view.addSubview(topBarView)
        titleLabel = UILabel()
        titleLabel.text = "Guided Relaxation"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont(name: self.titleLabel.font.fontName, size: 20)
        topBarView.addSubview(self.titleLabel)
        
        let lineView = LineView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 1))
        lineView.backgroundColor = UIColor.white
        self.view.addSubview(lineView)
        
        titleLabel.snp.makeConstraints{(make)->Void in
            make.height.equalTo(40)
            make.left.equalTo(16)
            make.centerY.equalTo(topBarView)
        }
        
        lineView.snp.makeConstraints{make->Void in
            make.height.equalTo(1)
            make.bottom.equalTo(topBarView).offset(0)
        }
        
        
        let cellWidth = (self.view.frame.width) / 3
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: cellWidth, height: 150)
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        courseCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        courseCollectionView.delegate = self
        courseCollectionView.dataSource = self
        courseCollectionView.backgroundColor = UIColor.clear
        courseCollectionView.register(UINib(nibName: "MusicCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "course_Cell")
        // 注册一个headView
        courseCollectionView.register(CourseReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header_view")
        
        view.addSubview(courseCollectionView)
        
        courseCollectionView.backgroundView = nil
        courseCollectionView.snp.makeConstraints{make->Void in
            make.height.equalTo(self.view.frame.height - topBarView.frame.height - 50)
            make.top.equalTo(topBarView.snp.bottom)
            make.width.equalToSuperview()
        }
        
    }
    
    private func initData() {
        courses = JsonConvertCourseModel.jsonConvertToModel(fileName: "course.json")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return courses?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let course = courses?[section]
        return course?.resources?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "course_Cell", for: indexPath as IndexPath) as! MusicCollectionViewCell
        let item = courses?[indexPath.section].resources?[indexPath.row]
        cell.initData(imageUrl: item?.thumb_url, name: item?.title)
        return cell
    }
    
    //设置header 的宽高
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: 400, height: 60)
    }
    
    //添加headerView 的布局
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //var reusableview: UICollectionReusableView!
        if kind == UICollectionView.elementKindSectionHeader {
            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header_view", for: indexPath) as! CourseReusableView
            let name = courses?[indexPath.section].classes
            reusableview.setText(text: name!)
            return reusableview
        }
        return UICollectionReusableView()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let playController = PlayController()
        playController.index = indexPath.row + 1
        let nav = UINavigationController.init(rootViewController: playController)
        self.present(nav, animated: true, completion: nil)
    }

    
}
