//
//  IpodScreen.swift
//  ipod-clone
//
//  Created by Bartek on 02/03/2026.
//

import SwiftUI

struct IpodScreen: View {
    @EnvironmentObject var vm: IpodViewModel

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(Color(.ipodScreenGlass))


            screenContent
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.ipodScreenGlass), lineWidth: 4)
        )
        .padding(.horizontal, 12)
        .padding(.vertical, 24)
    }

    @ViewBuilder
    private var screenContent: some View {
        switch vm.currentScreen {
        case .menu:
            MenuScreenView()

        case .library:
            LibraryScreenView()

        case .player(let trackId):
            if let track = vm.tracks.first(where: { $0.id == trackId }) {
                NowPlayingScreenView(track: track)
            } else {
                Text("Track not found")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

#Preview {
    IpodScreenPreview()
}

private struct IpodScreenPreview: View {
    var body: some View {
        IpodScreen()
            .environmentObject(previewVM)
    }

    private var previewVM: IpodViewModel {
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

        vm.navigationStack = [.player(trackId: track.id)]
        return vm
    }
}
