//
//  ImageView.swift
//  DessertApp
//
//  Created by Angelina on 7/12/24.
//

import Foundation
import SwiftUI

struct ImageView: View {
    @ObservedObject private var imageViewModel: ImageViewModel
    
    init(urlString: String?) {
        imageViewModel = ImageViewModel(urlString: urlString)
    }
    
    var body: some View {
        Image(uiImage: imageViewModel.image ?? UIImage())
            .resizable()
    }
    
    
    func getURL(dessert:Dessert) -> String{
        
        let processedURL = dessert.thumbnail.replacingOccurrences(of: "\\", with: "")
        return processedURL
    }
    
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(urlString: "https://developer.apple.com/news/images/og/swiftui-og.png")
    }
}
