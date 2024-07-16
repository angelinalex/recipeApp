//
//  RecipeCardView.swift
//  DessertApp
//
//  Created by Angelina on 7/12/24.
//


import SwiftUI

struct RecipeCardView: View {
    var dessert: Dessert // Holds the dessert data for the card
    
    // Returns the count of ingredients in the dessert recipe
    func getIngredientCount() -> Int {
        if let ingredients = dessert.recipe?.ingredients as? [String] {
            return ingredients.count
        } else {
            return 0
        }
    }

    var body: some View {
        VStack {
            // Displays the dessert image
            ImageView(urlString: getURL(dessert: dessert))
                .aspectRatio(3/3, contentMode: .fit)
            
            HStack {
                Text(dessert.name)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .frame(height: 60)
            .padding(.top, 5)
            .padding(.leading)
            .padding(.bottom, 20)
        }
        .padding(.bottom)
        .background(Color(.white)) // Sets the background color of the card
        .clipShape(RoundedRectangle(cornerRadius: 15)) // Clips the card to have rounded corners
    }
}
#Preview {
    RecipeCardView(dessert: Dessert(id: "53049", name: "Food", thumbnail: #"https:\/\/www.themealdb.com\/images\/media\/meals\/adxcbq1619787919.jpg"#, recipe:  Recipe(id: "53049", instruction: "Mix milk, oil and egg together. Sift flour, baking powder and salt into the mixture. Stir well until all ingredients are combined evenly.\r\n\r\nSpread some batter onto the pan. Spread a thin layer of batter to the side of the pan. Cover the pan for 30-60 seconds until small air bubbles appear.\r\n\r\nAdd butter, cream corn, crushed peanuts and sugar onto the pancake. Fold the pancake into half once the bottom surface is browned.\r\n\r\nCut into wedges and best eaten when it is warm.", youtube_link: "https://www.youtube.com", ingredients: ["Baking Powder", "Salt", "Peanuts"], measurements: ["1ts", "2 cups", "3 cups"])))
}
