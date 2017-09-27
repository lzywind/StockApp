//
//  InventoryController.swift
//  Stock
//
//  Created by zhiyuan li on 2017-07-29.
//  Copyright © 2017 zhiyuan li. All rights reserved.
//

import UIKit

var item1:String=""

class InventoryController: UITableViewController  {
    
    struct inv {
        var invname:String
        var invdetail:String
    }
    var invarr=[inv]()
//    var invenInstance=InventoryController()
    
    override func viewDidLoad() {
        super.viewDidLoad()	
        invarr = [inv(invname:"XAUSD",invdetail: "default"),
                  inv(invname:"USADCAD",invdetail:"default"),
                  inv(invname:"AGUSD",invdetail:"default"),
                  inv(invname:"USOIL",invdetail:"default"),
                  inv(invname:"UROIL",invdetail:"default"),
                  inv(invname:"URUSD",invdetail:"default")]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invarr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryCell", for: indexPath)
        
        cell.textLabel?.text = invarr[indexPath.row].invname
        cell.detailTextLabel?.text=invarr[indexPath.row].invdetail
        cell.textLabel?.textColor=UIColor.white
        cell.detailTextLabel?.textColor=UIColor.white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
        let currentItem = currentCell.textLabel!.text
        let alertController = UIAlertController(title: "Add to your Inventory", message: "You Selected " + currentItem! , preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Confirm Add", style: .default,
        //    handler: nil)
        //   add new inventory to pre page
           handler: { (action: UIAlertAction!) in
            item1 = currentItem!

        })
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
      
    }

}
