//
//  ProductListModel.swift
//  SwipeAssignment
//
//  Created by Sudeepa Pal on 10/11/24.
//

import Foundation

struct ProductListModel: Decodable {
    let image: String
    let price: Double
    let product_name: String
    let product_type: String
    let tax: Double
}
