//
//  tabBarViewController.swift
//  Mung
//
//  Created by Chike Chiejine on 12/10/2016.
//  Copyright © 2016 Color & Space. All rights reserved.
//

import UIKit

class tabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let tabBarItems = self.tabBar.items
        
        let discoverTab = tabBarItems?[0]
        let InvestTab = tabBarItems?[1]
        let profileTab = tabBarItems?[2]
        
        //Text
        
        for tab in tabBarItems! {
        
        tab.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor(red:0.04, green:0.44, blue:0.55, alpha:1.0)], for: UIControlState.normal)
            
        }
        
        //Normal State Images
        discoverTab?.image = UIImage(named: "test-icon")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        InvestTab?.image = UIImage(named: "test-icon")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        profileTab?.image = UIImage(named: "test-icon")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)

        UITabBar.appearance().tintColor = UIColor.white //selected tab color
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
