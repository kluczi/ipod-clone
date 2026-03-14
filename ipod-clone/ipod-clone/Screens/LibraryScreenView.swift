//
//  LibraryScreenView.swift
//  ipod-clone
//
//  Created by Bartek on 02/03/2026.
//

import SwiftUI

struct LibraryScreenView: View {
    @EnvironmentObject var vm: IpodViewModel

    var selectedIndex: Int {
        if case .library(let index) = vm.currentScreen {
            return index
        }
        return 0
    }

    var body: some View {
        let visibleTracksCount = 4
        let startIndex = max(0, min(selectedIndex - 3, vm.tracks.count - visibleTracksCount))
        let endIndex = min(vm.tracks.count, startIndex + visibleTracksCount)
        let visibleTracks = Array(vm.tracks[startIndex..<endIndex])

        GeometryReader { geo in
            let rowHeight = geo.size.height / CGFloat(visibleTracksCount)

            VStack(spacing: 0) {
                ForEach(Array(visibleTracks.enumerated()), id: \.element.id) { offset, track in
                    let realIndex = startIndex + offset

                    TrackRow(track: track, isSelected: realIndex == selectedIndex)
                        .frame(height: rowHeight, alignment: .leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }
}

#Preview {
    LibraryScreenView()
        .environmentObject(IpodViewModel())
}
