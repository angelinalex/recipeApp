//
//  WebService.swift
//  DessertApp
//
//  Created by Angelina on 7/11/24.
//

import Foundation
import SwiftUI

enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}

class WebService {
    
    var api_URL_Dessert = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    var api_recipe_URL = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    
    func downloadData(fromURL urlString: String) async -> [String: Any]? {
        do {
            guard let url = URL(string: urlString) else { throw NetworkError.badUrl }
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.badResponse }
            guard httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
                
//                print(url)
                throw NetworkError.badStatus }
            
            // Debugging output
//            print("Request successful for URL: \(url)")
            
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                  let dictionary = jsonObject as? [String: Any] else { throw NetworkError.failedToDecodeResponse }
          
            return dictionary
        } catch let error as NetworkError {
            print("Network error: \(error.localizedDescription)")
        } catch {
            print("An error occurred downloading data: \(error.localizedDescription)")
        }
        
        return nil
    }


}
