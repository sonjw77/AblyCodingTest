//
//  ListModel.swift
//  AblyCodingTest
//
//  Created by alvin on 2021/07/13.
//

import ObjectMapper

class ListModel: Mappable {
    var banners: [Banners]?
    var goods: [Goods]?
    
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        banners <- map["banners"]
        goods <- map["goods"]
    }
    
    class Banners: Mappable {
        var id: Int?
        var image: String?
        
        required init?(map: Map) {

        }

        func mapping(map: Map) {
            id <- map["id"]
            image <- map["image"]
        }
    }
    
    class Goods: Mappable {
        var id: Int?
        var name: String?
        var image: String?
        var actual_price: String?
        var price: Int?
        var is_new: Bool?
        var sell_count: Int?
        
        required init?(map: Map) {

        }

        func mapping(map: Map) {
            id <- map["id"]
            name <- map["name"]
            image <- map["image"]
            actual_price <- map["actual_price"]
            price <- map["price"]
            is_new <- map["is_new"]
            sell_count <- map["sell_count"]
        }
    }
}
