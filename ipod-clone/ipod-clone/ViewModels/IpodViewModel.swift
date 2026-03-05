//
//  IpodViewModel.swift
//  ipod-clone
//
//  Created by Bartek on 03/03/2026.
//

import Combine
import Foundation

// routing+vm

class IpodViewModel: ObservableObject {
    @Published var navigationStack: [Screen] = [.menu(selectedIndex: 0)]
    @Published var tracks: [Track]
    @Published var playerState: PlayerState
    let menuItems: [MenuItem]

    init(tracks: [Track], playerState: PlayerState, menuItems: [MenuItem]) {
        self.tracks = tracks
        self.playerState = playerState
        self.menuItems = menuItems
    }

    var currentScreen: Screen {
        navigationStack.last ?? .menu(selectedIndex: 0)
    }

    /// func to handle routing
    func handleRotate(delta: Int) {
        guard !navigationStack.isEmpty else { return }

        switch currentScreen {
        case let .library(selectedIndex):
            guard !tracks.isEmpty else { return }
            let newIndex = selectedIndex + delta
            let clampedIndex = min(max(0, newIndex), tracks.count - 1)
            navigationStack[navigationStack.count - 1] = .library(selectedIndex: clampedIndex)

        case let .menu(selectedIndex):
            guard !menuItems.isEmpty else { return }
            let newIndex = selectedIndex + delta
            let clampedIndex = min(max(0, newIndex), menuItems.count - 1)
            navigationStack[navigationStack.count - 1] = .menu(selectedIndex: clampedIndex)

        case .player:
            break
        }
    }

    func handleSelect() {
        switch currentScreen {
        case let .menu(selectedIndex: index):
            guard menuItems.indices.contains(index) else { return }
            let destination = menuItems[index].destination
            navigationStack.append(destination)

        case let .library(selectedIndex: index):
            guard tracks.indices.contains(index) else { return }
            let trackId = tracks[index].id
            playerState.currentTrackId = trackId
            playerState.isPlaying = true
            playerState.progress = 0.0
            navigationStack.append(.player(trackId: trackId))

        case .player:
            break
        }
    }

    func handleMenu() {
        if navigationStack.count > 1 {
            navigationStack.removeLast()
        }
    }
}
