//
//  SelectionView.swift
//  Experienceshop
//
//  Created by Bijan Saud on 1/4/25.
//


import SwiftUI

struct SelectionView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Make Your Selection")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            // Example options
            Button(action: {
                print("Option 1 Selected")
            }) {
                Text("Option 1")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
            }

            Button(action: {
                print("Option 2 Selected")
            }) {
                Text("Option 2")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
            }

            Spacer()
        }
        .background(LinearGradient(
            gradient: Gradient(colors: [Color.orange, Color.pink]),
            startPoint: .top,
            endPoint: .bottom
        ))
        .edgesIgnoringSafeArea(.all)
    }
}

