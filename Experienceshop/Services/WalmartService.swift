import Foundation

class WalmartService {
    static func fetchAndFilterItems(preferences: GroceryPreferences, completion: @escaping ([GroceryItem]) -> Void) {
        guard let url = Bundle.main.url(forResource: "walmart", withExtension: "json") else {
            print("Error: Could not find walmart.json")
            return
        }

        do {
            // Decode the JSON data
            let data = try Data(contentsOf: url)
            let items = try JSONDecoder().decode([GroceryItem].self, from: data)

            // Filter items based on preferences
            let filteredItems = items.filter { item in
                // Check budget
                guard item.itemPrice <= preferences.budget else { return false }

                // Check dietary restrictions (if applicable)
                let matchesDiet = preferences.diets.isEmpty || preferences.diets.contains { diet in
                    item.productCategory.lowercased().contains(diet.lowercased())
                }

                // Check allergies (exclude items that contain allergens)
                let matchesAllergies = preferences.allergies.isEmpty || preferences.allergies.allSatisfy { allergen in
                    // Checking if allergens appear in nutritional facts (or any other relevant part of the product)
                    ![
                        item.nutritionFacts.dailyValues.protein,
                        item.nutritionFacts.dailyValues.fat,
                        item.nutritionFacts.dailyValues.carbohydrates,
                        item.nutritionFacts.dailyValues.addedSugar
                    ].contains(where: { $0.lowercased().contains(allergen.lowercased()) })
                }

                // Return true only if all conditions are met
                return matchesDiet && matchesAllergies
            }

            completion(filteredItems)
        } catch {
            print("Error decoding JSON: \(error)")
            completion([])
        }
    }
}
