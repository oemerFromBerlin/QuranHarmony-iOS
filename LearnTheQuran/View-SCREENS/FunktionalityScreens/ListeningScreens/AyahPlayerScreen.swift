import SwiftUI
import AVFoundation
import Foundation




import SwiftUI
import AVFoundation

// Die FloatingCircle-View
struct FloatingCircles: View {
    let size: CGFloat
    let xPosition: CGFloat
    let blurRadius: CGFloat
    let color: Color
    @State private var startY = false

    var body: some View {
        Circle()
            .frame(width: size, height: size)
            .foregroundColor(color.opacity(0.4))
            .blur(radius: blurRadius)
            .position(x: xPosition, y: startY ? UIScreen.main.bounds.height + size : -size)
            .onAppear() {
                withAnimation(Animation.easeInOut(duration: Double.random(in: 15...25)).repeatForever(autoreverses: false)) {
                    startY.toggle()
                }
            }
    }
}

let circless: [CircleDataa] = [
    // Hier können Sie Ihre CircleData-Objekte hinzufügen
]

struct CircleDataa: Identifiable {
    let id: Int
    let size: CGFloat
    let xPosition: CGFloat
    let blurRadius: CGFloat
    let color: Color
}

struct AudioPlayerView: View {
    @EnvironmentObject var textRepository : TextRepository
    @EnvironmentObject var audioRepository : AudioRepository
    @EnvironmentObject var favViewModel : FavViewModel
    
    @ObservedObject var audioPlayer: AyahhPlayer
    var surah: SurahObjects
    @ObservedObject private var favoritesManager = FavoritesManager.shared
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    ForEach(circles, id: \.id) { circle in
                        FloatingCircle(size: circle.size, xPosition: circle.xPosition, blurRadius: circle.blurRadius, color: circle.color)
                    }
                    
                    VStack(spacing: 16) {
                        ScrollView {
                            if let currentAyah = audioPlayer.currentAyah {
                                let currentAyahText = textRepository.surahs
                                    .flatMap(\.ayahs)
                                    .first(where: { $0.number == currentAyah.number })
                                
                                if let currentAyahText = currentAyahText {
                                    Group {
                                        Text(surah.englishName)
                                            .foregroundColor(.white)
                                        Text("Bismillahirahmanirahim")
                                            .foregroundColor(.green.opacity(0.6))
                                            .font(Font.custom("Scheherazade", size: 24))
                                        Text(">| Ayah:\(currentAyah.numberInSurah) - \(currentAyahText.text)|<")
                                            .foregroundColor(.white)
                                            .font(Font.custom("Scheherazade", size: 28))
                                            .multilineTextAlignment(.leading)
                                            .padding()
                                            .background(Color.black.opacity(0.4))
                                            .cornerRadius(15)
                                    }
                                    
                                    Button(action: {
                                        withAnimation(.easeIn) {
                                            if self.favoritesManager.isFavorite(currentAyah.number) {
                                                self.favoritesManager.removeFavorite(currentAyah.number)
                                            } else {
                                                self.favoritesManager.addFavorite(currentAyah.number)
                                            }
                                        }
                                    }) {
                                        Image(systemName: self.favoritesManager.isFavorite(currentAyah.number) ? "heart.fill" : "heart")
                                            .font(.title)
                                            .foregroundColor(self.favoritesManager.isFavorite(currentAyah.number) ? .red : .gray)
                                    }
                                    .padding(.bottom, 20)
                                } else {
                                    Text("nix founded")
                                        .foregroundColor(.red)
                                }
                            } else {
                                Text("Kein aktueller Ayah verfügbar.")
                            }
                        }
                        .frame(height: max(geometry.size.height - 250, 0))
                        
                        Spacer(minLength: 20)
                        
                        VStack{
                            HStack {
                                Text("\(timeString(from: audioPlayer.currentTime))")
                                    .foregroundColor(.white)
                                
                                Slider(value: $audioPlayer.currentTime, in: 0...max(audioPlayer.currentTime, audioPlayer.totalTime, 1.0))
                                    .frame(height: 3)
                                    .background(LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .top, endPoint: .bottomTrailing))
                                    .foregroundColor(.blue)
                                    .disabled(true)
                                
                                Text("\(timeString(from: audioPlayer.totalTime))")
                                    .foregroundColor(.white)
                            }
                            
                            HStack {
                                Button(action: {
                                    withAnimation {
                                        audioPlayer.prev()
                                    }
                                }) {
                                    Image(systemName: "backward.fill")
                                        .font(.system(size: 30))
                                        .foregroundColor(.white)
                                        .offset(x: 40)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    withAnimation {
                                        audioPlayer.togglePlayPause()
                                    }
                                }) {
                                    Image(systemName: audioPlayer.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                        .font(.system(size: 120))
                                        .foregroundColor(audioPlayer.isPlaying ? .red : .green)
                                }
                                .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0))
                                
