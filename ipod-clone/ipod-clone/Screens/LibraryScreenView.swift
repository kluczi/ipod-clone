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
        VStack (spacing: 0) {
            ForEach(vm.tracks.indices, id: \.self) { index in
                if(selectedIndex==index) {
                    TrackRow(track: vm.tracks[index], isSelected: true)
                } else {
                    TrackRow(track: vm.tracks[index], isSelected: false)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    LibraryScreenView()
        .environmentObject(IpodViewModel())
}
