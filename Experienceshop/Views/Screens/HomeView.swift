import SwiftUI

struct HomeView: View {
    @State private var currentPage: Int = 0
    @State private var showSettingsPage: Bool = false // Boolean to navigate to the settings page
    let pages = [
        "Welcome to Your Grocery Shopping Experience!",
        "Change your grocery shopping experience, save time and money!",
        "Get started by setting your budget and dietary preferences.",
        "Before you begin, add your dietary preferences and allergies!"
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Text(pages[currentPage])
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                // Page navigation controls (dots)
                HStack {
                    ForEach(0..<pages.count, id: \.self) { index in
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(currentPage == index ? .green : .gray)
                            .padding(5)
                    }
                }
                
                // Buttons for next and previous page
                HStack {
                    Button(action: {
                        if currentPage > 0 {
                            currentPage -= 1
                        }
                    }) {
                        Image(systemName: "arrow.left.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.green)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        if currentPage < pages.count - 1 {
                            currentPage += 1
                        } else {
                            // Navigate to the settings page when the final page is reached
                            showSettingsPage = true
                        }
                    }) {
                        Image(systemName: "arrow.right.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.green)
                    }
                }
                .padding()
                
                // Show "Finish" button on the last page
                if currentPage == pages.count - 1 {
                    NavigationLink(destination: SettingsPage(), isActive: $showSettingsPage) {
                        Text("Get Started")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
            }
            .navigationBarTitle("Welcome", displayMode: .inline)
            .padding()
        }
    }
}

struct SettingsPage: View {
    @State private var selectedDiets: [String] = []
    @State private var selectedAllergies: [String] = []
    let diets = ["Vegan", "Vegetarian", "Gluten-Free", "Paleo", "Keto"]
    let allergies = ["Peanuts", "Tree Nuts", "Dairy", "Eggs", "Soy", "Wheat", "Fish", "Shellfish"]

    var body: some View {
        VStack {
            Text("Before you begin, add your dietary preferences and allergies!")
                .font(.title2)
                .fontWeight(.bold)
                .padding()

            // Dietary Preferences Section
            Text("Dietary Preferences")
                .font(.headline)
                .padding(.top)
            WrapHStack(items: diets, selectedItems: $selectedDiets)
            
            // Allergies Section
            Text("Allergies")
                .font(.headline)
                .padding(.top)
            WrapHStack(items: allergies, selectedItems: $selectedAllergies)
            
            Spacer()
            
            // Save Button to move forward in the app
            Button(action: {
                // Handle the user's selections and move forward
                print("Dietary Preferences: \(selectedDiets)")
                print("Allergies: \(selectedAllergies)")
            }) {
                Text("Save Preferences")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
        }
        .padding()
        .navigationBarTitle("Settings", displayMode: .inline)
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