                                Spacer()
                                
                                Button(action: {
                                    withAnimation {
                                        audioPlayer.next()
                                    }
                                }) {
                                    Image(systemName: "forward.fill")
                                        .font(.system(size: 30))
                                        .foregroundColor(.white)
                                        .offset(x: -40)
                                }
                            }
                        }
                        
                        Spacer()
                    }
                }
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.black.opacity(0.8), .black]),
                        startPoint: .top,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(10)
                .shadow(radius: 5)
                .navigationBarHidden(true)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    audioPlayer.addTimeObserver()
                    UINavigationBar.appearance().isTranslucent = false
                    textRepository.fetchSurahs()
                }
                .onDisappear {
                    audioPlayer.removeTimeObserver()
                    UINavigationBar.appearance().isTranslucent = true
                }
            }
        }
    }
}

private func timeString(from time: TimeInterval) -> String {
    guard !time.isNaN && !time.isInfinite else {
        return "00:00"
    }
    let minutes = Int(time) / 60
    let seconds = Int(time) % 60
    return String(format: "%02d:%02d", minutes, seconds)
}

struct AudioPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        let audioRepository = AudioRepository()
        let sampleAyahs = [
            AyahAudio(number: 1, audio: "url-audio-mp31", audioSecondary: [], text: "url-audio-mp31", numberInSurah: 1, juz: 1, manzil: 1, page: 1, ruku: 1, hizbQuarter: 1)
        ]
        let sampleSurah = SurahObjects(number: 1, name: "", englishName: "", englishNameTranslation: "", revelationType: "", ayahs: sampleAyahs)
        let audioPlayer = AyahhPlayer(ayahs: sampleAyahs, textRepository: TextRepository())
        
        return AudioPlayerView(audioPlayer: audioPlayer, surah: sampleSurah)
            .padding()
    }
}







