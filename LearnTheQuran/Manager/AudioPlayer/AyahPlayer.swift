//
//  AudioPlayerFunktionality.swift
//  LearnTheQuran
//
//  Created by Ömer Tarakci on 28.06.23.
//
//


    import SwiftUI
    import AVFoundation
    import CoreMedia
    import Toast
    import MediaPlayer

    class AyahhPlayer: ObservableObject {
        var player = AVPlayer()
        
        private var playerItem: AVPlayerItem?
        private var timeObserverToken: Any?
        private var textRepository: TextRepository
        
        @Published var isPlaying = false {
            didSet {
                updateNowPlayingInfo()
            }
        }
        @Published var currentTime: TimeInterval = 0.0
        @Published var currentAyah: AyahAudio? {
            didSet {
                updateNowPlayingInfo()
            }
        }
        
        @Published var totalTime: TimeInterval = 0.0
        @Published var currentIndex = 0
        @Published var currentSurah4Audio: [AyahAudio] = []
        
        @Published var volume: Float = 0.3 {
            didSet {
                print(volume)
                player.volume = self.volume
            }
        }
           
        init(ayahs: [AyahAudio], ayah: Int = 0, textRepository: TextRepository) {
            self.currentSurah4Audio = ayahs
            self.currentIndex = ayah-1
            self.textRepository = textRepository
               
            if !ayahs.isEmpty {
                self.currentIndex = ayah-1
                self.currentAyah = ayahs[self.currentIndex]
                setupPlayer(url: currentAyah!.audio)
            }

            // Add remote control commands -> für audio-widget im sperrbildschirm, funzt aber nicht
            let commandCenter = MPRemoteCommandCenter.shared()

            commandCenter.playCommand.addTarget { [unowned self] event in
                if !self.isPlaying {
                    self.togglePlayPause()
                    return .success
                }
                return .commandFailed
            }

            commandCenter.pauseCommand.addTarget { [unowned self] event in
                if self.isPlaying {
                    self.togglePlayPause()
                    return .success
                }
                return .commandFailed
            }

            commandCenter.nextTrackCommand.addTarget { [unowned self] event in
                self.next()
                return .success
            }

            commandCenter.previousTrackCommand.addTarget { [unowned self] event in
                self.prev()
                return .success
            }
        }
        
        func setupPlayer(url: String) {
            if let audioURL = URL(string: url) {
                playerItem = AVPlayerItem(url: audioURL)
                player = AVPlayer(playerItem: playerItem)
                player.volume = Float(volume)
                addTimeObserver()
            }
        }

        func togglePlayPause() {
            if isPlaying {
                player.pause()
            } else {
                player.play()
            }
            isPlaying.toggle()
        }
        
        func next() {
            if currentIndex < currentSurah4Audio.count - 1 {
                currentIndex += 1
                currentAyah = currentSurah4Audio[currentIndex]

                player.removeTimeObserver(timeObserverToken!)
                self.timeObserverToken = nil

                self.currentTime = 0.0
                setupPlayer(url: currentAyah!.audio)
                player.play()
            }
        }

        func prev() {
            if currentIndex > 0 {
                currentIndex -= 1
                currentAyah = currentSurah4Audio[currentIndex]

                player.removeTimeObserver(timeObserverToken!)
                self.timeObserverToken = nil

                setupPlayer(url: currentAyah!.audio)
                player.play()
            }
        }
        
        func addTimeObserver() {
            guard timeObserverToken == nil else { return }
            
            timeObserverToken = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.1, preferredTimescale: CMTimeScale(NSEC_PER_SEC)), queue: DispatchQueue.main) { [weak self] time in
                guard let self = self else { return }
                
                if time.seconds > self.totalTime {
                    self.currentTime = self.totalTime
                } else {
                    self.currentTime = time.seconds
                }
                
                self.totalTime = self.playerItem?.duration.seconds ?? 0.0
                
                if self.currentTime >= self.totalTime - 0.1 {
                    self.next()
                }

                // Update now playing info for the lock screen // funzt nicht 
                self.updateNowPlayingInfo()
            }
        }

        
        func removeTimeObserver() {
            if let timeObserverToken = timeObserverToken {
                player.removeTimeObserver(timeObserverToken)
                self.timeObserverToken = nil
            }
        }

        func updateNowPlayingInfo() {
            var nowPlayingInfo = [String: Any]()
            nowPlayingInfo[MPMediaItemPropertyTitle] = currentAyah?.text 
            nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = currentTime
            nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = totalTime
            nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = isPlaying ? 1.0 : 0.0
            MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
        }
    }






//    func skipBackward(seconds: Double) {
//        guard let currentTime = player?.currentTime() else {
//            return
//        }
//
//        let newTime = CMTime(seconds: max(currentTime.seconds - seconds, 0), preferredTimescale: currentTime.timescale)
//        player?.seek(to: newTime)
//    }
//
//    func skipForward(seconds: Double) {
//        guard let currentTime = player?.currentTime(), let duration = player?.currentItem?.duration else {
//            return
//        }
//
//        let newTime = CMTime(seconds: min(currentTime.seconds + seconds, duration.seconds), preferredTimescale: currentTime.timescale)
//        player?.seek(to: newTime)
//    }
//
//    private func addPlaybackObserver() {
//        guard let player = player, let currentItem = player.currentItem else {
//            print(player?.currentItem)
//            return
//        }
//
//        let interval = CMTime(seconds: 0.1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
//        timeObserverToken = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
//            guard let self = self else {
//                return
//            }
//
//            self.currentTime = time.seconds
//            self.totalTime = currentItem.duration.seconds.isFinite ? currentItem.duration.seconds : 0
//
//            if time >= currentItem.duration {
//                self.playNextAyah()
//            }
//        }
//    }
//
//     func removePlaybackObserver() {
//        guard let token = timeObserverToken else {
//            return
//        }
//
//        player?.removeTimeObserver(token)
//        timeObserverToken = nil
//    }
//
//    func playNextAyah() {
//        guard let currentAyah = currentAyah,
//              let surah = surah,
//              let ayahIndex = surah.ayahs.firstIndex(where: { $0.id == currentAyah.id }) else {
//            return
//        }
//
//        let nextAyahIndex = ayahIndex + 1
//
//        if nextAyahIndex < surah.ayahs.count {
//            let nextAyah = surah.ayahs[nextAyahIndex]
//            self.currentAyah = nextAyah // Aktualisierung des aktuellen Ayah
//            playAyah(nextAyah)
//        } else {
//            // Text, der den Benutzer beglückwünscht
//        }
//    }
//
//     func playAyah(_ ayah: AyahAudio) {
//        guard let audioURL = URL(string: ayah.audio) else {
//            return
//        }
//
//        let playerItem = AVPlayerItem(url: audioURL)
//        player = AVPlayer(playerItem: playerItem)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
//
//        player?.play()
//        isPlaying = true
//        currentAyah = ayah
//    }
//
//    @objc private func playerDidFinishPlaying() {
//        playNextAyah()
//    }
//
//    func skipBackward(Sseconds: Double) {
//        guard let currentTime = player?.currentTime() else {
//            return
//        }
//
//        let newTime = CMTime(seconds: max(currentTime.seconds - Sseconds, 0), preferredTimescale: currentTime.timescale)
//        player?.seek(to: newTime, toleranceBefore: .zero, toleranceAfter: .zero)
//    }
//}
