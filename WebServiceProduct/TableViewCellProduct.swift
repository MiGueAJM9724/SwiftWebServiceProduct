//
//  TableViewCellProduct.swift
//  WebServiceProduct
//
//  Created by Jimenez Melendez Miguel Angel on 04/05/20.
//  Copyright © 2020 Jimenez Melendez Miguel Angel. All rights reserved.
//

import UIKit

class TableViewCellProduct: UITableViewCell {
    @IBOutlet weak var lbproduct_name: UILabel!
    @IBOutlet weak var lbprice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
