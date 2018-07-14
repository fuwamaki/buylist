//
//  BuyListInteractor.swift
//  BuyList
//
//  Created by 牧 宥作 on 2017/08/18.
//  Copyright © 2017年 牧 宥作. All rights reserved.
//

import Foundation

protocol BuyListInteractable {
    func getItems() -> [ItemEntity]
    func saveItem(name: String, count: Int)
    func getBuyListMockData() -> [ItemEntity]
}

class BuyListInteractor: BuyListInteractable {

    private let itemRealm = ItemRealm()

    private struct Constant {
        static let none = "なし"
    }

    func getItems() -> [ItemEntity] {
        return itemRealm.realmAction(action: .find) ?? []
    }

    func saveItem(name: String, count: Int) {
        let itemRealmEntity = ItemRealmEntity(value: ["buyId": "0002", "itemId": "0002", "name": name, "count": count, "createTime": Date()])
        let _ = itemRealm.realmAction(action: .save, item: itemRealmEntity)
    }

    // mock
    let loadJsonFile = LoadJsonFile()
    func getBuyListMockData() -> [ItemEntity] {
        var items: [ItemEntity] = []
        if let jsonDate = loadJsonFile.getJson() {
            jsonDate.rows.forEach {
                items.append(ItemEntity(buyId: "1", itemId: $0.itemId, name: $0.name, count: $0.count, createTime: Date()))
            }
        }
        return items
    }
}
