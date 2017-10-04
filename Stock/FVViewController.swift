//
//  FVcontrollerViewController.swift
//  Stock
//
//  Created by Xin Lyu on 2017-09-27.
//  Copyright © 2017 zhiyuan li. All rights reserved.
//

import UIKit

class FVViewController: UIViewController {
    
    
    @IBOutlet weak var openc: UILabel!
    @IBOutlet weak var lowc: UILabel!
    @IBOutlet weak var highc: UILabel!
    @IBOutlet weak var avc: UILabel!
    @IBOutlet weak var wl: UILabel!
    @IBOutlet weak var wh: UILabel!
    @IBOutlet weak var vc: UILabel!
    @IBOutlet var contentview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func refreshdetail(contecnt:StockRecord){
        
           self.openc?.text = "\(contecnt.openPrice!)"

        
    }
}
