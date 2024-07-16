//
//  SearchFieldView.swift
//  DessertApp
//
//  Created by Angelina on 7/15/24.
//

import SwiftUI

struct SearchFieldView: View {
    @State var search: String = ""
    var action: () -> Void
    
    var body: some View {
        HStack{
            TextField("Search for desserts...", text: $search)
            Spacer()
            
            Button{
                self.action()
                print("test")
            }label: {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(
        
        RoundedRectangle(cornerRadius: 30)
            .fill(.white)
        )
    }
}

#Preview {
    SearchFieldView(action: {
          print("Search button pressed")
      })
}
