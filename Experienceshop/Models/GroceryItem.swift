//
//  GroceryItem.swift
//  Experienceshop
//
//  Created by Bijan Saud on 1/4/25.
//

import Foundation

// GroceryItem Model
struct GroceryItem: Identifiable, Codable {
    var id: String
    let itemName: String
    let itemPrice: Double
    let brandName: String
    let productCategory: String
    let productDescription: String
    let imageUrl: String
    let aisleNumber: String
    let nutritionFacts: NutritionFacts
}
