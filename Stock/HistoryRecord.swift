//
//  HistoryRecord.swift
//  Stock
//
//  Created by Mathew Vassair on 2017-09-15.
//  Copyright © 2017 zhiyuan li. All rights reserved.
//

import Foundation

//History record object which contains one transaction initiated by the user
class HistoryRecord: NSObject {
    
    var recordID: Int?
    var stockName: String?
    var buyTime: String?
    var sellTime: String?
    var buyPrice: Double?
    var sellPrice: Double?
    var units: Int?
    var profit: Double?
}
