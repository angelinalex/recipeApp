//
//  RecipeModel.swift
//  DessertApp
//
//  Created by Angelina on 7/11/24.
//

import Foundation
import UIKit

@MainActor
class RecipeModel: ObservableObject {
    @Published var favorites: [Dessert] = []
    @Published var recipeBook: [Dessert] = [] // Stores the list of desserts
    @Published var images: [String: UIImage] = [:] // Stores the images of the desserts
    @Published var loading = false // Indicates whether data is being loaded
    private var webService = WebService() // Instance of WebService to handle API calls
    var api_URL_Dessert = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert" // API endpoint to fetch dessert data
    var api_recipe_URL = "https://themealdb.com/api/json/v1/1/lookup.php?i=" // API endpoint to fetch recipe details

    init() {}

    // Fetches data from the API
    func fetchData() async {
        
     
    
            // Downloads data from the dessert API URL
            guard let data = await webService.downloadData(fromURL: api_URL_Dessert),
                  let meals = data["meals"] as? [[String: Any]]
            else {
                return
            }
            recipeBook = convertToDesserts(from: meals) // Converts the data to an array of Dessert objects
       
    }
    


    // Iterates over each dessert to fetch detailed recipe information for all desserts 
    func setRecipies() async{
        
        for (index, var dessert_item) in recipeBook.enumerated() {
            let mealID = dessert_item.id
            let url = api_recipe_URL + mealID
            // Downloads data from the recipe API URL
            guard let data = await webService.downloadData(fromURL: url),
                  let recipe_dictionary = data["meals"] as? [[String: Any]] else {
                return
            }
            
            let recipe = convertRecipe(from: recipe_dictionary) // Converts the data to a Recipe object
            
            // Updates the dessert item with the new recipe
            dessert_item.setRecipe(newRecipe: recipe)
            // Updates the array with the modified dessert item
            recipeBook[index] = dessert_item
        }
        
    }
    
    
    ///set individual recipe
    func getRecipe(dessert: Dessert) async  {
        let mealID = dessert.id
        let url = api_recipe_URL + mealID
        
        // Downloads data from the recipe API URL
        guard let data = await webService.downloadData(fromURL: url),
              let recipe_dictionary = data["meals"] as? [[String: Any]] else {
            return // Return nil if data cannot be fetched or parsed
        }
        
        let recipe = convertRecipe(from: recipe_dictionary) // Converts the data to a Recipe object
        
        // Find the index of the dessert in recipeBook
        if let index = recipeBook.firstIndex(where: { $0.id == dessert.id }) {
            var updatedDessert = recipeBook[index]
            updatedDessert.setRecipe(newRecipe: recipe)
            recipeBook[index] = updatedDessert

        }
        // Return the fetched recipe if successful
    }

    
    
    // Converts a dictionary of meal data to an array of Dessert objects
    func convertToDesserts(from dictionary: [[String: Any]]) -> [Dessert] {
       
        var desserts: [Dessert] = []
        
        for item in dictionary {
            if let idMeal = item["idMeal"] as? String,
               let strMeal = item["strMeal"] as? String,
               let strMealThumb = item["strMealThumb"] as? String {
                let dessert = Dessert(id: idMeal, name: strMeal, thumbnail: strMealThumb)
                desserts.append(dessert)
            } else if let idMeal = item["idMeal"] as? Int,
                      let strMeal = item["strMeal"] as? String,
                      let strMealThumb = item["strMealThumb"] as? String {
                let dessert = Dessert(id: String(idMeal), name: strMeal, thumbnail: strMealThumb)
                desserts.append(dessert)
            }
        }
        
        return desserts
    }

    // Converts a dictionary of recipe data to a Recipe object
    func convertRecipe(from dictionary: [[String: Any]]) -> Recipe {
        var id: String = ""
        var youtube: String = ""
        var instruction: String = ""
        var ingredients: [String] = []
        var measurements: [String] = []
        
        for item in dictionary {
            if let idMeal = item["idMeal"] as? String,
               let instruct = item["strInstructions"] as? String,
               let utube = item["strYoutube"] as? String {
                id = idMeal
                instruction = instruct
                youtube = utube
            }
            
            // Parses ingredients and measurements from the dictionary
            for (key, value) in item {
                if key.starts(with: "strIngredient"), let stringValue = value as? String, !stringValue.isEmpty {
                    let trimmedValue = stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
                    if !trimmedValue.isEmpty {
                        ingredients.append(trimmedValue)
                    }
                } else if key.starts(with: "strMeasure"), let stringValue = value as? String, !stringValue.isEmpty {
                    let trimmedValue = stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
                    if !trimmedValue.isEmpty {
                        measurements.append(trimmedValue)
                    }
                }
            }
        }
        
        return Recipe(id: id, instruction: instruction, youtube_link: youtube, ingredients: ingredients, measurements: measurements)
    }
    
    func addRecipe(dessert: Dessert) {
        if !favorites.contains(where: { $0.id == dessert.id }) {
            favorites.append(dessert)
        }
    }
    
    func removeRecipe(dessert: Dessert) {
        if let index = favorites.firstIndex(where: { $0.id == dessert.id }) {
            favorites.remove(at: index)
        }
    }
    
    func isFavorite(dessert: Dessert) -> Bool {
          return favorites.contains(where: { $0.id == dessert.id })
      }
}
