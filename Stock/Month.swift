//
//  Month.swift
//  Stock
//
//  Created by zhiyuan li on 2017-08-01.
//  Copyright © 2017 zhiyuan li. All rights reserved.
//

import UIKit

class Month: UITableViewController{

    var recordHis = ["Name" ,"XAUUSD", "USDCAD", "Banana", "Blueberry"]
    
    
 
    @IBOutlet var TabelViewA: UITableView!
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
        return recordHis.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customcell = tableView.dequeueReusableCell(withIdentifier: "TableACell", for: indexPath) as! UITableViewCellA
        
        let fruitName = recordHis[indexPath.row]
//        cell.textLabel?.text=fruitName
        customcell.name.text=fruitName
        customcell.date.text="Time Stamps"
        customcell.price.text="Price Range"
        customcell.profit.text="Benefit/Loss"
        
        customcell.name.layer.borderWidth = 1.0
        customcell.name.layer.borderColor=UIColor.lightGray.cgColor
        customcell.date.layer.borderWidth = 1.0
        customcell.date.layer.borderColor=UIColor.lightGray.cgColor
        customcell.price.layer.borderWidth = 1.0
        customcell.price.layer.borderColor=UIColor.lightGray.cgColor
        customcell.profit.layer.borderWidth = 1.0
        customcell.profit.layer.borderColor=UIColor.lightGray.cgColor
        
        if(indexPath.row==0){
        customcell.layer.backgroundColor=UIColor.black.cgColor
        }else{
        customcell.layer.backgroundColor=UIColor.darkGray.cgColor
        }
        
        
        return customcell
    }

}
