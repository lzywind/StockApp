//
//  AccountContoller.swift
//  Stock
//
//  Created by zhiyuan li on 2017-07-29.
//  Copyright © 2017 zhiyuan li. All rights reserved.
//

import UIKit

class AccountController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    
    var accountInfo = ["profile", "email", "Journal", "language", "logo","message", "news", "something", "something2"]
    
    //    var invenInstance=InventoryController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountInfo.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Account", for: indexPath)
        
        let info = accountInfo[indexPath.row]
        cell.textLabel?.text = info
        //cell.detailTextLabel?.text = "Delicious!"
        cell.imageView?.image = UIImage(named: info)
        
        return cell
    }
    
    
}
