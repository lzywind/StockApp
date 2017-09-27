//
//  PortfolioRecord.swift
//  Stock
//
//  Created by Mathew Vassair on 2017-09-15.
//  Copyright © 2017 zhiyuan li. All rights reserved.
//

import Foundation

//Portfolio Record object. Not sure if portfolio is the right word to use
//This is a record of one of the user's currently owned stocks
class PortfolioRecord: NSObject{

    var recordID: Int?
    var userID: Int?
    var stockID: Int?
    var buyTime: String?
    var sellTime: String?
    var buyPrice: Double?
    var sellPrice: Double?
    var units: Int?
    var profit: Double?
    var isSold: Bool?
    
    func PortfolioRecord(){
        recordID = 0
        userID = 0;
        stockID = 0
        buyTime = ""
        sellTime = ""
        buyPrice = 0.0
        sellPrice = 0.0
        units = 0
        profit = 0.0
        isSold = false
    }
}
