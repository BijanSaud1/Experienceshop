//
//  Recipe.swift
//  Experienceshop
//
//  Created by Bijan Saud on 1/4/25.
//
import Foundation

struct Recipe: Identifiable {
    var id: String // Firestore document ID
    let name: String // Recipe name
    let description: String // Recipe description
    let ingredients: [String] // List of ingredients (e.g., ["Tomato", "Garlic", "Lettuce"])
    let instructions: String // Full recipe instructions
    let prepTime: String // Preparation time
    let cookTime: String // Cooking time
    let totalPrice: Double // Estimated price for the recipe
    let groceryItems: [GroceryItem]? // Optional grocery items (detailed info)
}
