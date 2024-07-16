//
//  getURL.swift
//  DessertApp
//
//  Created by Angelina on 7/12/24.
//

import Foundation

func getURL(dessert: Dessert) -> String{
    
    let processedURL = dessert.thumbnail.replacingOccurrences(of: "\\", with: "")
    return processedURL
}
