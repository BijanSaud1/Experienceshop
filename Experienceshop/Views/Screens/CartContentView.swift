import Foundation
import FirebaseFirestore
import SwiftUI

struct CartContentView: View {
    @State private var budget: Double = 50.0
    @State private var selectedDiets: [String] = []
    @State private var selectedAllergies: [String] = []
    @State private var recipes: [Recipe] = []
    @State private var showRecipeView: Bool = false

    let diets = ["Vegan", "Vegetarian", "Gluten-Free", "Paleo", "Keto"]
    let allergies = ["Peanuts", "Tree Nuts", "Dairy", "Eggs", "Soy", "Wheat", "Fish", "Shellfish"]

    var body: some View {
        NavigationView {
            VStack {
                // Budget Section
                budgetSection

                // Dietary Preferences Section
                filtersSection

                // Get Recipes Button
                Button(action: {
                    // Fetch recipes based on selected preferences
                    RecipeService.fetchRecipes(diet: selectedDiets.joined(separator: ","), allergies: selectedAllergies, budget: budget) { result in
                        switch result {
                        case .success(let fetchedRecipes):
                            self.recipes = fetchedRecipes
                            self.showRecipeView = true
                        case .failure(let error):
                            print("Error fetching recipes: \(error)")
                        }
                    }
                }) {
                    Text("Get Recipes")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(15)
                        .padding(.horizontal)
                }

                // Navigate to Past Recipes View
                NavigationLink(destination: PastRecipesView(), label: {
                    Text("View Past Recipes")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(15)
                        .padding(.horizontal)
                })
                
                // Show the list of recipes
                if showRecipeView {
                    NavigationLink(
                        destination: RecipeListView(recipes: recipes, groceryItems: []), // Just passing recipes, no groceryItems here
                        isActive: $showRecipeView
                    ) {
                        EmptyView()
                    }
                }
            }
            .navigationBarTitle("Recipe Finder", displayMode: .inline)
            .padding()
        }
    }

    // Budget Section
    var budgetSection: some View {
        VStack(alignment: .leading) {
            Text("Set Your Budget")
                .font(.title2)
                .fontWeight(.bold)
            Slider(value: $budget, in: 10...500, step: 5)
            Text("Budget: $\(budget, specifier: "%.2f")")
                .font(.headline)
                .foregroundColor(.pink)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.white).shadow(radius: 5))
    }

    // Dietary Preferences and Allergies Section
    var filtersSection: some View {
        VStack(alignment: .leading) {
            Text("Dietary Preferences")
                .font(.title2)
                .fontWeight(.bold)
            WrapHStack(items: diets, selectedItems: $selectedDiets)
            
            Text("Allergies")
                .font(.title2)
                .fontWeight(.bold)
            WrapHStack(items: allergies, selectedItems: $selectedAllergies)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.white).shadow(radius: 5))
    }
}
