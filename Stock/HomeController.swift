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
    struct inventory {
        var name:String
        var price:String
        var percent:[String]
    }
    var myInventroy_array : [inventory] = [inventory(name: "XAUSD",price:"29000",percent:["2.0%","-0.22"])]
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
            myInventroy_array.append(inventory(name:item1,price:"24000.00",percent:["2%","6.22"]));
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "Inventory", for: indexPath)as! homeInventoryCell
            
             cell.name.text = myInventroy_array[indexPath.row].name
             cell.price.text = myInventroy_array[indexPath.row].price
             cell.percent.setTitle(myInventroy_array[indexPath.row].percent[0], for: .normal)
            
            //style part
             let num = Double(myInventroy_array[indexPath.row].percent[1])
             if (num != nil){
                if num! > 0{
                    cell.percent.backgroundColor=UIColor.green
                }else{
                    cell.percent.backgroundColor=UIColor.red
                }
             }
             cell.percent.layer.cornerRadius=2.0
             cell.percent.layer.masksToBounds=true
            
            let view = UIView()
            view.backgroundColor = UIColor(r: 72, g: 104, b: 133)
            cell.selectedBackgroundView=view
            
            //
            cell.percent.tag = indexPath.row
            cell.percent.addTarget(self, action: #selector(HomeController.tapFunction), for: .touchUpInside)

            return cell
        }
        func tapFunction(sender:UIButton) {
            let button=sender.viewWithTag(sender.tag) as! UIButton
            if(button.titleLabel?.text == myInventroy_array[sender.tag].percent[0]){
                button.setTitle(myInventroy_array[sender.tag].percent[1], for: .normal)
            }else{
                button.setTitle(myInventroy_array[sender.tag].percent[0], for: .normal)
            }
        }
    }

