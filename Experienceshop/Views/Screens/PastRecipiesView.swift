//
//  PastRecipiesView.swift
//  Experienceshop
//
//  Created by Bijan Saud on 1/5/25.
//

import SwiftUI
import FirebaseFirestore

struct PastRecipesView: View {
    @State private var pastRecipes: [Recipe] = []

    var body: some View {
        VStack {
            Text("Past Recipes")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            if pastRecipes.isEmpty {
                Text("No past recipes available.")
                    .font(.body)
                    .foregroundColor(.gray)
            } else {
                List(pastRecipes) { recipe in
                    VStack(alignment: .leading) {
                        Text(recipe.name)
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Prep Time: \(recipe.prepTime)")
                            .font(.body)
                            .padding(.vertical, 2)
                        Text("Cook Time: \(recipe.cookTime)")
                            .font(.body)
                            .padding(.vertical, 2)
                        Text("Estimated Price: $\(recipe.totalPrice, specifier: "%.2f")")
                            .font(.subheadline)
                            .foregroundColor(.green)
                        Divider() // Divider between past recipes
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color.white).shadow(radius: 5))
                }
            }
        }
        .onAppear {
            fetchPastRecipes()
        }
        .padding()
    }

    // Fetch past recipes from Firestore
    func fetchPastRecipes() {
        let db = Firestore.firestore()
        db.collection("recipes").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching past recipes: \(error)")
                return
            }

            if let snapshot = snapshot {
                var fetchedRecipes: [Recipe] = []

                for document in snapshot.documents {
                    let data = document.data()

                    // Manually map the Firestore document to a Recipe object
                    if let name = data["name"] as? String,
                       let prepTime = data["prep_time"] as? String,
                       let cookTime = data["cook_time"] as? String,
                       let totalPrice = data["total_price"] as? Double {

                        let recipe = Recipe(
                            id: document.documentID,
                            name: name,
                            description: "", // Not displaying description
                            ingredients: [], // Not displaying ingredients
                            instructions: "", // Not displaying instructions
                            prepTime: prepTime,
                            cookTime: cookTime,
                            totalPrice: totalPrice,
                            groceryItems: nil // Assuming no grocery items for now
                        )

                        fetchedRecipes.append(recipe)
                    }
                }

                self.pastRecipes = fetchedRecipes
            }
        }
    }
}
