//
//  IpodScreen.swift
//  ipod-clone
//
//  Created by Bartek on 02/03/2026.
//

import SwiftUI

struct IpodScreen: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundStyle(Color(.ipodScreenGlass))
            .padding(.horizontal, 16)
            .padding(.vertical, 32)
            .cornerRadius(12)
    }
}

#Preview {
    IpodScreen()
}
