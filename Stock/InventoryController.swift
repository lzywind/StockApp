//
//  InventoryController.swift
//  Stock
//
//  Created by zhiyuan li on 2017-07-29.
//  Copyright © 2017 zhiyuan li. All rights reserved.
//

import UIKit

class InventoryController: UITableViewController,UISearchResultsUpdating,
DBConnProto {
    
    let connection = DBConn()
    let searchController = UISearchController(searchResultsController: nil)
    var feedItems:NSArray = NSArray()
    var filteredfitem :NSArray = NSArray()
    @IBOutlet var stocktv: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //search bar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        stocktv.tableHeaderView = searchController.searchBar
        
        //added by lee
            connection.delegate = self
            connection.DBGet(site: "http://vassairm.dev.fast.sheridanc.on.ca/StockAgent/GetAllNames.php", type: "namelist")
        
    }
    
    func itemsDownloaded(items: NSArray) {
        feedItems = items;
        filteredfitem = feedItems
        self.stocktv.reloadData();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // If we haven't typed anything into the search bar then do not filter the results
        if searchController.searchBar.text! == "" {
            filteredfitem = feedItems
        } else {
            // Filter the results
            filteredfitem = feedItems.filter {($0 as! StockRecord).stockName!.lowercased().contains(searchController.searchBar.text!.lowercased()) } as NSArray
        }
        
        self.stocktv.reloadData()
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredfitem.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryCell", for: indexPath)
        
        let stock: StockRecord = filteredfitem[indexPath.row] as! StockRecord
        
        cell.textLabel?.text = stock.stockName
        cell.detailTextLabel?.text = stock.stockDescription
        
        cell.textLabel?.textColor=UIColor.white
        cell.detailTextLabel?.textColor=UIColor.white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        let currentItem = currentCell.textLabel!.text
        let alertController = UIAlertController(title: "Add to your Inventory", message: "You Selected " + currentItem! , preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Confirm Add", style: .default,
           handler: { (action: UIAlertAction!) in
        //lee added, add a stock ref to this user on DB when confirm button hitted
            if(self.connection.DBSet(site: "http://vassairm.dev.fast.sheridanc.on.ca/StockAgent/ChangeWatch.php?userid=12345&stockid=\((self.feedItems[indexPath.row] as! StockRecord).stockID ?? 0)&type=add")){
                print("stock added to selecedStock table!!")
            }
        //
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
      
    }

}
