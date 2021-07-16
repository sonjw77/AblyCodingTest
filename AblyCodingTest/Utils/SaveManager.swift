//
//  SaveManager.swift
//  AblyCodingTest
//
//  Created by alvin on 2021/07/16.
//

import UIKit
import RealmSwift

class SaveItem: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var image = ""
    @objc dynamic var actual_price = 0
    @objc dynamic var price = 0
    @objc dynamic var is_new = false
    @objc dynamic var sell_count = 0
}

class SaveManager {
    
    // MARK: Singleton
    private static let instance = SaveManager()
    private let realm = try! Realm()
    
    class func sharedInstance () -> SaveManager {
        return instance
    }
    
    func checkItem(model: ListModel.Goods, isFavorite: Bool) {
        
        let resut = realm.objects(SaveItem.self).filter("id == \(model.id ?? 0)")
            
        try! realm.write {
            if resut.count == 0 && isFavorite == true {
                let item = SaveItem()
                item.id = model.id ?? 0
                item.name = model.name ?? ""
                item.image = model.image ?? ""
                item.actual_price = model.actual_price ?? 0
                item.price = model.price ?? 0
                item.is_new = model.is_new ?? false
                item.sell_count = model.sell_count ?? 0
                
                realm.add(item)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeFavoriteList"),object: nil)
            } else if resut.count == 1 && isFavorite == false {
                realm.delete(resut)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeFavoriteList"),object: nil)
            }
        }
    }
    
    func isExistItem(id: Int) -> Bool {
        let resut = realm.objects(SaveItem.self).filter("id == \(id)")
        return resut.count == 0 ? false : true
    }
    
    func getItem(index: Int) -> ListModel.Goods {
        let favoriteGoods = realm.objects(SaveItem.self)[index]
        let item = ListModel.Goods(JSON: ["id":favoriteGoods.id ,"name":favoriteGoods.name,"image":favoriteGoods.image,"actual_price":favoriteGoods.actual_price,"price":favoriteGoods.price,"is_new":favoriteGoods.is_new,"sell_count":favoriteGoods.sell_count])!
        
        return item
    }
    
    func getListCount() -> Int {
        realm.objects(SaveItem.self).count
    }
}
