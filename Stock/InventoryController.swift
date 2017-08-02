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
    
    
    var fruits = ["Apple", "Apricot", "Banana", "Blueberry", "Cantaloupe","Cherry", "Clementine", "Coconut", "Cranberry", "Fig", "Grape"]
    
//    var invenInstance=InventoryController()
    
    override func viewDidLoad() {
        super.viewDidLoad()	
      
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
        return fruits.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryCell", for: indexPath)
        
        let fruitName = fruits[indexPath.row]
        cell.textLabel?.text = fruitName
        //cell.detailTextLabel?.text = "Delicious!"
        //cell.imageView?.image = UIImage(named: fruitName)
        
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
