//
//  RecipeView.swift
//  DessertApp
//
//  Created by Angelina on 7/12/24.
//

import SwiftUI

struct RecipeView: View {

    @EnvironmentObject var recipeModel: RecipeModel
    @Environment(\.dismiss) var dismiss // Accesses the environment's dismiss action to close the view
    @State var dessert: Dessert // Holds the dessert data passed to this view
    @State var loading = false
    
    
    

    var body: some View {
        GeometryReader { geo in
            
            
                if(loading)
                {
                 ProgressView()
                }
            else{
                ScrollView(.vertical) {
                    
                    
                    
                    ZStack(alignment: .top) {
                        // Displays the dessert image
                        ImageView(urlString: getURL(dessert: dessert))
                            .frame(height: geo.size.height * 0.40)
                        
                        HStack {
                            Button {
                                dismiss() // Dismiss the view
                            } label: {
                                Image(systemName: "arrow.left.circle.fill")
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        }
                        .padding(.top, 35)
                        .padding(.leading, 20)
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .offset(y: -40)
                        
                        VStack {
                            HStack {
                                
                                Text(dessert.name)
                                    .fontWeight(.semibold)
                                    .font(.title2)
                                    .padding(.leading)
                                Spacer()
                                
                                Button(action: {
                                    if recipeModel.isFavorite(dessert: dessert) {
                                        recipeModel.removeRecipe(dessert: dessert)
                                    } else {
                                        recipeModel.addRecipe(dessert: dessert)
                                    }
                                }, label: {
                                    Image(systemName: recipeModel.isFavorite(dessert: dessert) ? "heart.fill" : "heart")
                                        .padding(.trailing)
                                        .foregroundColor(recipeModel.isFavorite(dessert: dessert) ? Color(.red) : Color(.black))
                                })
                            }
                            
                            HStack {
                                Text("Ingredients")
                                    .foregroundColor(.gray)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                            .padding([.leading, .trailing, .top])
                            
                            Divider()
                                .padding([.leading, .trailing, .bottom])
                            
                            // Displays the list of ingredients and measurements
                            if let ing = dessert.recipe?.ingredients, let meas = dessert.recipe?.measurements {
                                ForEach(Array(zip(ing.indices, zip(ing, meas))), id: \.0) { index, pair in
                                    let (ingredient, measurement) = pair
                                    HStack {
                                        Image(systemName: "square")
                                        Text(measurement)
                                            .fontWeight(.semibold)
                                        Text(ingredient)
                                        Spacer()
                                    }
                                    .padding(.leading)
                                    .padding(.bottom, 2)
                                }
                            }
                            
                            // Displays the instructions
                            if let instruct = dessert.recipe?.instruction {
                                let separatedText = instruct.components(separatedBy: "\r\n")
                                HStack {
                                    Text("Instructions")
                                        .foregroundColor(.gray)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    Spacer()
                                }
                                .padding([.leading, .trailing, .top])
                                
                                Divider()
                                    .padding([.leading, .trailing])
                                
                                VStack(alignment: .leading) {
                                    ForEach(separatedText, id: \.self) { paragraph in
                                        Text(paragraph)
                                            .padding([.leading, .trailing, .top])
                                    }
                                }
                            }
                        }
                    
                }
            }
        }
                
             
               
            
            
            
            

      
        }
        .onAppear(perform: {
            Task{
                loading = true
                await recipeModel.getRecipe(dessert:dessert)
    
                loading = false
            }
        })
        .ignoresSafeArea()
    }
}


#Preview {
    RecipeView(dessert: Dessert(
        id: "53049",
        name: "Food",
        thumbnail: #"https:\/\/www.themealdb.com\/images\/media\/meals\/adxcbq1619787919.jpg"#,
        recipe: Recipe(
            id: "53049",
            instruction: """
                Mix milk, oil and egg together. Sift flour, baking powder and salt into the mixture. Stir well until all ingredients are combined evenly.\r\n\r\nSpread some batter onto the pan. Spread a thin layer of batter to the side of the pan. Cover the pan for 30-60 seconds until small air bubbles appear.\r\n\r\nAdd butter, cream corn, crushed peanuts and sugar onto the pancake. Fold the pancake into half once the bottom surface is browned.\r\n\r\nCut into wedges and best eaten when it is warm.
            """,
            youtube_link: "https://www.youtube.com",
            ingredients: ["Baking Powder", "Salt", "Peanuts"],
            measurements: ["1ts", "2 cups", "3 cups"]
        )
    ))
    .environmentObject(RecipeModel())
}
