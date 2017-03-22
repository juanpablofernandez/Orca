//
//  TabBarController.swift
//  Orca
//
//  Created by Jay on 3/22/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = HomeViewController()
        let homeNC = UINavigationController(rootViewController: homeVC)
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home.png"), selectedImage: UIImage(named: "home.png"))
        
        let activityVC = ActivityViewController()
        let activityNC = UINavigationController(rootViewController: activityVC)
        activityVC.tabBarItem = UITabBarItem(title: "Activity", image: UIImage(named: "activity.png"), selectedImage: UIImage(named: "activity.png"))
        
        let profileVC = ProfileViewController()
        let profileNC = UINavigationController(rootViewController: profileVC)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile.png"), selectedImage: UIImage(named: "profile.png"))
        
        viewControllers = [homeNC, activityNC, profileNC]
    }
}
