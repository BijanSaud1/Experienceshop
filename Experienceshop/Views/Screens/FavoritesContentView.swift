//
//  FavoritesView.swift
//  Experienceshop
//
//  Created by Bijan Saud on 1/3/25.
//
import SwiftUI

struct FavoritesContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.purple, Color.pink]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)

            VStack {
                Text("Favorites Page")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Spacer()
            }
        }

    }
}
