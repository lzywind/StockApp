//
//  FirstViewController.swift
//  Stock
//
//  Created by zhiyuan li on 2017-07-29.
//  Copyright © 2017 zhiyuan li. All rights reserved.
//

import UIKit

import Alamofire

class HomeController: UIViewController {
    
    var myInventroy_array : [String] = ["test_item"]
    var inven=InventoryController()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        tryrequest1()
        }
    override func viewDidAppear(_ animated: Bool) {
        loadMyInventory();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    func tryrequest(){
//   let url = URL(string: "https://globalmetals.xignite.com/xGlobalMetals.json/GetRealTimeExtendedMetalQuote?Symbol=XAU&Currency=USD&_token=8DCBFAB0A06E49238874AF0FA4205431")
//        
//        let urlRequest=URLRequest(url:url!)
//    let session = URLSession.shared // or let session = URLSession(configuration: URLSessionConfiguration.default)
//    
//        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
//            print(response!)
//        })
//        task.resume()
//    }
  
    func tryrequest1(){
        Alamofire.request("https://globalmetals.xignite.com/xGlobalMetals.json/GetRealTimeExtendedMetalQuote?Symbol=XAU&Currency=USD&_token=8DCBFAB0A06E49238874AF0FA4205431").responseJSON { response in
            debugPrint(response)
            
            if let json = response.result.value {
                print("JSON: \(json)")
            }
        }
    }
    
    func loadMyInventory(){
        if (!item1.isEmpty){
        myInventroy_array.append(item1);
        }
        var yValue = 280
        for item in myInventroy_array{
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 180, height: 21))
            label.center = CGPoint(x: 160, y: yValue)
            yValue =  285 + 50
            label.textAlignment = .center
            label.text = item
            self.view.addSubview(label)
        }
        //print(myInventroy_array.count)
    }
    

}

