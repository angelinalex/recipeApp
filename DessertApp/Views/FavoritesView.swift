//
//  FavoritesView.swift
//  DessertApp
//
//  Created by Angelina on 7/16/24.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var recipeModel: RecipeModel
    
    var backgroundcolor = Color(#colorLiteral(red: 0.9620524049, green: 0.932325542, blue: 0.9285528064, alpha: 1)) // Background color for the view
    
    
    // Defines a two-column flexible grid layout
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        NavigationView {
            GeometryReader{
                geo in
                
                VStack{
                    
                    HStack{
                        Text("Favorites")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.semibold)
                        
              
                        Spacer()
                            
                    }
                    .padding()
                    Divider()
                        .padding()
                 
                    
                    
                    
                    
                    
                    Spacer()
                    if(recipeModel.favorites.isEmpty){
                        
                    }
                    else{
                        
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(recipeModel.favorites) { dessert in
                                    NavigationLink {
                                        RecipeView(dessert: dessert)
                                            .navigationBarBackButtonHidden()
                                    } label: {
                                        RecipeCardView(dessert: dessert)
                                            .frame(width: geo.size.width * 0.4)
                                    }
                                }
                            }
                        }
                    }
                }
                .background(backgroundcolor)
                
            }
        }
        
    
    }
}

#Preview {
    FavoritesView()
        .environmentObject(RecipeModel())

}
