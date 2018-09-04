//
//  Item.swift
//  Todoey
//
//  Created by Shawn on 2018/9/3.
//  Copyright © 2018年 Shawn. All rights reserved.
//

import Foundation

// This can encode and decode itself to an external representation
class Item : Codable{
    var title : String = ""
    var done : Bool = false
    
}
