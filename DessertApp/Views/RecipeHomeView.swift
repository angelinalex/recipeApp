//
//  RecipeHomeView.swift
//  DessertApp
//
//  Created by Angelina on 7/12/24.
//


import SwiftUI

import SwiftUI

struct RecipeHomeView: View {
    
    @EnvironmentObject var recipeModel: RecipeModel
    @State private var loading = false
    var backgroundcolor = Color(#colorLiteral(red: 0.9620524049, green: 0.932325542, blue: 0.9285528064, alpha: 1))
    @State private var search: String = ""
    @State private var searchValue: String = ""
    @State private var recipes: [Dessert] = []

   
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    func filterDesserts() {
        if searchValue.isEmpty {
            recipes = recipeModel.recipeBook
        } else {
            recipes = recipeModel.recipeBook.filter { $0.name.lowercased().contains(searchValue.lowercased()) }
        }
    }
    

    var body: some View {
        NavigationView {
            GeometryReader { geo in
                
                
                VStack {
                    HStack {
                        Text("Desserts")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.top, 55)
                    .padding([.trailing, .leading])
                    
                    HStack {
                        TextField("Search for desserts...", text: $search)
                        Spacer()
                        Button {
                            searchValue = search
                            search = ""
                            filterDesserts()
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.white)
                    )
                    .padding(.bottom, 10)
                    .padding([.trailing, .leading])
                    
                    if !searchValue.isEmpty {
                        Button(action: {
                            searchValue = ""
                            filterDesserts()
                        }, label: {
                            HStack(spacing: 3) {
                                Spacer()
                                Text("We found")
                                Text("\(recipes.count)")
                                    .fontWeight(.semibold)
                                Text("results for")
                                Text("\(searchValue)")
                                    .fontWeight(.semibold)
                                Image(systemName: "x.circle")
                                Spacer()
                            }
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .padding(.bottom, 4)
                        })
                    }
                    
                    VStack {
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(recipes) { dessert in
                                    NavigationLink {
                                        RecipeView(dessert: dessert)
                                            .navigationBarBackButtonHidden()
                                    } label: {
                                        RecipeCardView(dessert: dessert)
                                            .frame(width: geo.size.width * 0.4)
                                    }
                     
                                }
                            }
                            .padding()
                        }
                    }
                }
                .ignoresSafeArea()
                .background(backgroundcolor)
        
            }
        
        }
        .onAppear(perform: {
            filterDesserts()
            
        })
    }
}



#Preview {
    RecipeHomeView()
        .environmentObject(RecipeModel())
}
