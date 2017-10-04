//
//  SecondViewController.swift
//  Stock
//
//  Created by zhiyuan li on 2017-07-29.
//  Copyright © 2017 zhiyuan li. All rights reserved.
//

import UIKit

class HistoryController: UIViewController {
    
    var feedItems:NSArray = NSArray()
    var selectionId:WatchlistRecord = WatchlistRecord();
    
    @IBOutlet weak var cA: UIView!
    @IBOutlet weak var cB: UIView!
    @IBOutlet weak var cC: UIView!
    @IBOutlet weak var cD: UIView!
    @IBOutlet weak var switches: UISegmentedControl!
 
    struct total {
        var obname : String!
        var obdata : String!
    }
    var totalarray=[total]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cA.alpha=1;
        self.cB.alpha=0;
        self.cC.alpha=0;
        self.cD.alpha=0;
        // Do any additional setup after loading the view, typically from a nib.
        totalarray=[total(obname:"Total Capital",obdata:"1,000,000"),
                    total(obname:"Total Time",obdata:"39"),
                    total(obname:"Success Rate",obdata:"73.5%"),
                    total(obname:"Total Benifit Rate",obdata:"35.5%"),
                    total(obname:"Total Benifit/loss",obdata:"155,000"),
                    total(obname:"Benfit/Loss Daily ",obdata:"-8,000")]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func indexChange(_ sender: Any) {
        switch switches.selectedSegmentIndex
        {
        case 0:
            self.cA.alpha=1;
            self.cB.alpha=0;
            self.cC.alpha=0;
            self.cD.alpha=0;
        case 1:
            self.cA.alpha=0;
            self.cB.alpha=1;
            self.cC.alpha=0;
            self.cD.alpha=0;
        case 2:
            self.cA.alpha=0;
            self.cB.alpha=0;
            self.cC.alpha=1;
            self.cD.alpha=0;
        case 3:
            self.cA.alpha=0;
            self.cB.alpha=0;
            self.cC.alpha=0;
            self.cD.alpha=1;
        default:
            break; 
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6

    }
    
    // make a cell for each cell index path
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        // get a reference to our storyboard cell
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath as IndexPath) as! CollectionViewCell
//        
//         cell.name.text=totalarray[indexPath.row].obname
//         cell.data.text=totalarray[indexPath.row].obdata
//        
//        cell.backgroundColor = UIColor.lightGray
//        
//        return cell
//    }

}

