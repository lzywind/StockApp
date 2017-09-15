//
//  DBConn.swift
//  Stock
//
//  Created by Mathew Vassair on 2017-09-15.
//  Copyright © 2017 zhiyuan li. All rights reserved.
//

//THE CODE IN THIS CLASS IS BASED ON THIS TUTORIAL FOR USING SWIFT TO GET DATA FROM A DATABASE
//https://codewithchris.com/iphone-app-connect-to-mysql-database/


import Foundation

//referenced at the bottom of this file, this is basically a class interface
protocol DBConnProto: class {
    func itemsDownloaded(items: NSArray)
}


//This class is used to query the DB and in general gather data from external sources
class DBConn : NSObject, URLSessionDataDelegate {
    
    weak var delegate: DBConnProto!
    var data = Data()
    
    let urlPath:String = "blah"/*URL for DB goes here */
    
    //This function initiates a query. Parameters needed are the URL for the DB query and the type of query as strings
    //example DBConn.query("cap.sheridancollege.ca/marketquery.php?metal=gld", Stock)
    func query(site: String, type: String){
        
        let url:URL = URL(string: site)!
        let defaultsession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultsession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print ("Download Failed!")
            } else{
                print("Download Completed")
                self.parseJSON(data!, type: type)
            }
        }
        task.resume()
    }
    
    //JSON parsing function. I decided to keep it all as one function, the switch statement operates on the Type field
    //The parsing used is dependant on the Type, which should correspond to the table being used
    func parseJSON(_ data:Data, type:String){
        
        var JSONResult = NSArray()
        
        do{
            JSONResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        } catch let error as NSError {
            print(error)
        }
        
        var JSONElement = NSDictionary()
        let results = NSMutableArray()
        
        //Switch for deciding which parsing mthod to use. Swift doesn't fall through cases, so no breaks needed
        switch (type){
            //Switch for querying market data on a stock, hence type "Stock"
            //Stock table hasn't been made yet, so I can't define Stock class
            case "Stock":
                for i in 0..<JSONResult.count{
                    
                    JSONElement = JSONResult[i] as!  NSDictionary
                    //let record = Stock() //not yet made
                    //Fill this in when Market Info/Stock table is ready
                }
            
        //Switch for viewing transaction history
        case "History":
            
        //Each parsing case should follow this general format
            //For each JSONResult
        for i in 0..<JSONResult.count {
            //grab the JSON Result as an NSDictionary. this allows for looking up values by their string key as they'd appear in a JSON file
            JSONElement = JSONResult[i] as! NSDictionary
            
            let record = HistoryRecord()
            
            //this block of an IF checks to make sure we can parse everything as their correct types and assigns them to temporary variables
            if let recID = JSONElement["RecordID"] as? Int,
            let stockName = JSONElement["StockName"] as? String,
            let buyTime = JSONElement["PurchaseTime"] as? String, //I'm assuming this is not going to need to be a number
            let sellTime = JSONElement["SellingTime"] as? String, //We can change these to something else later of needed
            let buyPrice = JSONElement["PurchasePrice"] as? Double,
            let sellPrice = JSONElement["SellingPrice"] as? Double,
            let units = JSONElement["Units"] as? Int,
            let profit = JSONElement["BenefitLoss"] as? Double
            {
                //assigning temp records to the HistoryRecord
                record.recordID = recID
                record.stockName = stockName
                record.buyTime = buyTime
                record.sellTime = sellTime
                record.buyPrice = buyPrice
                record.sellPrice = sellPrice
                record.units = units
                record.profit = profit
            }
            //Add this historyRecord to the list of results
            results.add(record)
         
        } //end of for json results
            
        //Portfolio is equivalent to the "Records" category. Is portfolio the right term?
        //Case for "Currently owned Stock" query
        case "Portfolio":
            for i in 0..<JSONResult.count {
                JSONElement = JSONResult[i] as! NSDictionary
                
                let record = PortfolioRecord()
                
                //checks if JSON can be parsed how we want
                if let recID = JSONElement["RecordID"] as? Int,
                    let stockName = JSONElement["StockName"] as? String,
                    let buyTime = JSONElement["PurchaseTime"] as? String, //I'm assuming this is not going to need to be a ate object eventually
                    let buyPrice = JSONElement["PurchasePrice"] as? Double,
                    let profit = JSONElement["BenefitLoss"] as? Double
                {
                    //assigning values to PortfolioRecord
                    record.recordID = recID
                    record.stockName = stockName
                    record.buyTime = buyTime
                    record.buyPrice = buyPrice
                    record.profit = profit
                }
                //add record to list of results
                results.add(record)
                
            } // end of for json results
        //Default case because we need one, all it does is break the switch
        default:
            break
        }
        
        //Not entirely positive how this works as this code was templated from a tutorial that didn't explain this
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemsDownloaded(items: results)
        })
        
    }
        
}
