//
//  TabController.swift
//  Stock
//
//  Created by zhiyuan li on 2017-08-02.
//  Copyright © 2017 zhiyuan li. All rights reserved.
//

import UIKit

class TabController: UITabBar {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("wqe")
        if(item.tag==1){
            print("0")
        }
    }

}
