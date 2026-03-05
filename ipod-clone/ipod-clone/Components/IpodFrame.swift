//
//  IpodFrame.swift
//  ipod-clone
//
//  Created by Bartek on 02/03/2026.
//

import SwiftUI

struct IpodFrame: View {
    var body: some View {
        RadialGradient(
            colors: [
                Color("ipodBodyUpperMid"),
                Color("ipodBodyBase"),
                Color("ipodBodyBottom"),
            ],
            center: .init(x: 0.5, y: 0.35),
            startRadius: 30,
            endRadius: 450
        )
        .overlay(
            RadialGradient(
                colors: [
                    Color.white.opacity(0.1),
                    Color.clear,
                ],
                center: .top,
                startRadius: 20,
                endRadius: 350
            )
        )
        .ignoresSafeArea()
    }
}

#Preview {
    IpodFrame()
}
