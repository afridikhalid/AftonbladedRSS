//
//  CategoriesModel.swift
//  AftonbladetRSS
//
//  Created by Khalid Afridi on 02/06/16.
//  Copyright © 2016 Khalid Afridi. All rights reserved.
//

import Foundation


class CategoriesModel {
    var name = ""
    var link = ""
    
    init(name: String, link: String) {
        self.name = name
        self.link = link
    }
}