import SwiftUI

struct HomeContentView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text("Transform how you shop")
                .font(.title2)
                .foregroundColor(.white)
                .padding()

            VStack(spacing: 15) {
                SavingsCardView(
                    title: "Total Saved",
                    value: viewModel.totalSavings,
                    iconName: "dollarsign.circle",
                    iconColor: .green
                )
                SavingsCardView(
                    title: "Time Saved",
                    value: viewModel.totalTimeSaved,
                    iconName: "hourglass",
                    iconColor: .blue
                )
            }
            .padding(.horizontal, 20)

            Spacer()
        }
        .onAppear {
            viewModel.fetchUserStats(userId: "exampleUserId") // Replace with actual userId
        }
    }
}

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview with mock data for HomeViewModel
        HomeContentView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.light) // Change to .dark for dark mode
            .environmentObject(HomeViewModel()) // Providing environment object for the preview
    }
}
