//
//  FilteredGroceryListView.swift
//  Experienceshop
//
//  Created by Bijan Saud on 1/4/25.
//
import SwiftUI

struct FilteredGroceryListView: View {
    let filteredItems: [GroceryItem]
    let totalPrice: Double

    var body: some View {
        VStack {
            Text("Items Within Budget")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.pink)
                .padding()

            Text("Total Price: $\(String(format: "%.2f", totalPrice))")
                .font(.headline)
                .foregroundColor(totalPrice <= 50 ? .green : .red) // Example logic
                .padding(.bottom, 10)

            ScrollView {
                ForEach(filteredItems, id: \.id) { item in
                    GroceryCardView(item: item)
                }
            }
        }
        .padding()
        .background(LinearGradient(
            gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ).edgesIgnoringSafeArea(.all))
        .navigationBarTitle("Filtered List", displayMode: .inline)
    }
}


