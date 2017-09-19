//
//  RecordController.swift
//  Stock
//
//  Created by zhiyuan li on 2017-07-31.
//  Copyright © 2017 zhiyuan li. All rights reserved.
//

import UIKit


class RecordController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var recordtbv: UITableView!
     var records = ["XAUSD", "USADCAD", "AGUSD", "USOIL", "UROIL","URUSD"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //        tryrequest1()
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
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        view.tintColor=UIColor.lightGray
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordcell", for: indexPath) as! TableViewRecordCell
        
        let recordName = records[indexPath.row]
          cell.name.text = recordName
          cell.time.text = ""
          cell.price.text = ""
          cell.unit.text = ""
          cell.benifit.text = ""
        
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
