import Foundation

class GroceryService {
    static func mapToGroceryItems(
        walmartItems: [WalmartItem],
        budget: Double,
        dietaryRestrictions: [String]
    ) -> [GroceryItem] {
        return walmartItems
            .filter { $0.itemPrice <= budget } // Apply budget filter
            .filter { item in
                // Check if the item meets dietary restrictions
                !dietaryRestrictions.contains(where: { restriction in
                    item.productDescription.lowercased().contains(restriction.lowercased())
                })
            }
            .map { item in
                GroceryItem(
                    id: item.id,
                    itemName: item.itemName,
                    itemPrice: item.itemPrice,
                    brandName: item.brandName,
                    productCategory: item.productCategory,
                    productDescription: item.productDescription,
                    imageUrl: item.imageUrl,
                    aisleNumber: item.aisleNumber,
                    nutritionFacts: item.nutritionFacts
                )
            }
    }
}
