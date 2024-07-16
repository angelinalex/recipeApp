//
//  DessertAppApp.swift
//  DessertApp
//
//  Created by Angelina on 7/11/24.
//

import SwiftUI
import SwiftData

@main
struct DessertAppApp: App {

    @StateObject var recipeModel = RecipeModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(RecipeModel())
        }
    }
}
