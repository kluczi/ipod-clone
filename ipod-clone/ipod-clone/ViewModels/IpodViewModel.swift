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
    @Published var libraryService: LibraryService
    @Published var playbackService: PlaybackService
    @Published var navigationStack: [Screen]
    @Published var tracks: [Track]
    @Published var playerState: PlayerState
    

    let menuItems: [MenuItem]

    init() {
        let libraryService = LibraryService()
        let tracks = libraryService.loadTracks(fileName: "tracks")
        self.libraryService = libraryService
        self.playbackService = PlaybackService()
        self.navigationStack = [.library(selectedIndex: 0)]
        self.playerState = PlayerState(currentTrackFileName: "", isPlaying: false, progress: 0)
        self.menuItems = []
        self.tracks = tracks

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

    func indexOfCurrentTrack(trackFileName: String) -> Int? {
        guard let trackIndex = tracks.firstIndex(where: {$0.fileName==trackFileName}) else { return nil }
        return trackIndex
    }
    
    func handleSelect() {
        switch currentScreen {
        case let .menu(selectedIndex: index):
            guard menuItems.indices.contains(index) else { return }
            let destination = menuItems[index].destination
            navigationStack.append(destination)
            
        case let .library(selectedIndex: index):
            guard tracks.indices.contains(index) else { return }
            let trackName = tracks[index].fileName
            /// checking wheter selected track is different from current playing track
            if(trackName != playerState.currentTrackFileName) {
                playbackService.load(track: tracks[index])
                playerState.currentTrackFileName = trackName
                playerState.isPlaying = true
                playerState.progress = 0.0
                playbackService.play()
                playbackService.startTimeObserver { time in
                    self.playerState.progress=time
                }
            } else if (trackName == playerState.currentTrackFileName) {
                playbackService.play()
            }
            navigationStack[navigationStack.count - 1] = .player(trackFileName: trackName)
        case .player:
            break
        }
    }
    
    func handleLibrary() {
        if(playerState.isPlaying) {
            playbackService.pause()
            playerState.isPlaying = false
        }
        playerState.currentTrackFileName = ""
        playerState.progress = 0
        navigationStack[navigationStack.count - 1] = .library(selectedIndex: 0)
        
    }
    
    func handleNext() {
        switch currentScreen {
        case .library(let selectedIndex):
            let newIndex = selectedIndex+1
            if(newIndex < tracks.count) {
                navigationStack[navigationStack.count - 1] = .library(selectedIndex: newIndex)
            }
        case .player(let trackFileName):
            guard let currentIndex = indexOfCurrentTrack(trackFileName: trackFileName) else { return }
            let newIndex = currentIndex+1
            playerState.currentTrackFileName = tracks[newIndex].fileName
            playerState.progress=0
            playbackService.load(track: tracks[newIndex])
            navigationStack[navigationStack.count - 1] = .player(trackFileName: playerState.currentTrackFileName)
        case .menu(selectedIndex: _):
            break
        }
    }
    
    func handlePrevious() {
        switch currentScreen {
        case .library(let selectedIndex):
            let newIndex = selectedIndex-1
            if(newIndex < 0) {
                navigationStack[navigationStack.count - 1] = .library(selectedIndex: selectedIndex)
            } else {
                navigationStack[navigationStack.count - 1] = .library(selectedIndex: newIndex)
            }
        case .player(let trackFileName):
            guard let currentIndex = indexOfCurrentTrack(trackFileName: trackFileName) else { return }
            let newIndex = currentIndex-1
            if(newIndex >= 0) {
                if(playerState.progress <= 3) {
                    playerState.currentTrackFileName = tracks[newIndex].fileName
                    playerState.progress=0
                    playbackService.load(track: tracks[newIndex])
                    navigationStack[navigationStack.count - 1] = .player(trackFileName: playerState.currentTrackFileName)
                } else {
                    playerState.progress=0
                    playbackService.load(track: tracks[currentIndex])
                }
            } else if (newIndex < 0) {
                playerState.progress=0
                playbackService.load(track: tracks[0])
            }
            
        case .menu(selectedIndex: _):
            break
        }
    }
    
    func handlePlayPause() {
        if(playerState.isPlaying) {
            playerState.isPlaying=false
            playbackService.pause()
        } else {
            playerState.isPlaying=true
            playbackService.play()
        }
    }
    
    func updateProgress() {
        playerState.progress=playbackService.currentTime()
    }

    func handleMenu() {
        if navigationStack.count > 1 {
            navigationStack.removeLast()
        }
    }
}
