//
//  TableViewRecordCell.swift
//  Stock
//
//  Created by zhiyuan li on 2017-08-03.
//  Copyright © 2017 zhiyuan li. All rights reserved.
//

import UIKit

class TableViewRecordCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var unit: UILabel!
    @IBOutlet weak var benifit: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
