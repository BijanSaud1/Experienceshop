import SwiftUI

struct CartContentView: View {
    // State variables
    @State private var budget: Double = 290
    @State private var selectedDiets: [String] = []
    @State private var selectedAllergies: [String] = []
    @State private var selectedValues: [String] = []
    @State private var isLoading: Bool = false        // Loading spinner state
    @State private var generatedList: [String] = []  // Holds the AI-generated list
    @State private var showResults: Bool = false     // Toggles the results view

    // Data arrays
    let diets = ["Mediterranean", "Keto", "Paleo", "Vegan", "Vegetarian", "Gluten Free", "Pescatarian", "No Added Sugar"]
    let allergies = ["Peanuts", "Tree Nuts", "Shellfish", "Fish", "Dairy", "Eggs", "Wheat", "Soy", "Tomato", "Melon", "Sesame", "Mustard", "Celery", "Almonds", "Corn", "Gelatin", "Stevia", "Chia"]
    let foodValues = [
        "Nutrition": "Maintain a healthy balanced diet",
        "Processing": "Less artificial ingredients and additives",
        "Food Safety": "Avoid harmful chemicals and toxicants",
        "Environment": "Fight Climate change. Avoid products that harm the planet",
        "Ethics": "Support fair labor practices and animal welfare"
    ]

    var body: some View {
        NavigationView {
            ZStack {
                // Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.3)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    // Grocery List Section
                    if !generatedList.isEmpty {
                        VStack(alignment: .leading) {
                            Text("Your Grocery List")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.pink)
                                .padding(.bottom, 5)

                            List(generatedList, id: \.self) { item in
                                Text(item)
                                    .font(.headline)
                            }
                            .frame(maxHeight: 200) // Limit height of the list
                            .listStyle(PlainListStyle())
                            .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }

                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            // Budget Slider
                            sectionHeader(title: "Select your budget")
                            VStack {
                                Slider(value: $budget, in: 50...500, step: 10)
                                    .accentColor(.pink)
                                    .padding()
                                Text("$\(Int(budget))")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.pink)
                            }
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color.white).shadow(radius: 5))
                            .padding()

                            // Diet Preferences
                            sectionHeader(title: "How do you want to eat?")
                            WrapHStack(items: diets, selectedItems: $selectedDiets)

                            // Allergies
                            sectionHeader(title: "Do you have any allergies?")
                            WrapHStack(items: allergies, selectedItems: $selectedAllergies)

                            // Food Values
                            sectionHeader(title: "What are some of your values in regard to food?")
                            ForEach(foodValues.keys.sorted(), id: \.self) { key in
                                HStack {
                                    Text(key)
                                        .font(.headline)
                                    Spacer()
                                    Text(foodValues[key]!)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Toggle("", isOn: Binding(
                                        get: { selectedValues.contains(key) },
                                        set: { isSelected in
                                            if isSelected {
                                                selectedValues.append(key)
                                            } else {
                                                selectedValues.removeAll { $0 == key }
                                            }
                                        }
                                    ))
                                    .labelsHidden()
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 5))
                                .padding(.horizontal)
                            }
                        }
                    }

                    // Submit Button
                    Button(action: submitPreferences) {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .padding()
                        } else {
                            Text("Submit")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.pink, Color.purple]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(15)
                                .shadow(radius: 5)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
            .navigationBarTitle("Grocery List", displayMode: .inline)
        }
    }

    // Submit action
    func submitPreferences() {
        isLoading = true
        let preferences = [
            "budget": budget,
            "diets": selectedDiets,
            "allergies": selectedAllergies,
            "values": selectedValues
        ] as [String: Any]

        // Simulate AI processing
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            // Replace this with actual AI/ML backend logic
            let simulatedList = ["Broccoli", "Chicken Breast", "Almond Milk", "Quinoa", "Spinach"]

            DispatchQueue.main.async {
                self.generatedList = simulatedList
                self.isLoading = false
            }
        }
    }

    // Section Header
    func sectionHeader(title: String) -> some View {
        Text(title)
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundColor(.black)
            .padding(.horizontal)
    }
}

// WrapHStack for Chips
struct WrapHStack: View {
    let items: [String]
    @Binding var selectedItems: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(items.chunked(into: 3), id: \.self) { rowItems in
                HStack(spacing: 10) {
                    ForEach(rowItems, id: \.self) { item in
                        Button(action: {
                            if selectedItems.contains(item) {
                                selectedItems.removeAll { $0 == item }
                            } else {
                                selectedItems.append(item)
                            }
                        }) {
                            Text(item)
                                .font(.subheadline)
                                .padding()
                                .frame(minWidth: 80)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(selectedItems.contains(item) ? Color.pink : Color.white)
                                        .shadow(radius: 3)
                                )
                                .foregroundColor(selectedItems.contains(item) ? .white : .black)
                        }
                        .animation(.easeInOut, value: selectedItems)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

// Extension to Chunk Arrays into Rows
extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}
