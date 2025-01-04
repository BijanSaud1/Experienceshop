import SwiftUI

struct CustomLayoutView<Content: View>: View {
    let content: Content
    let selectedTab: Tab
    let onTabSelected: (Tab) -> Void

    init(selectedTab: Tab, onTabSelected: @escaping (Tab) -> Void, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.selectedTab = selectedTab
        self.onTabSelected = onTabSelected
    }

    var body: some View {
        VStack(spacing: 0) {
            // Top Content Area
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Bottom Navigation Bar
            HStack {
                BottomNavItem(
                    icon: "house.fill",
                    isSelected: selectedTab == .home,
                    onTap: { onTabSelected(.home) }
                )
                BottomNavItem(
                    icon: "cart",
                    isSelected: selectedTab == .cart,
                    onTap: { onTabSelected(.cart) }
                )
                BottomNavItem(
                    icon: "arrow.2.circlepath",
                    isSelected: selectedTab == .activity,
                    onTap: { onTabSelected(.activity) }
                )
                BottomNavItem(
                    icon: "heart",
                    isSelected: selectedTab == .favorites,
                    onTap: { onTabSelected(.favorites) }
                )
                BottomNavItem(
                    icon: "person.circle.fill", // Icon for navigating to ContentView
                    isSelected: selectedTab == .settings,
                    onTap: { onTabSelected(.settings) }
                )
            }
            .frame(maxWidth: .infinity) // Ensures full width
            .frame(height: 70) // Set height for the navigation bar
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 0)) // Removes unnecessary rounding
        }
        .edgesIgnoringSafeArea(.bottom) // Prevents clipping at the bottom
    }
}

enum Tab {
    case home
    case cart
    case activity
    case favorites
    case settings // Replace .content with .settings for logout or app settings
}


