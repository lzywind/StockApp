//
//  RecordController.swift
//  Stock
//
//  Created by zhiyuan li on 2017-07-31.
//  Copyright © 2017 zhiyuan li. All rights reserved.
//

import UIKit


class RecordController: UIViewController,UITableViewDelegate, UITableViewDataSource, DBConnProto{
    
    var selectedIndex = -1
    var feedItems:NSArray = NSArray()
    var selection:PortfolioRecord = PortfolioRecord();
    @IBOutlet weak var recordtbv: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      // recordtbv.estimatedRowHeight = 40
        recordtbv.rowHeight=UITableViewAutomaticDimension
        
        let connection = DBConn()
        connection.delegate = self
        connection.DBGet(site: "http://vassairm.dev.fast.sheridanc.on.ca/StockAgent/OwnedStock.php?userid=12345", type: "portfolio")
    }
    
    func itemsDownloaded(items: NSArray) {
        feedItems = items;
        self.recordtbv.reloadData();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordcell", for: indexPath) as! TableViewRecordCell
        
        let recordName: PortfolioRecord = feedItems[indexPath.row] as! PortfolioRecord
        cell.name.text = "\(recordName.stockID!)"
        cell.time.text = recordName.buyTime
        cell.price.text = "\(recordName.buyPrice!)"
        cell.unit.text = "\(recordName.units!)"
        cell.benifit.text = "\(recordName.profit!)"

         let num = Double(recordName.profit!)
          if(num > 0){
            cell.benifit.textColor=UIColor(r: 57,g: 208,b: 181)
          }else if(num < 0){
            cell.benifit.textColor=UIColor(r: 249,g: 73,b: 10)
          }else{
            cell.benifit.textColor=UIColor.lightGray
          }
        
          let view = UIView()
          view.backgroundColor = UIColor(r: 72, g: 104, b: 133)
          cell.selectedBackgroundView=view
        
        return cell
    }
      
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if(selectedIndex == indexPath.row) {
//            //return 100;
//            return 100
//        } else {
//            return 40;
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if(selectedIndex == indexPath.row) {
//            selectedIndex = -1
//        } else {
//            selectedIndex = indexPath.row
//        }
//        self.recordtbv.beginUpdates()
//        //self.expandTableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic )
//        self.recordtbv.endUpdates()
//    }
    
    

}
