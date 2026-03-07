//
//  LibraryService.swift
//  ipod-clone
//
//  Created by Bartek on 06/03/2026.
//

import Combine
import Foundation


struct TrackPayload: Decodable {
    var title: String
    var artist: String
    var album: String
    var duration: TimeInterval
    var image: String
    var fileName: String
}

final class LibraryService {
    
    func loadTrackPayloadsFromJSON(fileName: String) -> [TrackPayload] {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else { return []}
        let data = try? Data(contentsOf: url)
        let decoder = JSONDecoder()
        let tracks : [TrackPayload] = try! decoder.decode([TrackPayload].self, from: data!)
        return tracks
    }
    
    func mapPayloadToTrack(track: TrackPayload) -> Track {
        let id = UUID()
        return Track(id: id, title: track.title, artist: track.artist, album: track.album, duration: track.duration, image: track.image, fileName: track.fileName)
    }
    
    func loadTracks(fileName: String) -> [Track] {
        let loadedPayload = loadTrackPayloadsFromJSON(fileName: fileName)
        let tracks: [Track] = loadedPayload.map(mapPayloadToTrack)
        return tracks
    }
}
