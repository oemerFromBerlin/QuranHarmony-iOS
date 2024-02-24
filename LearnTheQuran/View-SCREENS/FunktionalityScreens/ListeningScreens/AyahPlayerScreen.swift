import SwiftUI
import AVFoundation
import Foundation

//-----------------------------------------------------------------------------------------------//
// Die FloatingCircle-View
//struct FloatingCircles: View {
//    let size: CGFloat
//    let xPosition: CGFloat
//    let blurRadius: CGFloat
//    let color: Color
//    @State private var startY = false
//    
//    var body: some View {
//        Circle()
//            .frame(width: size, height: size)
//            .foregroundColor(color.opacity(0.4))
//            .blur(radius: blurRadius)
//            .position(x: xPosition, y: startY ? UIScreen.main.bounds.height + size : -size)
//            .onAppear() {
//                withAnimation(Animation.easeInOut(duration: Double.random(in: 15...25)).repeatForever(autoreverses: false)) {
//                    startY.toggle()
//                }
//            }
//    }
//}

//let circless: [CircleDataa] = [
//    // Hier können Sie Ihre CircleData-Objekte hinzufügen
//]

//struct CircleDataa: Identifiable {
//    let id: Int
//    let size: CGFloat
//    let xPosition: CGFloat
//    let blurRadius: CGFloat
//    let color: Color
//}
//-----------------------------------------------------------------------------------------------//
//-----------------------------------------------------------------------------------------------//

//-----------------------------------------------------------------------------------------------//
struct AudioPlayerView: View {
    @EnvironmentObject var textRepository : TextRepository
    @EnvironmentObject var audioRepository : AudioRepository
    @EnvironmentObject var favViewModel : FavViewModel
    @ObservedObject var audioPlayer: AyahhPlayer
    var surah: SurahObjects
    @ObservedObject private var favoritesManager = FavoritesManager.shared
    
    
    
    let circles: [CircleData] = [
        CircleData(id: 1, size: 100, xPosition: .random(in: 0...UIScreen.main.bounds.width), blurRadius: 2, color: Color.blue.opacity(0.7)),
        CircleData(id: 3, size: 150, xPosition: .random(in: 0...UIScreen.main.bounds.width), blurRadius: 6, color: Color.green.opacity(0.7)),
        CircleData(id: 4, size: 75, xPosition: .random(in: 0...UIScreen.main.bounds.width), blurRadius: 5, color: Color.purple.opacity(0.5)),
        CircleData(id: 5, size: 225, xPosition: .random(in: 0...UIScreen.main.bounds.width), blurRadius: 5, color: Color.orange.opacity(0.5)),
        CircleData(id: 6, size: 30, xPosition: .random(in: 0...UIScreen.main.bounds.width), blurRadius: 5, color: Color.red.opacity(0.7)),
        CircleData(id: 7, size: 180, xPosition: .random(in: 0...UIScreen.main.bounds.width), blurRadius: 5, color: Color.black.opacity(0.7)),
        CircleData(id: 8, size: 20, xPosition: .random(in: 0...UIScreen.main.bounds.width), blurRadius: 5, color: Color.green.opacity(0.5)),
        CircleData(id: 9, size: 200, xPosition: .random(in: 0...UIScreen.main.bounds.width), blurRadius: 5, color: Color.white.opacity(0.7)),
        CircleData(id: 10, size: 200, xPosition: .random(in: 0...UIScreen.main.bounds.width), blurRadius: 5, color: Color.black.opacity(0.7)),
    ]
//-----------------------------------------------------------------------------------------------//
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    ForEach(circles, id: \.id) { circle in
                        // Verwende hier FloatingCircles (korrigiere den Namen)
                        FloatingCircles(size: circle.size/*, xPosition: circle.xPosition*/, blurRadius: circle.blurRadius, color: circle.color)
                    }
                    
                    VStack(spacing: 16) {
                        ScrollView {
                            if let currentAyah = audioPlayer.currentAyah {
                                let currentAyahText = textRepository.surahs
                                    .flatMap(\.ayahs)
                                    .first(where: { $0.number == currentAyah.number })
                                
                                if let currentAyahText = currentAyahText {
                                    Group {
                                        Text("\(surah.englishName) \((currentAyah.numberInSurah))")
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
                                    Text("Loading Ayah´s...")
                                        .foregroundColor(.red)
                                }
                            } else {
                                Text("Keine aktueller Ayah verfügbar.")
                            }
                        }
                        .frame(height: max(geometry.size.height - 250, 0))
                        
                        Spacer(minLength: 20)
                        
                        VStack{
                            HStack {
                                Text("\(timeString(from: audioPlayer.currentTime))")
                                    .foregroundColor(.white)
                                
                                Slider(value: $audioPlayer.currentTime, in: 0...max(audioPlayer.currentTime, audioPlayer.totalTime, 0.1))
                                    .frame(height: 3)
                                    .background(LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .top, endPoint: .bottomTrailing))
//                                    .onChange(of: audioPlayer.currentTime) { newValue in
//                                        audioPlayer.seek(to: newValue)
//                                    }
                                    //.foregroundColor(.blue)
                                    .disabled(false)
                                    
                                
                                Text("\(timeString(from: audioPlayer.totalTime))")
                                    .foregroundColor(.white)
                            }
                            
                            HStack {
                                Button(action: {
                                    withAnimation {
                                        audioPlayer.prev()
                                        
                                    }
                                }) 
                                {
                                    Image(systemName: "backward.fill")
                                        .font(.system(size: 30))
                                        .foregroundColor(.white)
                                }
                                .offset(x: 40)

                                
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
                                }
                                .offset(x: -40)
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
//-----------------------------------------------------------------------------------------------//
//-----------------------------------------------------------------------------------------------//
private func timeString(from time: TimeInterval) -> String {
    guard !time.isNaN && !time.isInfinite else {
        return "00:00"
    }
    let minutes = Int(time) / 60
    let seconds = Int(time) % 60
    return String(format: "%02d:%02d", minutes, seconds)
}

//-----------------------------------------------------------------------------------------------//
//-----------------------------------------------------------------------------------------------//
struct AudioPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        _ = AudioRepository()
        let sampleAyahs = [
            AyahAudio(number: 1, audio: "url-audio-mp31", audioSecondary: [], text: "url-audio-mp31", numberInSurah: 1, juz: 1, manzil: 1, page: 1, ruku: 1, hizbQuarter: 1)
        ]
        let sampleSurah = SurahObjects(number: 1, name: "", englishName: "", englishNameTranslation: "", revelationType: "", ayahs: sampleAyahs)
        let audioPlayer = AyahhPlayer(ayahs: sampleAyahs, textRepository: TextRepository())
        
        return AudioPlayerView(audioPlayer: audioPlayer, surah: sampleSurah)
            .padding()
    }
}



