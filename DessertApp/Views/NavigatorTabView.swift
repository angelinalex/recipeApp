//
//  NavigatorTabView.swift
//  DessertApp
//
//  Created by Angelina on 7/16/24.
//

import SwiftUI

enum Tabs{
    case Book
    case Favorites
}


struct NavigatorTabView: View {
    @State var selectedTab = Tabs.Book
    @EnvironmentObject var recipeModel: RecipeModel // Accesses the shared RecipeModel instance
    @State var loading = false;
    
    var body: some View {
        
        VStack{
            
            if(loading){
                
                VStack{
                    Spacer()
                    ProgressView()
                        .tint(.red)
                 
                     
                    Spacer()
                }
           
            }
            else{
                switch(selectedTab){
                case Tabs.Book:
                    RecipeHomeView()
                case Tabs.Favorites:
                    FavoritesView()
                    
                }
            }
            
            Spacer()

            HStack{
                Spacer()
                Button(action: {
                    selectedTab = Tabs.Book
                }, label: {
                   Image(systemName: "book.fill")
                        .foregroundColor(.red)
                })
                
                Spacer()
                Button(action: {
                    selectedTab = Tabs.Favorites
                }, label: {
                   Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                })
                Spacer()
                
            }
            .padding(.top)
            .background(Color(.white))
          
            
            
        }
        .onAppear(perform: {
            Task{
                loading = true
                await recipeModel.fetchData()
                await recipeModel.setRecipies()
                loading = false
            }
        })
        
    }
}

#Preview {
    NavigatorTabView()
        .environmentObject(RecipeModel())

}
