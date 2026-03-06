//
//  BasicRow.swift
//  ipod-clone
//
//  Created by Bartek on 05/03/2026.
//

import SwiftUI

struct BasicRow: View {
    let item: MenuItem
    var isSelected: Bool
    var body: some View {
        ListRow(title: item.title, subtitle: nil, leadingImage: nil, isSelected: isSelected) {
            Button {} label: {
                Image(systemName: "chevron.right")
            }
        }
    }
}

#Preview {
    let example = MenuItem(
        id: UUID(),
        title: "Library",
        destination: .library(selectedIndex: 1)
    )
    BasicRow(item: example, isSelected: true)
}
