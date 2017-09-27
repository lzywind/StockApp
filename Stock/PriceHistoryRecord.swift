//
//  PriceHistoryRecord.swift
//  Stock
//
//  Created by Mathew Vassair on 2017-09-15.
//  Copyright © 2017 zhiyuan li. All rights reserved.
//

import Foundation

//Price History record which contains one stock index's price history
class PriceHistoryRecord: NSObject {
    
    var stockID:Int?
    var price5min:Double?
    var price10min:Double?
    var price1min:Double?
    var openPrice:[Double] = []  //Storing these as an array to try and make these easier to read
    var closePrice:[Double] = [] //Keep in mind SWIFT arrays are zero-indexed
    var highPrice:[Double] = []  //Therefore the 1 day old records are at index 0, etc.
    var lowPrice:[Double] = []
    
}