//struct AudioPlayerView: View {
//
//    @EnvironmentObject var textRepository : TextRepository
//    @EnvironmentObject var audioRepository : AudioRepository
//    @EnvironmentObject var favViewModel : TaskViewModel
//
//
////    @EnvironmentObject private var audioRepository: AudioRepository
//    @ObservedObject var audioPlayer: AyahhPlayer
//    var surah: SurahObjects
//    @ObservedObject private var favoritesManager = FavoritesManager.shared
//
//
//    var body: some View {
//        NavigationView {
//            GeometryReader { geometry in
//                VStack(spacing: 16) {
//                    ScrollView {
//                        if let currentAyah = audioPlayer.currentAyah {
//                            let currentAyahText = textRepository.surahs
//                                .flatMap(\.ayahs)
//                                .first(where: { $0.number == currentAyah.number })
//                            Text("")
//                                .onAppear {
//                                    print("\(textRepository.surahs.count)")
//                                }
//
//                            if let currentAyahText = currentAyahText {
//                                Group {
//                                    Text(surah.englishName)
//                                    Text(">| Ayah:\(currentAyah.numberInSurah) - \(currentAyahText.text)|<")
//                                        .foregroundColor(.white)
//                                        .font(.title)
//                                        .multilineTextAlignment(.leading)
//                                        .padding()
//                                        .background(Color.black.opacity(0.4))
//                                        .cornerRadius(15)
//                                }
//                                .onAppear {
//                                    print(" \(currentAyahText.text)")
//                                }
//
//                                Button(action: {
//                                    if self.favoritesManager.isFavorite(currentAyah.number) {
//                                        print(" \(currentAyah.number) ")
//                                        self.favoritesManager.removeFavorite(currentAyah.number)
//                                    } else {
//                                        print(" \(currentAyah.number) ")
//                                        self.favoritesManager.addFavorite(currentAyah.number)
//                                    }
//                                }) {
//                                    Image(systemName: self.favoritesManager.isFavorite(currentAyah.number) ? "heart.fill" : "heart")
//                                        .font(.title)
//                                        .foregroundColor(self.favoritesManager.isFavorite(currentAyah.number) ? .red : .gray)
//                                }
//
//                            } else {
//                                Text("nix founded")
//                                    .foregroundColor(.red)
//                                    .onAppear {
//                                        print("ayah nichtgefunfden \(currentAyah.numberInSurah) ")
//                                    }
//                            }
//
//                        } else {
//                            Text("Kein aktueller Ayah verfügbar.")
//                                .onAppear {
//                                    print("currentAyah ist nil")
//                                }
//                        }
//
//                    }
//                    .frame(height: max(geometry.size.height - 250, 0))
//                    Spacer(minLength: 20)
//
//                    // Beginn der hinzugefügten Teile
//                    VStack{
//                        HStack {
//                            Text("\(timeString(from: audioPlayer.currentTime))")
//                                .foregroundColor(.white)
//                                .font(.system(size: 16))
//                            //                            .offset(x: -20)
//
//                            Slider(value: $audioPlayer.currentTime, in: 0...max(audioPlayer.currentTime, audioPlayer.totalTime, 1.0))
//                                .accentColor(.blue)
//                                .frame(height: 10)
//                                .foregroundColor(.blue)
//                                .background(LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .top, endPoint: .bottomTrailing))
//                                .cornerRadius(33)
//                                .disabled(true)
//
//                            Text("\(timeString(from: audioPlayer.totalTime))")
//                                .foregroundColor(.white)
//                                .font(.system(size: 16))
//
//                            Divider()
//                        }
//
//                        HStack {
//                            Button(action: {
//                                audioPlayer.prev()
//                            }) {
//                                Image(systemName: "backward.fill")
//                                    .font(.system(size: 30))
//                                    .foregroundColor(.white.opacity(1))
//                                    .offset(x: 40)
//                            }
//
//                            Spacer()
//
//                            Button(action: {
//                                audioPlayer.togglePlayPause()
//                            }) {
//                                Image(systemName: audioPlayer.isPlaying ? "pause.circle.fill" : "play.circle.fill")
//                                    .font(.system(size: 120))
//                                    .foregroundColor(audioPlayer.isPlaying ? .red.opacity(0.5) : .green.opacity(1.0))
//                                //                                .padding()
//                            }
//
//                            Spacer()
//
//                            Button(action: {
//                                audioPlayer.next()
//                            }) {
//                                Image(systemName: "forward.fill")
//                                    .font(.system(size: 30))
//                                    .foregroundColor(.white.opacity(1))
//                                    .offset(x: -40)
//                            }.buttonStyle(.plain)
//
//
//                            //                            .plain()
//
//                        }
//                    }
//
//                    Spacer()
//                    // Ende der hinzugefügten Teile
//
//                }
//                .padding()
//                .background(
//                    LinearGradient(
//                        gradient: Gradient(colors: [.black.opacity(0.8), .black.opacity(0.8)]),
//                        startPoint: .top,
//                        endPoint: .bottomTrailing
//                    )
//                )
//                .cornerRadius(10)
//                .shadow(radius: 5)
//                .navigationBarHidden(true)
//                .edgesIgnoringSafeArea(.all)
//                .onAppear {
//                    audioPlayer.addTimeObserver()
//                    UINavigationBar.appearance().isTranslucent = false
//                    textRepository.fetchSurahs()
//                }
//                .onDisappear {
//                    audioPlayer.removeTimeObserver()
//                    UINavigationBar.appearance().isTranslucent = true
//                }
//            }
//        }
//    }
//}
//
//private func timeString(from time: TimeInterval) -> String {
//    guard !time.isNaN && !time.isInfinite else {
//        return "00:00"
//    }
//    let minutes = Int(time) / 60
//    let seconds = Int(time) % 60
//    return String(format: "%02d:%02d", minutes, seconds)
//}
//
//
//struct AudioPlayerView_Previews: PreviewProvider {
//    static var previews: some View {
//        let audioRepository = AudioRepository()
//        let sampleAyahs = [
//            AyahAudio(number: 1, audio: "url-audio-mp31", audioSecondary: [], text: "url-audio-mp31", numberInSurah: 1, juz: 1, manzil: 1, page: 1, ruku: 1, hizbQuarter: 1)]
//
//        let sampleSurah = SurahObjects(number: 1, name: "", englishName: "", englishNameTranslation: "", revelationType: "", ayahs: sampleAyahs)
//        let audioPlayer = AyahhPlayer(ayahs: sampleAyahs, textRepository: TextRepository())
//
//        return AudioPlayerView(audioPlayer: audioPlayer, surah: sampleSurah)
//            .environmentObject(audioRepository)
////            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
