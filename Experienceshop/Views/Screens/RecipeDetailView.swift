import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    let groceryItems: [GroceryItem]

    var body: some View {
        VStack(spacing: 20) {
            // Recipe Title
            Text(recipe.name)
                .font(.largeTitle)
                .fontWeight(.bold)

            // Recipe Description
            Text(recipe.description)
                .font(.body)
                .foregroundColor(.gray)

            // Total Price (based on grocery items)
            Text("Total Price: $\(String(format: "%.2f", calculateTotalPrice()))")
                .font(.title)
                .foregroundColor(.green)

            // Ingredients List
            Text("Ingredients:")
                .font(.headline)
                .padding(.top)

            List(recipe.ingredients, id: \.self) { item in
                Text(item)
            }

            // Instructions (You can add instructions if they are available in the recipe)
            if !recipe.instructions.isEmpty {
                Text("Instructions:")
                    .font(.headline)
                    .padding(.top)
                
                Text(recipe.instructions)
                    .font(.body)
                    .padding(.top)
            } else {
                Text("No instructions available.")
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.top)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Recipe Details")
    }

    // Function to calculate total price based on the grocery items
    func calculateTotalPrice() -> Double {
        var total: Double = 0.0
        for item in groceryItems {
            total += item.itemPrice  // Updated field name to match GroceryItem
        }
        return total
    }
}
