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

//referenced at the bottom of this file, this is basically a class interface or header
//anything that adopts DBConnProto needs to implement the ItemsDownloaded(NSArray) function
protocol DBConnProto: class {
    func itemsDownloaded(items: NSArray)
}


//This class is used to query the DB and in general gather data from external sources
class DBConn : NSObject, URLSessionDataDelegate {
    
    weak var delegate: DBConnProto!
    var data = Data()
    
    //This function initiates a query. Parameters needed are the URL for the DB query and the type of query as strings
    //example DBConn.query("cap.sheridancollege.ca/marketquery.php?metal=gld", Stock)
    func DBGet(site: String, type: String){
        
        let url:URL = URL(string: site)!
        let defaultsession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultsession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print ("Download Failed!")
            } else {
                print("Download Completed")
                self.parseJSON(data!, type: type.lowercased())
            }
        }
        task.resume()
    }
    
    func DBSet(site:String){
        
        let url:URL = URL(string: site)!
        let defaultsession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultsession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Connection Failed")
            } else {
                print("Connection Successful")
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
        
        let results = NSMutableArray()
        
        //Switch for deciding which parsing mthod to use. Swift doesn't fall through cases, so no breaks needed
        switch (type){
            //Switch for querying market data on a stock, hence type "Stock"
            //Stock table hasn't been made yet, so I can't define Stock class
            case "stock":
                results.add(JSONParseStock(JSONStocks: JSONResult))
            
            //Switch for viewing transaction history
            case "history":
                results.add(JSONParseHistory(JSONHistory: JSONResult))
 
        //Portfolio is equivalent to the "Records" category. Is portfolio the right term?
        //Case for "Currently owned Stock" query
        case "portfolio":
            results.add(JSONParsePortfolio(JSONRecords: JSONResult))

        //Default case because we need one, all it does is break the switch
        default:
            break
        }
        
        //This is due to a threading issue. Any functions which update the UI should use something like this
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemsDownloaded(items: results)
        })
        
    }
    
    //Parses JSON data received from the server regarding stocks and places the returned records into Stock objects
    func JSONParseStock(JSONStocks:NSArray)->NSMutableArray{
        var JSONElement = NSDictionary();
        let results = NSMutableArray();
        
        //For each entry in the JSONStocks array
        for i in 0..<JSONStocks.count {
            //convert it into a dictionary
            JSONElement = JSONStocks[i] as! NSDictionary;
            //Make a new Record object
            let record = StockRecord();
            
            //Check if all of the fields work (Dictionary allows lookup by string identifiers)
            //My indenting in this section probably looks weird, since I wanted to line up all the lets
            if let stockID = JSONElement["stockID"] as? Int,
               let stockName = JSONElement["stockName"] as? String,
               let openPrice = JSONElement["openPrice"] as? Double,
               let highPrice = JSONElement["highPrice"] as? Double,
               let lowPrice = JSONElement["lowPrice"] as? Double,
               let marketCap = JSONElement["marketCap"] as? Double,
               let ltHighPrice = JSONElement["52wHigh"] as? Double,
               let ltLowPrice = JSONElement["52wLow"] as? Double,
               let ltAveragePrice = JSONElement["avgVol"] as? Double {
                
                    //fill in the Stock object values
                    record.stockID = stockID;
                    record.stockName = stockName
                    record.openPrice = openPrice
                    record.highprice = highPrice
                    record.lowPrice = lowPrice
                    record.marketCap = marketCap
                    record.ltHighPrice = ltHighPrice
                    record.ltLowprice = ltLowPrice
                    record.ltAveragePrice = ltAveragePrice
                
            }
            //Add the stock to the list of stocks from the DB
            results.add(record);
        }
        //Return the list of stocks
        return results;
    }
    
    //Parses the JSON formatted history records provided by the DB
    func JSONParseHistory(JSONHistory:NSArray)->NSMutableArray{
        var JSONElement = NSDictionary();
        let results = NSMutableArray();
        
        //Each parsing case should follow this general format
        //For each JSONResult
        for i in 0..<JSONHistory.count {
            //grab the JSON History record as an NSDictionary. This allows for looking up values by their string key as they'd appear in a JSON file
            JSONElement = JSONHistory[i] as! NSDictionary
            
            let record = HistoryRecord()
            
            //this block of an IF checks to make sure we can parse everything as their correct types and assigns them to temporary variables
            if let recID = JSONElement["RecordID"] as? Int,
               let stockName = JSONElement["StockName"] as? String,
               let buyTime = JSONElement["PurchaseTime"] as? String, //I'm assuming this is not going to need to be a number
               let sellTime = JSONElement["SellingTime"] as? String, //We can change these to something else later of needed
               let buyPrice = JSONElement["PurchasePrice"] as? Double,
               let sellPrice = JSONElement["SellingPrice"] as? Double,
               let units = JSONElement["Units"] as? Int,
               let profit = JSONElement["BenefitLoss"] as? Double {
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
        return results;
    }
    
    func JSONParsePortfolio(JSONRecords:NSArray)->NSMutableArray{
        var JSONElement = NSDictionary();
        let results = NSMutableArray();
        
        for i in 0..<JSONRecords.count {
            JSONElement = JSONRecords[i] as! NSDictionary
            
            let record = PortfolioRecord()
            
            //checks if JSON can be parsed how we want
            if let recID = JSONElement["RecordID"] as? Int,
                let stockName = JSONElement["StockName"] as? String,
                let buyTime = JSONElement["PurchaseTime"] as? String, //I'm assuming this is not going to need to be a number
                let sellTime = JSONElement["SellingTime"] as? String, //We can change these to something else later of needed
                let buyPrice = JSONElement["PurchasePrice"] as? Double,
                let sellPrice = JSONElement["SellingPrice"] as? Double,
                let units = JSONElement["Units"] as? Int,
                let profit = JSONElement["BenefitLoss"] as? Double,
                let isSold = JSONElement["isFinished"] as? Bool{
                //assigning temp records to the PortfolioRecord
                    record.recordID = recID
                    record.stockName = stockName
                    record.buyTime = buyTime
                    record.sellTime = sellTime
                    record.buyPrice = buyPrice
                    record.sellPrice = sellPrice
                    record.units = units
                    record.profit = profit
                    record.isSold = isSold
            }
            //add record to list of results
            results.add(record)
            
        } // end of for json results
        return results;
    }
}
