//
//  WatchlistRecord.swift
//  Stock
//
//  Created by Mathew Vassair on 2017-09-27.
//  Copyright © 2017 zhiyuan li. All rights reserved.
//

import Foundation

//this class is just a container for a list of ineces the user is watching
class WatchlistRecord {
    
    lazy var watchlist:[Int] = [] //
    
    func add(stockID:Int){
        watchlist.append(stockID)
    }
    
    func remove(stockID:Int){
        watchlist.remove(at: watchlist.index(of: stockID)!)
    }
    
    func isEmpty()->Bool{
        return watchlist.isEmpty
    }
    
}
