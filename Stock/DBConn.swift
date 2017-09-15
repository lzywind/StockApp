//
//  DBConn.swift
//  Stock
//
//  Created by Mathew Vassair on 2017-09-15.
//  Copyright © 2017 zhiyuan li. All rights reserved.
//

import Foundation

protocol DBConnProto: class {
    func itemsDownloaded(items: NSArray)
}


//This class is used to query the DB and in general gather data from external sources
class DBConn : NSObject, URLSessionDataDelegate {
    
    weak var delegate: DBConnProto!
    var data = Data()
    
    let urlPath:String = "blah"/*URL for DB goes here */
    
    //This function initiates a query. Parameters needed are the URL for the DB query and the type of query as strings
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
    
    func parseJSON(_ data:Data, type:String){
        
        var JSONResult = NSArray()
        
        do{
            JSONResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        } catch let error as NSError {
            print(error)
        }
        
        var JSONElement = NSDictionary()
        var results = NSMutableArray()
        
        switch (type){
            case "Stock":
                for i in 0..<JSONResult.count{
                    
                    JSONElement = JSONResult[i] as!  NSDictionary
                    //let record = Stock() //not yet made
                    //Fill this in when Market Info/Stock table is ready
                    
            }
        case "History":
        for i in 0..<JSONResult.count {
            JSONElement = JSONResult[i] as! NSDictionary
            
            let record = HistoryRecord()
            
            if let recID = JSONElement["RecordID"] as? Int,
            let stockName = JSONElement["StockName"] as? String,
            let buyTime = JSONElement["PurchaseTime"] as? String, //I'm assuming this is not going to need to be a number
            let sellTime = JSONElement["SellingTime"] as? String, //We can change these to something else later of needed
            let buyPrice = JSONElement["PurchasePrice"] as? Double,
            let sellPrice = JSONElement["SellingPrice"] as? Double,
            let units = JSONElement["Units"] as? Int,
            let profit = JSONElement["BenefitLoss"] as? Double
            {
                record.recordID = recID
                record.stockName = stockName
                record.buyTime = buyTime
                record.sellTime = sellTime
                record.buyPrice = buyPrice
                record.sellPrice = sellPrice
                record.profit = profit
            }
            results.add(record)
            
        }
        case "Portfolio":
            for i in 0..<JSONResult.count {
                JSONElement = JSONResult[i] as! NSDictionary
                
                let record = PortfolioRecord()
                
                if let recID = JSONElement["RecordID"] as? String,
                    let stockName = JSONElement["StockName"] as? String,
                    let buyTime = JSONElement["PurchaseTime"] as? String, //I'm assuming this is not going to need to be a number
                    let buyPrice = JSONElement["PurchasePrice"] as? Double,
                    let profit = JSONElement["BenefitLoss"] as? Double
                {
                    record.recID = recID
                    record.stockName = stockName
                    record.buyTime = buyTime
                    record.buyPrice = buyPrice
                    record.profit = profit
                }
                results.add(record)
                
            }
            
        }
        
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemsDownloaded(items: results)
        })
        
    }
        
}
