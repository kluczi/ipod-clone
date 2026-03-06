//
//  NowPlayingScreenView.swift
//  ipod-clone
//
//  Created by Bartek on 02/03/2026.
//

import SwiftUI
import Combine

struct NowPlayingScreenView: View {
    let track: Track
    @State var progress: Double = 16 // in sec
    
    var formattedProgress: String {
        let minutes = Int(progress.rounded()) / 60
        let seconds = Int(progress.rounded()) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    var timeLeft: String {
        let minutesDuration = Int(track.duration.rounded()) / 60
        let secondsDuration = Int(track.duration.rounded()) % 60
        let minutesProgress = Int(progress.rounded()) / 60
        let secondsProgress = Int(progress.rounded()) % 60

        let minutesLeft = minutesDuration - minutesProgress
        let secondsLeft = secondsDuration - secondsProgress

        return String(format: "- %02d:%02d", minutesLeft, secondsLeft)
    }

    var fraction: Double {
        guard track.duration > 0 else { return 0 }
        return min(max(progress / track.duration, 0), 1)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            TrackMetaData(title: track.title, artist: track.artist, album: track.albumTitle, art: track.image)

            ProgressBar(progress: $progress, fraction: fraction, formattedProgress: formattedProgress, timeLeft: timeLeft)
            
            Details()
        }
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background {
            Image(track.image)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: 60)
            Rectangle()
                .fill(.black.opacity(0.18))
                .ignoresSafeArea()
        }
    }
}

private struct ProgressBar: View {
    @Binding var progress: Double
    var fraction: Double
    var formattedProgress: String
    var timeLeft: String
    var body: some View {
        VStack (spacing: 12) {
            HStack {
                Text(formattedProgress)
                    .foregroundStyle(.tertiaryText)
                    .font(.system(size: 18, weight: .regular))
                Spacer()
                Text(timeLeft)
                    .foregroundStyle(.tertiaryText)
                    .font(.system(size: 18, weight: .regular))
            }

            GeometryReader { geometry in
                let width = geometry.size.width
                let barHeight = 6.0
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: barHeight / 2)
                        .fill(.white.opacity(0.18))
                        .frame(width: width, height: barHeight)
                    UnevenRoundedRectangle(topLeadingRadius: barHeight / 2, bottomLeadingRadius: barHeight / 2)
                        .fill(.tertiaryText)
                        .frame(width: width * fraction, height: barHeight)
                        .animation(.linear(duration: 0.11), value: fraction)
                }
                .frame(width: geometry.size.width, height: barHeight, alignment: .leading)
            }
            .frame(height: 6)
            .clipped()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct BlendedArtwork: View {
    let art: String

    var body: some View {
        ZStack {
            Image(art)
                .resizable()
                .scaledToFill()
                .frame(width: 196, height: 196)
                .blur(radius: 28)
                .scaleEffect(1.15)
                .opacity(0.45)
            Image(art)
                .resizable()
                .scaledToFill()
                .frame(width: 196, height: 196)
                .clipShape(Rectangle())
        }
        .frame(width: 196, height: 196)
    }
}

private struct TrackMetaData: View {
    var title: String
    var artist: String
    var album: String
    var art: String

    var body: some View {
        HStack (alignment: .top, spacing: 16) {
                BlendedArtwork(art: art)

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundStyle(.primaryText)
                        .lineLimit(1)
                    Text(artist)
                        .font(.system(size: 22, weight: .regular))
                        .foregroundStyle(.secondaryText)
                        .lineLimit(1)
                    Text(album)
                        .font(.system(size: 22, weight: .regular))
                        .foregroundStyle(.tertiaryText)
                        .lineLimit(2)
                }
                .padding(.vertical, 12)
            }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 6)
    }
}

private struct Details: View {
    @StateObject var audioRoute = AudioRouteModel()
    var body: some View {
        HStack {
            Image(systemName: audioRoute.deviceIcon)
                .foregroundStyle(.tertiaryText)
                .font(.system(size: 18, weight: .regular))

            Text(audioRoute.deviceName)
                .foregroundStyle(.tertiaryText)
                .font(.system(size: 18, weight: .regular))

        }
    }
}




#Preview {
    let example = Track(
        id: UUID(),
        title: "fml .",
        artist: "fakemink",
        albumTitle: "The Boy who cried Terrified .",
        duration: 163,
        image: "placeholder"
    )
    
    let example2 = Track(
        id: UUID(),
        title: "Good Days",
        artist: "SZA",
        albumTitle: "SOS",
        duration: 163,
        image: "placeholder2"
    )
    NowPlayingScreenView(track: example2)
//    PreviewWrapper()
}


//private struct PreviewWrapper: View {
//    @State var progress: Double = 0
//
//    let timer = Timer.publish(every: 0.03, on: .main, in: .common).autoconnect()
//
//    let track = Track(
//        id: UUID(),
//        title: "Good Days",
//        artist: "SZA",
//        albumTitle: "SOS",
//        duration: 163,
//        image: "placeholder2"
//    )
//
//    var body: some View {
//        NowPlayingScreenView(track: track, progress: $progress)
//            .onReceive(timer) { _ in
//                progress += 0.03
//            }
//    }
//}
