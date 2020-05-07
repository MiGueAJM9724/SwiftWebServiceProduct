//
//  Product.swift
//  WebServiceProduct
//
//  Created by Jimenez Melendez Miguel Angel on 05/05/20.
//  Copyright © 2020 Jimenez Melendez Miguel Angel. All rights reserved.
//

import Foundation

class Product{
    var id_producto: String?
    var product_name: String?
    var existence: String?
    var price: String?
    
    init(id_product: String?, product_name: String?, existence: String?, price: String?){
        self.id_producto = id_product
        self.product_name = product_name
        self.existence = existence
        self.price = price
    }
}
