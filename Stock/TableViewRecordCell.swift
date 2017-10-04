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
    @IBOutlet weak var summary: UIStackView!
    @IBOutlet weak var detailview: UIView!
    @IBOutlet weak var dh: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var showsDetails = false {
        didSet {
            dh.priority = showsDetails ? 250 : 999
        }
    }

}
