//
//  Dessert.swift
//  DessertApp
//
//  Created by Angelina on 7/11/24.
//

import Foundation
import UIKit
import SwiftData


struct Dessert: Codable, Identifiable{
    
    var id: String;
    var name: String;
    var thumbnail: String;
    var recipe: Recipe?;
    
    
    
    init(id: String, name: String, thumbnail: String, recipe: Recipe? = nil) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.recipe = recipe
    }
    
    
    mutating func setRecipe(newRecipe: Recipe){
        self.recipe = newRecipe
    }
}
