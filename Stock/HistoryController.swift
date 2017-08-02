//
//  SecondViewController.swift
//  Stock
//
//  Created by zhiyuan li on 2017-07-29.
//  Copyright © 2017 zhiyuan li. All rights reserved.
//

import UIKit

class HistoryController: UIViewController,UITabBarDelegate {

    @IBOutlet weak var cA: UIView!
    @IBOutlet weak var cB: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.cA.alpha=1;
        self.cB.alpha=0;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("wqe")
        if(item.tag==1){
            print("0")
        }
    }


}

