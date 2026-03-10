//
//  DataModel.swift
//  ipod-clone
//
//  Created by Bartek on 03/03/2026.
//

import Foundation


struct Track: Identifiable, Equatable, Decodable {
    var id: UUID /// in this case this field is UI identity
    var title: String
    var artist: String
    var album: String
    var duration: TimeInterval
    var image: String
    var fileName: String /// track identity

    var formattedDuration: String {
        let durationInt = Int(duration.rounded())
        let minutes = durationInt / 60
        let seconds = durationInt % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct Album: Identifiable, Equatable {
    var id: UUID
    var title: String
    var image: String
}

struct Artist: Identifiable, Equatable {
    var id: UUID
    var name: String
}

struct PlayerState {
    var currentTrackFileName: String
    var isPlaying: Bool
    var progress: TimeInterval
    var mode: PlayingMode
}

struct MenuItem: Identifiable {
    var id: UUID
    var title: String
    var destination: Screen
}

enum Screen {
    case library(selectedIndex: Int)
//    case menu(selectedIndex: Int)
    case player(trackFileName: String)
}

enum PlayingMode: Equatable {
    case shuffle
    case queue
}
