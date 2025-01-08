import Foundation
import FirebaseFirestore

class RecipeService {

    static func fetchRecipes(diet: String, allergies: [String], budget: Double, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        // Your API key for Google Gemini
        let apiKey = "AIzaSyA8G-C4hMCUBR11V8_HiiSG3Uccr5xsXFk"  // Replace with your actual API key
        let apiURL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=\(apiKey)"

        // Construct the body for the POST request
        let requestBody: [String: Any] = [
            "contents": [
                [
                    "parts": [
                        [
                            "text" : "Generate a recipe with the following structured format: 1. Recipe Name: Provide a clear and creative name for the recipe. 2. Description: Write a brief description that highlights the recipe's suitability for the \(diet) diet. Explain any unique characteristics or health benefits of the dish. 3. Ingredients: List all required ingredients with exact quantities. Ensure the following: The recipe aligns with \(diet) dietary requirements (e.g., keto, vegan, gluten-free, etc.). Exclude any ingredients like \(allergies.joined(separator: ", ")) or derivatives of these allergens. 4. Prep Time: Specify the estimated preparation time in minutes. 5. Cook Time: Specify the estimated cooking time in minutes. 6. Total Cost: Ensure the total cost is under \(budget) dollars. Include an approximate cost for each ingredient where possible and provide a final estimated total. 7. Instructions: Provide step-by-step instructions that are clear, concise, and easy to follow. Include tips for efficiency or enhanced flavor where applicable. 8. Tips and Variations: Offer optional variations, substitutions for excluded ingredients, or serving suggestions to customize the recipe further. 9. Nutritional Information: Provide approximate nutritional details per serving, including calories, protein, fat, carbohydrates, and fiber content."
                        ]
                    ]
                ]
            ]
        ]
        
        // Convert the body into JSON data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            let error = NSError(domain: "com.recipes", code: -2, userInfo: [NSLocalizedDescriptionKey: "Failed to serialize request body"])
            completion(.failure(error))
            return
        }

        // Construct the URLRequest
        var request = URLRequest(url: URL(string: apiURL)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        // Make the network request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let error = NSError(domain: "com.recipes", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }

            do {
                // Print the raw response for debugging
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Raw API Response: \(responseString)")  // This will print the entire response in the console
                }

                // Parse the JSON response manually
                let responseJson = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                // Check the response for the expected structure
                if let candidates = responseJson?["candidates"] as? [[String: Any]],
                   let content = candidates.first?["content"] as? [String: Any],
                   let parts = content["parts"] as? [[String: Any]],
                   let text = parts.first?["text"] as? String {
                    
                    // Extract the recipe details from the text field
                    let recipe = Recipe(
                        id: UUID().uuidString, // You could use any unique ID here
                        name: "Generated Recipe",
                        description: text,
                        ingredients: extractIngredients(from: text),
                        instructions: extractInstructions(from: text),
                        prepTime: "10 minutes",
                        cookTime: "20 minutes",
                        totalPrice: budget,
                        groceryItems: nil // Set to nil for now, could be populated later
                    )
                    
                    // Save recipe to Firebase Firestore
                    saveRecipeToFirestore(recipe: recipe)

                    completion(.success([recipe]))  // Return the recipe as a list
                } else {
                    let error = NSError(domain: "com.recipes", code: -3, userInfo: [NSLocalizedDescriptionKey: "Invalid response format."])
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    // Helper function to save the recipe to Firestore
    static func saveRecipeToFirestore(recipe: Recipe) {
        let db = Firestore.firestore()

        // Create a new document reference (you could also use a custom document ID here)
        let recipeRef = db.collection("recipes").document(recipe.id)

        // Data to store in Firestore
        let recipeData: [String: Any] = [
            "name": recipe.name,
            "description": recipe.description,
            "ingredients": recipe.ingredients,
            "instructions": recipe.instructions,
            "prep_time": recipe.prepTime,
            "cook_time": recipe.cookTime,
            "total_price": recipe.totalPrice,
            "created_at": Timestamp(date: Date())
        ]

        // Set the document data
        recipeRef.setData(recipeData) { error in
            if let error = error {
                print("Error saving recipe to Firestore: \(error)")
            } else {
                print("Recipe successfully saved to Firestore!")
            }
        }
    }

    // Helper function to extract ingredients from the recipe text
    static func extractIngredients(from text: String) -> [String] {
        // Extract ingredients from the text using a regex or a simple split
        // For this example, it's assuming the ingredients section comes after "**Ingredients:**"
        if let ingredientsStart = text.range(of: "**Ingredients:**")?.upperBound,
           let instructionsStart = text.range(of: "**Instructions:**")?.lowerBound {
            let ingredientsSection = text[ingredientsStart..<instructionsStart]
            let ingredients = ingredientsSection.split(separator: "\n").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
            return ingredients
        }
        return []
    }

    // Helper function to extract instructions from the recipe text
    static func extractInstructions(from text: String) -> String {
        // Extract instructions from the text
        if let instructionsStart = text.range(of: "**Instructions:**")?.upperBound {
            return String(text[instructionsStart...]).trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return "No instructions available."
    }
}
