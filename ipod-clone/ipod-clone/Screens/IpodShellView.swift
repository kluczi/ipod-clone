//
//  IpodShellView.swift
//  ipod-clone
//
//  Created by Bartek on 02/03/2026.
//

import SwiftUI

struct IpodShellView: View {
    @EnvironmentObject var vm: IpodViewModel

    var body: some View {
        ZStack {
            IpodFrame()
            VStack {
                IpodScreen()
                Spacer()
                ClickWheel()
            }
        }
    }
}

#Preview {
    let track = Track(
        id: UUID(),
        title: "Good Days",
        artist: "SZA",
        albumTitle: "SOS",
        duration: 163,
        image: "placeholder2"
    )

    let vm = IpodViewModel(
        tracks: [track],
        playerState: PlayerState(
            currentTrackId: track.id,
            isPlaying: true,
            progress: 16
        ),
        menuItems: []
    )

    IpodShellView()
        .environmentObject(vm)
        .onAppear {
            vm.navigationStack = [.player(trackId: track.id)]
        }
}
