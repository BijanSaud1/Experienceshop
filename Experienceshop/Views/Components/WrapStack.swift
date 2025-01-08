//
//  WrapStack.swift
//  Experienceshop
//
//  Created by Bijan Saud on 1/4/25.
//

import SwiftUI

struct WrapHStack: View {
    let items: [String]
    @Binding var selectedItems: [String]

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(items.chunked(into: 3), id: \.self) { rowItems in
                HStack {
                    ForEach(rowItems, id: \.self) { item in
                        Button(action: {
                            if selectedItems.contains(item) {
                                selectedItems.removeAll { $0 == item }
                            } else {
                                selectedItems.append(item)
                            }
                        }) {
                            Text(item)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(selectedItems.contains(item) ? Color.pink : Color.gray.opacity(0.2))
                                )
                                .foregroundColor(selectedItems.contains(item) ? .white : .black)
                        }
                    }
                }
            }
        }
    }
}

// Chunk extension
extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}
