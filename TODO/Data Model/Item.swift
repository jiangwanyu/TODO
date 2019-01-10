//
//  Item.swift
//  TODO
//
//  Created by 超级电脑 on 2019/1/8.
//  Copyright © 2019年 超级电脑. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var a = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
