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
    var stockName: String?
    var buyTime: String?
    var buyPrice: Double?
    var units: Int?
    var profit: Double?
}
