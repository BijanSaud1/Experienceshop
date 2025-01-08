import SwiftUI


struct MainView: View {
    @State private var selectedTab: Tab = .home

       var body: some View {
           CustomLayoutView(
               selectedTab: selectedTab,
               onTabSelected: { tab in
                   selectedTab = tab
               }
           ) {
               // Render content based on selected tab
               switch selectedTab {
               case .home:
                   HomeContentView()
               case .cart:
                   CartContentView()
               case .activity:
                   ActivityContentView()
               case .favorites:
                   FavoritesContentView()
               case .settings:
                   SettingsView()
               }
            
        }
    }
}

