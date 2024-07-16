//
//  Recipe.swift
//  DessertApp
//
//  Created by Angelina on 7/11/24.
//

import Foundation

struct Recipe: Codable, Identifiable{
    
    var id: String;
    var instruction: String;
    var youtube_link: String;
    var ingredients : [String];
    var measurements : [String];
    
    init(id: String, instruction: String, youtube_link: String, ingredients: [String], measurements: [String]) {
        self.id = id
        self.instruction = instruction
        self.youtube_link = youtube_link
        self.ingredients = ingredients
        self.measurements = measurements
    }
}

