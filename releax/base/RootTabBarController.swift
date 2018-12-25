//
//  RootTabBarController.swift
//  releax
//
//  Created by songyuanjin on 2018/12/20.
//  Copyright © 2018 songyuanjin. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Thread.sleep(forTimeInterval: 2.0) //延长3秒
        createSubViewControllers()
    }
    
    func createSubViewControllers() {
        let homeController = HomeController()
        let item1: UITabBarItem = UITabBarItem(title: "", image: UIImage(named: "newmain_tab_course_unselected"), selectedImage: UIImage(named: "newmain_tab_course_selected"))
        item1.selectedImage = item1.selectedImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        homeController.tabBarItem = item1
        
        let sitDownController = SitDownController()
        let item2: UITabBarItem = UITabBarItem(title: "", image: UIImage(named: "newmain_tab_music_unselected"), selectedImage: UIImage(named: "newmain_tab_music_selected"))
        item2.selectedImage = item2.selectedImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        sitDownController.tabBarItem = item2
        
        let settingController = SettingController()
        let item3: UITabBarItem = UITabBarItem(title: "", image: UIImage(named: "newmain_tab_me_unselected"), selectedImage: UIImage(named: "newmain_tab_me_selected"))
        item3.selectedImage = item3.selectedImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        settingController.tabBarItem = item3
        
        self.tabBar.barTintColor = UIColor.black
        let items = [homeController, sitDownController, settingController]
        self.viewControllers = items
        
    }


}
