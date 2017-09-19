//
//  FirstViewController.swift
//  Stock
//
//  Created by zhiyuan li on 2017-07-29.
//  Copyright © 2017 zhiyuan li. All rights reserved.
//

import UIKit

//import Alamofire

class HomeController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var myInventroy_array : [String] = ["XUSA"]
    var inven=InventoryController()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        tryrequest1()
        }
    override func viewDidAppear(_ animated: Bool) {
        loadMyInventory();
        tableView.reloadData()
        
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
  
//    func tryrequest1(){
//        Alamofire.request("https://globalmetals.xignite.com/xGlobalMetals.json/GetRealTimeExtendedMetalQuote?Symbol=XAU&Currency=USD&_token=8DCBFAB0A06E49238874AF0FA4205431").responseJSON { response in
//            debugPrint(response)
//            
//            if let json = response.result.value {
//                print("JSON: \(json)")
//            }
//        }
//    }
    
    func loadMyInventory(){
        if (!item1.isEmpty){
        myInventroy_array.append(item1);
        item1=""
        }

        }
       func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return myInventroy_array.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            view.tintColor=UIColor.lightGray
            let cell = tableView.dequeueReusableCell(withIdentifier: "Inventory", for: indexPath) 
            
            let inventoryName = myInventroy_array[indexPath.row]
             cell.textLabel?.text = inventoryName
             cell.textLabel?.textColor = UIColor.white

            return cell
        }
//       func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        
//          return "Incentory"
//       }
//  
//       func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        view.tintColor=UIColor.black
//        let header = view as! UITableViewHeaderFooterView
//        header.textLabel?.textColor=UIColor.white
//        
//      }

    }
    



