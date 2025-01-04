//
//  HomeViewModel.swift
//  Experienceshop
//
//  Created by Bijan Saud on 1/4/25.
//
import SwiftUI
class HomeViewModel: ObservableObject {
    @Published var totalSavings: String = "$0"
    @Published var totalTimeSaved: String = "0 hrs"

    func fetchUserStats(userId: String) {
        // Simulate a backend fetch
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Replace with actual backend call
            self.totalSavings = "$410"
            self.totalTimeSaved = "15 hrs"
        }
    }
}
