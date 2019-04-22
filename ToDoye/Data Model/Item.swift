//
//  Item.swift
//  ToDoye
//
//  Created by AH on 22/04/2019.
//  Copyright © 2019 AH. All rights reserved.
//

import Foundation
import RealmSwift


class Item : Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    var parent_category = LinkingObjects(fromType: Category.self, property: "items")
    
}
