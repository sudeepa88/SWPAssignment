//
//  Favourites.swift
//  SwipeAssignment
//
//  Created by Sudeepa Pal on 11/11/24.
//

import Foundation
import RealmSwift


class Favourites:Object {
    @objc dynamic var title: String = ""
    @objc dynamic var price: Double = 0.0
    @objc dynamic var productType: String = ""
    @objc dynamic var productTax: Double = 0.0
    @objc dynamic var productImage: String = ""
   
    @objc dynamic var fav: Bool = false
}
