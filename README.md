# iPod Modern Clone

Modern iPod-style music player built with **SwiftUI**, featuring a click wheel, library browser, and now-playing screen with animated transitions and shuffle/queue modes.
<div align="center">
  <img src="https://raw.githubusercontent.com/kluczi/ipod-clone/e4b915cce39993dd6a6ceba540775a0f5f7d694c/ipod_demo_1.png" width="30%" />
  <img src="https://raw.githubusercontent.com/kluczi/ipod-clone/e4b915cce39993dd6a6ceba540775a0f5f7d694c/ipod_demo_2.png" width="30%" />
</div>

## Features

- **iPod shell & click wheel**
  - Circular click wheel with center/select, menu, play/pause, previous/next
  - Wheel rotation drives selection in the library
- **Library screen**
  - List of tracks loaded from `tracks.json` in `Resources`
  - Large album artwork thumbnails
- **Now Playing screen**
  - Blended album art background and foreground card
  - Time-elapsed / time-left display and animated progress bar
  - Audio route indicator (e.g. device name and icon)
  - Shuffle / queue toggle with different behavior:
    - **Queue**: play next track in order
    - **Shuffle**: jump to a random different track excluding current playing track
- **Playback engine**
  - `PlaybackService` for play, pause, load, and time observation
  - `IpodViewModel` orchestrates navigation and player state with Combine and SwiftUI animations

## Project structure

```text
ipod-clone/
└─ ipod-clone/
   ├─ ipod_cloneApp.swift              # iOS app entry point
   ├─ ContentView.swift                # root SwiftUI view
   ├─ Components/
   │  ├─ IpodShellView.swift           # overall iPod layout (frame + screen + wheel)
   │  ├─ IpodFrame.swift               # device body
   │  ├─ IpodScreen.swift              # screen container
   │  ├─ ClickWheel.swift              # click wheel UI and gestures
   │  ├─ ListRow.swift                 # generic list row UI
   │  ├─ TrackRow.swift                # track list row UI
   │  ├─ TrackDetail.swift             # track detail UI
   │  └─ BasicRow.swift                # basic menu-style row UI
   ├─ Screens/
   │  ├─ LibraryScreenView.swift       # track list / library
   │  ├─ NowPlayingScreenView.swift    # now playing UI
   │  └─ MenuScreenView.swift          # legacy menu prototype (partially unused)
   ├─ Models/
   │  ├─ DataModel.swift               # data structures
   │  └─ AudioRouteModel.swift         # current audio route + icon/name
   ├─ Services/
   │  ├─ LibraryService.swift          # loads tracks from JSON
   │  └─ PlaybackService.swift         # AVFoundation-backed playback
   ├─ ViewModels/
   │  └─ IpodViewModel.swift           # routing, buttons handling, playback + shuffle/queue
   ├─ MockData/
   │  └─ MockData.swift                # sample/mock data
   ├─ Assets.xcassets/                 # album artwork placeholders and UI assets
   └─ Resources/                       # local audio files + tracks.json (ignored by git)
```

## Requirements

- **Xcode 15+**
- **iOS 17+** (simulator or device)
- Swift 5.9+

## Getting started

1. **Clone the repo**
  ```bash
    git clone https://github.com/kluczi/ipod-clone.git
    cd ipod-clone
  ```
2. **Open the project**
  - Open `ipod-clone.xcodeproj` in Xcode.
3. **Add local audio files**
  - Place your `.mp3` files in `ipod-clone/ipod-clone/Resources/`.
    - Update `tracks.json` in the same folder with entries pointing to those files (file names only; this file is ignored by git so you can keep your own local library).
4. **Run**
  - Select an iPhone simulator (or device) and press **Run** in Xcode.

## `tracks.json` structure

`tracks.json` is decoded as a **JSON array** of track objects (check `TrackPayload` in `Services/LibraryService.swift`).

Example:

```json
[
    {
        "title": "9",
        "artist": "Drake",
        "album": "Views",
        "duration": 267,
        "image": "views",
        "fileName": "drake_9.mp3"
    }
]
```

Fields:

- **title**: `String` — track title shown in the library/now playing
- **artist**: `String` — artist name
- **album**: `String` — album name
- **duration**: `Number` — duration in seconds (can be an integer or decimal)
- **image**: `String` — image asset name in `Assets.xcassets`
- **fileName**: `String` — audio file name located in `Resources/` (include extension, e.g. `.mp3`)

## Customization tips

- **Adding tracks**
  - Add new MP3s to `Resources/` and corresponding items to `tracks.json`.
- **Changing artwork**
  - Add new images to `Assets.xcassets` and reference them in your `Track` models.

## Notes

- The `Resources/` folder and `tracks.json` are intentionally **ignored** in `.gitignore` so you can keep your personal music library and metadata locally without committing audio files to the repo.

