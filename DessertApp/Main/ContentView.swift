//
//  ContentView.swift
//  DessertApp
//
//  Created by Angelina on 7/11/24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var recipeModel: RecipeModel;
    
    
    
    
    var body: some View {
        VStack {
            
            NavigatorTabView()
            
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(RecipeModel())

}
