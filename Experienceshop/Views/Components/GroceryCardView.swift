import SwiftUI

struct GroceryCardView: View {
    let item: GroceryItem

    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            // Item Image
            AsyncImage(url: URL(string: item.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
                    .frame(width: 80, height: 80)
            }

            // Item Details
            VStack(alignment: .leading, spacing: 5) {
                // Item Name
                Text(item.itemName)
                    .font(.headline)
                    .fontWeight(.bold)

                // Brand Name
                Text(item.brandName)
                    .font(.subheadline)
                    .foregroundColor(.blue)

                // Product Category
                Text(item.productCategory)
                    .font(.caption)
                    .foregroundColor(.gray)

                // Description
                Text(item.productDescription)
                    .font(.caption)
                    .lineLimit(2)
                    .foregroundColor(.secondary)

                // Aisle
                Text("Aisle: \(item.aisleNumber)")
                    .font(.caption2)
                    .foregroundColor(.secondary)

                // Price and Calories
                HStack {
                    Text("$\(String(format: "%.2f", item.itemPrice))")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.pink)

                    Spacer()

                    Text("Calories: \(item.nutritionFacts.caloriesPerServing)")
                        .font(.caption)
                        .foregroundColor(.green)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(radius: 5)
        )
        .padding(.horizontal)
    }
}
