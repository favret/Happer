//
//  ProductDetailsBidTableViewCell.swift
//  happer
//
//  Created by Charles Fournier on 02/11/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class ProductDetailsBidTableViewCell: UITableViewCell {

    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
 
        // Configure the view for the selected state
    }

}
