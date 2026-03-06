//
//  ListRow.swift
//  ipod-clone
//
//  Created by Bartek on 02/03/2026.
//

import SwiftUI

struct ListRow<Trailing: View>: View {
    let title: String
    let subtitle: String?
    let leadingImage: String?
    let isSelected: Bool
    @ViewBuilder let trailing: () -> Trailing

    var titleColor: Color {
        isSelected ? .titleSelected : .titlePrimary
    }

    var subtitleColor: Color {
        isSelected ? .subTitleSelected : .subTitlePrimary
    }

    var backgroundColor: Color {
        isSelected ? .rowBackgroundSelected : .rowBackground
    }

    var body: some View {
        HStack {
            if let leadingImage {
                Image(leadingImage)
                    .resizable()
                    .frame(width: 64, height: 64)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }

            VStack(alignment: .leading) {
                Text(title)
                    .foregroundStyle(titleColor)
                    .fontWeight(.bold)
                if let subtitle {
                    Text(subtitle)
                        .foregroundStyle(subtitleColor)
                }
            }
            Spacer()
            trailing()
                .foregroundStyle(titleColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(backgroundColor)
    }
}

#Preview {
    ListRow(title: "fml .", subtitle: "fakemink", leadingImage: "placeholder", isSelected: false) {}
}
