//
//  Category.swift
//  TODO
//
//  Created by 超级电脑 on 2019/1/8.
//  Copyright © 2019年 超级电脑. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

class Category: Object {
    @objc dynamic var name: String = ""
   
    let items = List<Item>()
}
