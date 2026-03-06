//
//  TrackRow.swift
//  ipod-clone
//
//  Created by Bartek on 05/03/2026.
//

import SwiftUI

struct TrackRow: View {
    let track: Track
    let isSelected: Bool
    var body: some View {
        ListRow(title: track.title, subtitle: track.artist, leadingImage: track.image, isSelected: isSelected) {
            Text(track.formattedDuration)
        }
    }
}

#Preview {
    let example = Track(
        id: UUID(),
        title: "fml .",
        artist: "fakemink",
        albumTitle: "The Boy who cried Terrified.",
        duration: 163,
        image: "placeholder"
    )
    TrackRow(track: example, isSelected: true)
}
