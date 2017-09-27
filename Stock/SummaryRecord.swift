//
//  SummaryRecord.swift
//  Stock
//
//  Created by zhiyuan li on 2017-09-27.
//  Copyright © 2017 zhiyuan li. All rights reserved.
//

import Foundation


//StockRecord class which contains a single Stock Record from the database
class SummaryRecord:NSObject {
    
    var totalCapital:Int?;           //User's total(current) fund in this App, we can set a number on testing purpose
    var tradeTimes:String?;          //Total trade times on this user
    var successRate:Double?;         //the success rate caculated from the begining on this user
    var totalBenefitRate:Double?;    //caculated rate: (Init fund - curent fund) / Init fund
    var totalBenefitLoss:Double?;    //Benefit or loss value (Init fund - current fund)
    var dailyBenefitLoss:Double?;    //Benefit or loss on daily basis
    
    
}
