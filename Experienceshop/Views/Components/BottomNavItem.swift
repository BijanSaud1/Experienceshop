//
//  BottomNavItem.swift
//  Experienceshop
//
//  Created by Bijan Saud on 1/3/25.
//


import SwiftUI

struct BottomNavItem: View {
    let icon: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? Color.green : Color.white)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

