//
//  NutritionFacts.swift
//  Experienceshop
//
//  Created by Bijan Saud on 1/4/25.
//
import Foundation

struct NutritionFacts: Codable {
    let caloriesPerServing: Int
    let dailyValues: DailyValues

    enum CodingKeys: String, CodingKey {
        case caloriesPerServing = "calories_per_serving"
        case dailyValues = "daily_values"
    }
}

struct DailyValues: Codable {
    let protein: String
    let fat: String
    let carbohydrates: String
    let addedSugar: String

    enum CodingKeys: String, CodingKey {
        case protein
        case fat
        case carbohydrates
        case addedSugar = "added_sugar"
    }
}
