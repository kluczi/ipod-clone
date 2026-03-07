//
//  PlaybackService.swift
//  ipod-clone
//
//  Created by Bartek on 06/03/2026.
//

import AVFoundation
import Combine


final class PlaybackService {
    private var player: AVPlayer
    private var timeObserver: Any?

    init() {
        self.player=AVPlayer()
        configureAudioSession()
    }
    
    private func configureAudioSession() {
            let session=AVAudioSession.sharedInstance()
            try? session.setCategory(.playback, mode: .default)
            try? session.setActive(true)
    }
    
    func load(track: Track) {
        guard let url = Bundle.main.url(forResource: track.fileName, withExtension: "mp3") else {return}
        let item = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: item)
    }
    
    func play() {
        player.play()
    }
    
    func pause() {
        player.pause()
    }
    
    func currentTime() -> TimeInterval {
        player.currentTime().seconds
    }
    
    func startTimeObserver(onUpdate: @escaping (TimeInterval) -> Void) {
        let interval = CMTime(seconds: 0.25, preferredTimescale: CMTimeScale(NSEC_PER_SEC))

        timeObserver = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { time in
            let seconds = time.seconds
            onUpdate(seconds)
        }
    }
    
    func stopTimeObserver() {
        if let observer = timeObserver {
            player.removeTimeObserver(observer)
            timeObserver = nil
        }
    }
    
    
}
