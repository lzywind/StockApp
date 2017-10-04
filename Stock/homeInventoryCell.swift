//
//  homeInventoryCell.swift
//  Stock
//
//  Created by Xin Lyu on 2017-09-19.
//  Copyright © 2017 zhiyuan li. All rights reserved.
//

import UIKit

class homeInventoryCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var percent: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    


}
