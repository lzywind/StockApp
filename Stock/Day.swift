//
//  Day.swift
//  Stock
//
//  Created by zhiyuan li on 2017-08-03.
//  Copyright © 2017 zhiyuan li. All rights reserved.
//

import UIKit

class Day: UITableViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCCell", for: indexPath) as! TableViewCellC
        
        cell.name.text = "Name"
        cell.date.text="Time Stamps"
        cell.price.text="Price Range"
        cell.profit.text="Benefit/Loss"
        
        
        if(indexPath.row==0){
            cell.layer.backgroundColor=UIColor.black.cgColor
        }else{
            //cell.layer.backgroundColor=UIColor.darkGray.cgColor
        }
        
        return cell
    }


   
}
