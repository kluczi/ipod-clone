//
//  ClickWheel.swift
//  ipod-clone
//
//  Created by Bartek on 02/03/2026.
//

import SwiftUI

struct ClickWheel: View {
    private let ringThickness: CGFloat = 28
    var body: some View {
        GeometryReader { geo in
            let d = min(geo.size.width, geo.size.height)

            ZStack {
                Circle()
                    .fill(Color(.ipodWheel))
                    .frame(width: d - ringThickness * 2, height: d - ringThickness * 2)

                Button {
                    print("main")
                } label: {
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    Color("ipodBodyUpperMid"),
                                    Color("ipodBodyBase"),
                                    Color("ipodBodyBottom"),
                                ],
                                center: .center,
                                startRadius: 6,
                                endRadius: 80
                            )
                        )
                        .stroke(Color(.ipodScreenGlass), lineWidth: 0.35)
                        .overlay(
                            Circle()
                                .stroke(Color.black.opacity(0.35), lineWidth: 1)
                        )
                        .overlay(
                            Circle()
                                .fill(
                                    RadialGradient(
                                        colors: [
                                            Color.white.opacity(0.1),
                                            Color.clear,
                                        ],
                                        center: .init(x: 0.5, y: 0.25),
                                        startRadius: 5,
                                        endRadius: 60
                                    )
                                )
                        )
                        .frame(width: d * 0.32, height: d * 0.32)
                }

                wheelButtons(diameter: d)
            }
            .frame(width: d, height: d)
            .position(x: geo.size.width / 2, y: geo.size.height / 2)
        }
        .aspectRatio(1, contentMode: .fit)
    }

    @ViewBuilder
    private func wheelButtons(diameter d: CGFloat) -> some View {
        let inset = d * 0.12
        ZStack {
            Button {
                print("menu")
            } label: {
                Image(systemName: "square.grid.2x2")
                    .font(.system(size: d * 0.06, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color(.ipodWheelText))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .padding(.top, inset)
            }
            .buttonStyle(.plain)

            Button {
                print("pause")
            } label: {
                Image(systemName: "playpause.fill")
                    .font(.system(size: d * 0.06, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color(.ipodWheelText))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, inset)
            }
            .buttonStyle(.plain)

            Button {
                print("next")
            } label: {
                Image(systemName: "backward.end.alt.fill")
                    .font(.system(size: d * 0.06, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color(.ipodWheelText))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(.leading, inset)
            }
            .buttonStyle(.plain)

            Button {
                print("last")
            } label: {
                Image(systemName: "forward.end.alt.fill")
                    .font(.system(size: d * 0.06, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color(.ipodWheelText))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                    .padding(.trailing, inset)
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    ClickWheel()
}
