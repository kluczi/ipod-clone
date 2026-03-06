//
//  AudioRouteModel.swift
//  ipod-clone
//
//  Created by Bartek on 06/03/2026.
//

import AVFAudio
import SwiftUI
import Combine

final class AudioRouteModel: ObservableObject {
    @Published var deviceName: String = "Unknown"
    @Published var deviceIcon: String = "speaker.wave.2"

    init() {
        updateRoute()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(routeChanged),
            name: AVAudioSession.routeChangeNotification,
            object: nil
        )
    }

    @objc private func routeChanged(_ notification: Notification) {
        updateRoute()
    }

    private func updateRoute() {
        guard let output = AVAudioSession.sharedInstance().currentRoute.outputs.first else { return }

        deviceName = output.portName

        let name = output.portName.lowercased()

        if name.contains("airpods max") {
            deviceIcon = "airpodsmax"
        } else if name.contains("airpods") {
            deviceIcon = "airpodspro"
        } else if output.portType == .headphones {
            deviceIcon = "headphones"
        } else {
            deviceIcon = "ipod"
        }
    }
}
