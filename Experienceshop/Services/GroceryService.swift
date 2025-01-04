//
//  GroceryService.swift
//  Experienceshop
//
//  Created by Bijan Saud on 1/4/25.
//

//  GroceryService.swift
//  Experienceshop
//
//  Created by Bijan Saud on 1/4/25.
//

import Foundation

class GroceryService {
    /// Generates a grocery list based on user preferences.
    /// - Parameters:
    ///   - preferences: The user's grocery preferences.
    ///   - completion: A completion handler that returns the generated list or an error.
    static func generateGroceryList(preferences: GroceryPreferences, completion: @escaping (Result<[String], GroceryServiceError>) -> Void) {
        // Simulate AI processing (replace with actual API logic)
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            // Simulated success or error scenario
            let success = Bool.random() // Simulate random success/failure for demo

            if success {
                let list = [
                    "Broccoli",
                    "Chicken Breast",
                    "Almond Milk",
                    "Quinoa",
                    "Olive Oil",
                    "Greek Yogurt",
                    "Blueberries",
                    "Spinach"
                ]
                completion(.success(list))
            } else {
                completion(.failure(.aiProcessingFailed))
            }
        }
    }
}

/// Struct to define user preferences for the grocery list.
struct GroceryPreferences {
    let budget: Double
    let diets: [String]
    let allergies: [String]
    let values: [String]
}

/// Enum to handle errors in the GroceryService.
enum GroceryServiceError: Error, LocalizedError {
    case aiProcessingFailed
    case networkError

    var errorDescription: String? {
        switch self {
        case .aiProcessingFailed:
            return "The AI processing failed to generate a grocery list. Please try again."
        case .networkError:
            return "A network error occurred. Please check your internet connection."
        }
    }
}
