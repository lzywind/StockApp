			//
//  Week.swift
//  Stock
//
//  Created by zhiyuan li on 2017-08-01.
//  Copyright © 2017 zhiyuan li. All rights reserved.
//

import UIKit

class Week: UITableViewController {
    
    var fruits = ["Apple", "Apricot", "Banana", "Blueberry", "Cantaloupe","Cherry", "Clementine", "Coconut", "Cranberry", "Fig", "Grape"]
    

    @IBOutlet var TabelViewB: UITableView!
    
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
        return fruits.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableBCell", for: indexPath) as! TableViewCellB
        
        let fruitName = fruits[indexPath.row]
        cell.name.text = fruitName
        cell.date.text="Time Stamps"
        cell.price.text="Price Range"
        cell.profit.text="Benefit/Loss"
        
        cell.name.layer.borderWidth = 1.0
        cell.name.layer.borderColor=UIColor.lightGray.cgColor
        cell.date.layer.borderWidth = 1.0
        cell.date.layer.borderColor=UIColor.lightGray.cgColor
        cell.price.layer.borderWidth = 1.0
        cell.price.layer.borderColor=UIColor.lightGray.cgColor
        cell.profit.layer.borderWidth = 1.0
        cell.profit.layer.borderColor=UIColor.lightGray.cgColor
        
        if(indexPath.row==0){
            cell.layer.backgroundColor=UIColor.black.cgColor
        }else{
            cell.layer.backgroundColor=UIColor.darkGray.cgColor
        }
        
        return cell
    }
    
}

