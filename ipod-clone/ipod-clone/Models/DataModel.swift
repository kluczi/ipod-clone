//
//  DataModel.swift
//  ipod-clone
//
//  Created by Bartek on 03/03/2026.
//

import Foundation


struct Track: Identifiable, Equatable {
    var id: UUID
    var title: String
    var artist: String
    var albumTitle: String
    var duration: TimeInterval
    
    
    var formattedDuration: String {
        let durationInt = Int(self.duration.rounded())
        let minutes = durationInt / 60
        let seconds = durationInt % 60
        let durationString = String(format: "%02d:%02d", minutes, seconds)
        return durationString
    }
}

struct PlayerState {
    var currentTrackId: UUID?
    var isPlaying: Bool
    var progress: TimeInterval
    
}

struct MenuItem:Identifiable {
    var id: UUID
    var title: String
    var destination: Screen
}

enum Screen {
    case library(selectedIndex: Int)
    case menu(selectedIndex: Int)
    case player(trackId: UUID)
}
