//
//  DBConn.swift
//  Stock
//
//  Created by Mathew Vassair on 2017-09-15.
//  Copyright © 2017 zhiyuan li. All rights reserved.
//

//THE CODE IN THIS CLASS IS BASED ON THIS TUTORIAL FOR USING SWIFT TO GET DATA FROM A DATABASE
//https://codewithchris.com/iphone-app-connect-to-mysql-database/

/*  The base URL is http://vassairm.dev.fast.sheridanc.on.ca/StockAgent/
 *  Accessible PHP files and their variables are as follows:
 *  ChangeWatch.php?type=<add or remove>&userid=<int>&stockid=<int>    This changes the user's Watchlist, use DBSet. If add fails PHP returns an error, if remove used PHP returns rows affected
 *  GetWatchedNames.php?userid=<int>                                   This returns a list of watched stock index IDs
 *  OwnedStock.php?userid=<int>                                        This returns a list of shares owned by the user
 *  PriceHistory.php?stockid=<int>                                     This returns the price history of a stock index
 *  Summary.php?userid=<int>                                           This returns the users summary entry from the DB
 *  Watchlist.php?userid=<int>                                         This returns stock information for every stock on the user's watchlist
 * 
 *  Let Mathew know if there are any problems with the PHP scripts ASAP
 *
 *  Todo for later: Restructure this to use Alamofire and hopefully clean it up
 */


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
                print ("Download Failed! \(String(describing: error))")
            } else {
                print("Download Completed \(String(describing: data))")
                self.parseJSON(data!, type: type.lowercased())
            }
        }
        task.resume()
    }
    
    func DBSet(site:String) -> Bool {
        
        var ok = false
        let url:URL = URL(string: site)!
        let defaultsession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultsession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Connection Failed. \(String(describing: error))")
            } else {
                print("Connection Successful")
                ok = self.checkResponse(data!)
            }
        }
        task.resume()
        return ok
    }
    
    func checkResponse(_ data:Data)->Bool{
        
        var JSONResult = ""
        
        if (data.isEmpty){
            print("No data in response")
            return false;
        }
        do{
            if let tempJSON = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? NSArray{
                JSONResult = "\(tempJSON[0])"
            }
            else{
                print("No valid data found")
            }
        } catch let error as NSError {
            print(error)
        }
        
        //Since this checks both add and remove, we know the command did something if the response is empty, or a number > 0
        if (JSONResult == "" || Int.init(JSONResult)! > 0){
            return true;
        }
        else {
            print (JSONResult)
            return false
        }
    }
    
    //JSON parsing function. I decided to keep it all as one function, the switch statement operates on the Type field
    //The parsing used is dependant on the Type, which should correspond to the table being used
    func parseJSON(_ data:Data, type:String){
        
        var JSONResult = NSArray()
                
        do{
            if let tempJSON = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? NSArray {
                JSONResult = tempJSON
                print("Data get!")
            }
            
                else {print("No data found")}
        } catch let error as NSError {
            print(error)
        }
        
        var results = NSArray()
        
        //Switch for deciding which parsing mthod to use. Swift doesn't fall through cases, so no breaks needed
        switch (type){
            //Switch for querying the stock basic info,stockid, name and description
            case "namelist":
                results = JSONParseListNames(JSONStocks: JSONResult)
            //Switch for querying market data. "stock" and "watchlist" both return stock data
            case "stock", "watchlist":
                results = JSONParseStock(JSONStocks: JSONResult)
            
            //Switch for viewing index price history
            case "history":
                results = JSONParseHistory(JSONHistory: JSONResult)
 
            //Portfolio is equivalent to the "Records" category. Is portfolio the right term?
            //Case for "Currently owned Stock" query
            case "portfolio":
                results = JSONParsePortfolio(JSONRecords: JSONResult)

            
            case "watchnames":
                results = JSONParseWatchNames(JSONNames: JSONResult)
            
        //Default case because we need one, all it does is break the switch
        default:
            break
        }
        
        print(results)
        
        //This is due to a threading issue. Any functions which update the UI should use something like this
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemsDownloaded(items: results)
        })
        
    }
    
    //new JSONParse method added by lee, pulling the stockid, name and desc
    func JSONParseListNames(JSONStocks:NSArray)->NSMutableArray{
        var JSONElement = NSDictionary()
        let results = NSMutableArray()
        
        for i in 0..<JSONStocks.count {
            
            JSONElement = JSONStocks[i] as! NSDictionary
            let record = StockRecord()
            
            if let stockID = JSONElement["stockId"] as? Int,
               let stockName = JSONElement["stockName"] as? String,
               let stockDesc = JSONElement["description"] as? String{
                
                record.stockID = stockID
                record.stockName = stockName
                record.stockDescription = stockDesc
                
            }
            results.add(record)
        }
        return results
    }
    
    
    func JSONParseWatchNames(JSONNames:NSArray)->NSMutableArray{
        var JSONElement = NSDictionary()
        let results = NSMutableArray()
        
        for i in 0..<JSONNames.count {
            
            JSONElement = JSONNames[i] as! NSDictionary
            let record = WatchlistRecord()
            
            if let stockID = JSONElement["stockId"] as? Int {
                record.add(stockID: stockID)
            }
            results.add(record)
        }
        return results
    }
    
    //Parses JSON data received from the server regarding stocks and places the returned records into Stock objects
    func JSONParseStock(JSONStocks:NSArray)->NSMutableArray{
        var JSONElement = NSDictionary()
        let results = NSMutableArray()
        
        //For each entry in the JSONStocks array
        for i in 0..<JSONStocks.count {
            //convert it into a dictionary
            JSONElement = JSONStocks[i] as! NSDictionary
            //Make a new Record object
            let record = StockRecord()
            
            //Check if all of the fields work (Dictionary allows lookup by string identifiers)
            //My indenting in this section probably looks weird, since I wanted to line up all the lets
            if let stockID = JSONElement["stockId"] as? Int,
               let stockName = JSONElement["stockName"] as? String,
               let stockDesc = JSONElement["description"] as? String,
               let openPrice = JSONElement["openPrice"] as? Double,
               let highPrice = JSONElement["high"] as? Double,
               let lowPrice = JSONElement["low"] as? Double,
               let marketCap = JSONElement["mktCap"] as? Double,
               let ltHighPrice = JSONElement["high52w"] as? Double,
               let ltLowPrice = JSONElement["low52w"] as? Double,
               let ltAveragePrice = JSONElement["avgVol"] as? Double,
               let lastUpdate = JSONElement["lastUpdate"] as? String {
                
                    //fill in the Stock object values
                    record.stockID = stockID
                    record.stockName = stockName
                    record.stockDescription = stockDesc
                    record.openPrice = openPrice
                    record.highprice = highPrice
                    record.lowPrice = lowPrice
                    record.marketCap = marketCap
                    record.ltHighPrice = ltHighPrice
                    record.ltLowprice = ltLowPrice
                    record.avgTradeVolume = ltAveragePrice
                    record.lastUpdate = lastUpdate
                
            }
            //Add the stock to the list of stocks from the DB
            results.add(record);
        }
        //Return the list of stocks
        return results;
    }
    
    //Parses the JSON formatted PriceHistory records provided by the DB
    func JSONParseHistory(JSONHistory:NSArray)->NSMutableArray{
        var JSONElement = NSDictionary()
        let results = NSMutableArray()
        
        //Each parsing case should follow this general format
        //For each JSONResult
        for i in 0..<JSONHistory.count {
            //grab the JSON History record as an NSDictionary. This allows for looking up values by their string key as they'd appear in a JSON file
            JSONElement = JSONHistory[i] as! NSDictionary
            
            let record = PriceHistoryRecord()
            
            //this block of an IF checks to make sure we can parse everything as their correct types and assigns them to temporary variables
            if let stockID = JSONElement["stockId"] as? Int,
               let oneMinPrice = JSONElement["oneMinPrice"] as? Double,
               let fiveMinPrice = JSONElement["fiveMinPrice"] as? Double,
               let tenMinPrice = JSONElement["tenMinPrice"] as? Double,
               let OpenPrice1Day = JSONElement["OpenPrice_1day"] as? Double,
               let OpenPrice2Day = JSONElement["OpenPrice_2day"] as? Double,
               let OpenPrice3Day = JSONElement["OpenPrice_3day"] as? Double,
               let OpenPrice4Day = JSONElement["OpenPrice_4day"] as? Double,
               let ClosePrice1Day = JSONElement["OpenPrice_4day"] as? Double,
               let ClosePrice2Day = JSONElement["OpenPrice_4day"] as? Double,
               let ClosePrice3Day = JSONElement["OpenPrice_4day"] as? Double,
               let ClosePrice4Day = JSONElement["OpenPrice_4day"] as? Double,
               let HighPrice1Day = JSONElement["OpenPrice_4day"] as? Double,
               let HighPrice2Day = JSONElement["OpenPrice_4day"] as? Double,
               let HighPrice3Day = JSONElement["OpenPrice_4day"] as? Double,
               let HighPrice4Day = JSONElement["OpenPrice_4day"] as? Double,
               let LowPrice1Day = JSONElement["OpenPrice_4day"] as? Double,
               let LowPrice2Day = JSONElement["OpenPrice_4day"] as? Double,
               let LowPrice3Day = JSONElement["OpenPrice_4day"] as? Double,
               let LowPrice4Day = JSONElement["OpenPrice_4day"] as? Double {
                    //assigning temp records to the PriceHistoryRecord
                    record.stockID = stockID
                    record.price1min  = oneMinPrice
                    record.price5min  = fiveMinPrice
                    record.price10min = tenMinPrice
                    record.openPrice  = [OpenPrice1Day,  OpenPrice2Day,  OpenPrice3Day,  OpenPrice4Day]
                    record.closePrice = [ClosePrice1Day, ClosePrice2Day, ClosePrice3Day, ClosePrice4Day]
                    record.highPrice  = [HighPrice1Day,  HighPrice2Day,  HighPrice3Day,  HighPrice4Day]
                    record.lowPrice   = [LowPrice1Day,   LowPrice2Day,   LowPrice3Day,   LowPrice4Day]
            }
            //Add this historyRecord to the list of results
            results.add(record)
            
        } //end of for json results
        return results
    }
    
    //Parses the portfolio records provided by the DB
    func JSONParsePortfolio(JSONRecords:NSArray)->NSMutableArray{
        var JSONElement = NSDictionary()
        let results = NSMutableArray()
        
        for i in 0..<JSONRecords.count {
            JSONElement = JSONRecords[i] as! NSDictionary
            
            let record = PortfolioRecord()
            
            //checks if JSON can be parsed how we want
            if let recID = JSONElement["recordId"] as? Int,
               let userID = JSONElement["userId"] as? Int,
               let stockId = JSONElement["stockId"] as? Int,
               let buyTime = JSONElement["purchaseTime"] as? String, //I'm assuming this is not going to need to be a number
               let buyPrice = JSONElement["purchasePrice"] as? Double,
               let units = JSONElement["unit"] as? Int,
               let profit = JSONElement["benefitLoss"] as? Double,
               let isSold = JSONElement["isFinished"] as? Int{
               //assigning temp records to the PortfolioRecord
                    record.recordID = recID
                    record.userID = userID
                    record.stockID = stockId
                    record.buyTime = buyTime
                    record.sellTime = JSONElement["sellTime"] == nil ? "" : JSONElement["sellTime"] as? String
                    record.buyPrice = buyPrice
                    record.sellPrice = JSONElement["sellPrice"] == nil ? 0.0 : JSONElement["sellPrice"] as? Double
                    record.units = units
                    record.profit = profit
                    record.isSold = isSold > 0 ? true : false
            }
            print(record.buyPrice!, record.recordID!)
            
            //add record to list of results
            results.add(record)
            
        } // end of for json results
        return results
    }
}
