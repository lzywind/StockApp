//
//  RecordController.swift
//  Stock
//
//  Created by zhiyuan li on 2017-07-31.
//  Copyright © 2017 zhiyuan li. All rights reserved.
//

import UIKit



class RecordController: UIViewController,UITableViewDelegate, UITableViewDataSource, DBConnProto{
    
    var feedItems:NSArray = NSArray()
    var selection:PortfolioRecord = PortfolioRecord();
    @IBOutlet weak var recordtbv: UITableView!
    var records = ["XAUSD", "USADCAD", "AGUSD", "USOIL", "UROIL","URUSD"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ////////////////
        //This section was added by Mathew
        //The URL string should be made beforehand and the user ID should be concatenated
        ////////////////
        self.recordtbv.delegate = self
        self.recordtbv.dataSource = self
        
        let connection = DBConn();
        connection.delegate = self
        connection.DBGet(site: "http://vassairm.dev.fast.sheridanc.on.ca/StockAgent/OwnedStock.php?userid=12345", type: "portfolio")
        ////////////////
        
        // Do any additional setup after loading the view, typically from a nib.
        //        tryrequest1()
    }
    
    //This updates the table cells
    func itemsDownloaded(items: NSArray) {
        feedItems = items;
        self.recordtbv.reloadData();
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return feedItems.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        view.tintColor=UIColor.lightGray
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordcell", for: indexPath) as! TableViewRecordCell
        

        let recordName: PortfolioRecord = feedItems[indexPath.row] as! PortfolioRecord
          cell.name.text = "\(recordName.stockID!)"
          cell.time.text = recordName.buyTime
          cell.price.text = "\(recordName.buyPrice!)"
          cell.unit.text = "\(recordName.units!)"
          cell.benifit.text = "\(recordName.profit!)"

        
        cell.name.layer.borderWidth = 1.0
        cell.name.layer.borderColor=UIColor.lightGray.cgColor
        cell.time.layer.borderWidth = 1.0
        cell.time.layer.borderColor=UIColor.lightGray.cgColor
        cell.price.layer.borderWidth = 1.0
        cell.price.layer.borderColor=UIColor.lightGray.cgColor
        cell.unit.layer.borderWidth = 1.0
        cell.unit.layer.borderColor=UIColor.lightGray.cgColor
        cell.benifit.layer.borderWidth = 1.0
        cell.benifit.layer.borderColor=UIColor.lightGray.cgColor
        
        if(indexPath.row==0){
            cell.layer.backgroundColor=UIColor.black.cgColor
        }else{
            cell.layer.backgroundColor=UIColor.darkGray.cgColor
        }
        
        return cell
    }

    

}
