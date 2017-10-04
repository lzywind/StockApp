//
//  FirstViewController.swift
//  Stock
//
//  Created by zhiyuan li on 2017-07-29.
//  Copyright © 2017 zhiyuan li. All rights reserved.
//

import UIKit

//import Alamofire

class HomeController: UIViewController,UITableViewDelegate,UITableViewDataSource,DBConnProto{

    var detailarr = [String] (repeating:"", count: 5)
    var myInventroy_array = [StockRecord]()
    let connection = DBConn()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func itemsDownloaded(items: NSArray) {
        myInventroy_array = items as! [StockRecord]
        self.tableView.reloadData();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //refresh SelectedStock in view
        connection.delegate = self
        connection.DBGet(site: "http://vassairm.dev.fast.sheridanc.on.ca/StockAgent/Watchlist.php?userid=12345", type: "watchlist")
        tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return myInventroy_array.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Inventory", for: indexPath)as! homeInventoryCell
            
             cell.name.text = myInventroy_array[indexPath.row].stockName
             cell.price.text = "\(myInventroy_array[indexPath.row].openPrice!)"
             cell.percent.setTitle("2%", for: .normal)
            
            //style part
             let num = 2
             if (num != 0){
                if num > 0{
                    cell.percent.backgroundColor=UIColor(r: 57,g: 208,b: 181)
                }else{
                    cell.percent.backgroundColor=UIColor(r: 249,g: 73,b: 10)
                }
             }
             cell.percent.layer.cornerRadius=2.0
             cell.percent.layer.masksToBounds=true
            
            let view = UIView()
            view.backgroundColor = UIColor(r: 72, g: 104, b: 133)
            cell.selectedBackgroundView=view
            
            //
            cell.percent.tag = indexPath.row
            cell.percent.addTarget(self, action: #selector(HomeController.tapFunction), for: .touchUpInside)

            return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
           let a = FVViewController()
            a.avc?.text = "1223"
            FVViewController().refreshdetail(contecnt: myInventroy_array[indexPath.row])
        
//            for subViews in (selectedCell.contentView.subviews) {
//            
//                if subViews is UIButton{
//                    let button = subViews as! UIButton
//                    selectedCell.bringSubview(toFront: button)
//                }
//            }
            
        }
        func tapFunction(sender:UIButton) {
            let button=sender.viewWithTag(sender.tag) as! UIButton
//            if(button.titleLabel?.text == myInventroy_array[sender.tag].percent[0]){
//                //button.setTitle(myInventroy_array[sender.tag].percent[1], for: .normal)
//            }else{
//                //button.setTitle(myInventroy_array[sender.tag].percent[0], for: .normal)
//            }
        }
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == UITableViewCellEditingStyle.delete {
                //remove this link between this stock and this user in DB
                if(self.connection.DBSet(site: "http://vassairm.dev.fast.sheridanc.on.ca/StockAgent/ChangeWatch.php?userid=12345&stockid=\(myInventroy_array[indexPath.row].stockID ?? 0)&type=remove")){
                    print("stock added to selecedStock table!!")
                }
                myInventroy_array.remove(at: indexPath.row)

                tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
                tableView.reloadData()
            }
        }
    }

