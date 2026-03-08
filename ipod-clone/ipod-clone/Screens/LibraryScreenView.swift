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
        let visibleTracksCount=4
        let startIndex=max(0,min(selectedIndex-3, vm.tracks.count-visibleTracksCount))
        let endIndex=min(vm.tracks.count, startIndex+visibleTracksCount)
        let visibleTracks = Array(vm.tracks[startIndex ..< endIndex])
        
        //showing only 4 tracks on the screen
        VStack (spacing: 0) {
            ForEach(Array(visibleTracks.enumerated()), id: \.element.id) { offset, track in
                let realIndex=startIndex+offset
                TrackRow(track: track, isSelected: realIndex==selectedIndex)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    LibraryScreenView()
        .environmentObject(IpodViewModel())
}
