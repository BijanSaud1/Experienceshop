import SwiftUI
import FirebaseFirestore

struct RecipeListView: View {
    @State private var pastRecipes: [Recipe] = []  // To store past recipes from Firestore
    @State private var showPastRecipes: Bool = false // Boolean to toggle between past and newly fetched recipes
    let recipes: [Recipe]
    let groceryItems: [GroceryItem]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // Toggle to switch between newly fetched recipes and past recipes
                    Toggle("Show Past Recipes", isOn: $showPastRecipes)
                        .padding()
                        .toggleStyle(SwitchToggleStyle(tint: .green))

                    // Display newly fetched recipes
                    Text("Newly Fetched Recipes")
                        .font(.headline)
                        .padding(.top)
                    ForEach(recipes) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe, groceryItems: groceryItems)) {
                            VStack(alignment: .leading) {
                                Text(recipe.name) // Display actual recipe name
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
                                Divider() // Divider between recipes
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color.white).shadow(radius: 5))
                        }
                    }

                    // Only show past recipes when toggled on
                    if showPastRecipes {
                        // Divider between newly fetched and past recipes
                        Divider().padding(.vertical)

                        // Display past recipes from Firestore
                        Text("Past Recipes")
                            .font(.headline)
                            .padding(.top)

                        if pastRecipes.isEmpty {
                            Text("No past recipes available.")
                                .font(.body)
                                .foregroundColor(.gray)
                                .padding()
                        } else {
                            ForEach(pastRecipes) { recipe in
                                NavigationLink(destination: RecipeDetailView(recipe: recipe, groceryItems: groceryItems)) {
                                    VStack(alignment: .leading) {
                                        Text(recipe.name) // Display actual recipe name
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
                    }
                }
                .padding()
                .onAppear {
                    fetchPastRecipes()
                }
            }
            .navigationBarTitle("Recipes", displayMode: .inline)
        }
    }

    // Fetch the past recipes from Firestore
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
                
                // Update the UI with the fetched recipes
                self.pastRecipes = fetchedRecipes
            }
        }
    }
}
