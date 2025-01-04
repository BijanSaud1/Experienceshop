//
//  SavingCardView.swift
//  Experienceshop
//
//  Created by Bijan Saud on 1/4/25.
//

import SwiftUI

struct SavingsCardView: View {
    let title: String
    let value: String
    let iconName: String
    let iconColor: Color

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(value)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .overlay(
                        Text("^")
                            .foregroundColor(.green)
                            .offset(x: 5, y: -10),
                        alignment: .trailing
                    )
            }
            Spacer()
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(iconColor)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
    }
}
