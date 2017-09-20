//
//  StockRecord.swift
//  Stock
//
//  Created by Mathew Vassair on 2017-09-20.
//  Copyright © 2017 zhiyuan li. All rights reserved.
//

import Foundation


//StockRecord class which contains a single Stock Record from the database
class StockRecord:NSObject {
    
    var stockID:Int?;            //Stock ID from DB
    var stockName:String?;       //Shorthand name of stock (like DOW)
    var openPrice:Double?;       //Day's opening price
    var highprice:Double?;       //Highest price today
    var lowPrice:Double?;        //Lowest price today
    var marketCap:Double?;       //Outstanding shares * most recent closing value per share
    var ltHighPrice:Double?;     //Long term highest price (52 weeks)
    var ltLowprice:Double?;      //Long term lowest price (52 weeks)
    var ltAveragePrice:Double?;  //Long term average price (52 weeks average)
    
}
