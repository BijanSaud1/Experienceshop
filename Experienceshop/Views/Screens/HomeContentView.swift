//
//  HomeContentView.swift
//  Experienceshop
//
//  Created by Bijan Saud on 1/3/25.
//
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
