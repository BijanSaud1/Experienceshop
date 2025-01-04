//
//  GroceryListView.swift
//  Experienceshop
//
//  Created by Bijan Saud on 1/4/25.
//

import SwiftUI

struct GroceryListView: View {
    let groceryList: [String]

    var body: some View {
        VStack {
            Text("Your Grocery List")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            List(groceryList, id: \.self) { item in
                Text(item)
                    .font(.headline)
            }
            .listStyle(PlainListStyle())

            Button(action: {
                // Close the view or go back to the main screen
            }) {
                Text("Done")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.pink)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
        }
    }
}
