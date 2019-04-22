//
//  Category.swift
//  ToDoye
//
//  Created by AH on 22/04/2019.
//  Copyright © 2019 AH. All rights reserved.
//

import Foundation
import RealmSwift


class Category : Object {
    
    @objc dynamic var name : String = ""
    
    // this specifies an array of objects of class Item
    // this is a forward relationship
    let items = List<Item>()
    
}
