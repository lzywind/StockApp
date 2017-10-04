//
//  TableViewCellD.swift
//  Stock
//
//  Created by zhiyuan li on 2017-08-03.
//  Copyright © 2017 zhiyuan li. All rights reserved.
//

import UIKit

class TableViewCellD: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var profit: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
