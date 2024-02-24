import SwiftUI
import AVFoundation

struct AyahListenView: View {
    @EnvironmentObject var text: TextRepository
    @EnvironmentObject var audioRepository: AudioRepository
    @EnvironmentObject var taskViewModel: FavViewModel
    @EnvironmentObject var adManager: AdManager

    var surah: SurahObjects

    @State private var selectedAyah: AyahAudio?
    @State private var isAudioPlayerPresented = false

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section(header: Text("﷽")
                        .font(Font.custom("Scheherazade", size: 40).lowercaseSmallCaps())
                        .foregroundColor(Color.primary)
                        .padding(.vertical)) {
                            
                            ForEach(surah.ayahs) { ayah in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Ayah \(ayah.numberInSurah)")
                                            .font(.headline)
                                            .foregroundColor(Color(UIColor.label))
                                            .padding(.all, 6)
                                        
                                        Text(ayah.text)
                                            .font(.body)
                                            .foregroundColor(Color(UIColor.secondaryLabel))
                                            .padding(.all, 6)
                                    }
                                    Spacer()
                                }
                                .onTapGesture {
                                    selectedAyah = ayah
                                    isAudioPlayerPresented = true
                                    showToast(message: "Bismillahirahmanirahim")
                                }
                                .background(backgroundColor(for: ayah))
                                .cornerRadius(7)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 7, style: .continuous)
                                        .stroke(LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .leading, endPoint: .trailing), lineWidth: 2)
                                )
                                .listRowBackground(Color(UIColor.systemBackground))
                            }
                    }
                    .listStyle(InsetGroupedListStyle())
                    .navigationBarTitle("", displayMode: .inline)
                    .onAppear {
                        audioRepository.fetchSurahAudio()
                    }
                }
                .foregroundColor(Color(UIColor.label))
                .sheet(isPresented: $isAudioPlayerPresented, onDismiss: showInterstitialAd) {
                    if let selectedAyah = selectedAyah {
                        AudioPlayerView(audioPlayer: AyahhPlayer(ayahs: surah.ayahs, ayah: selectedAyah.numberInSurah, textRepository: TextRepository()), surah: surah)
                            .environmentObject(audioRepository)
                            .environmentObject(text)
                            .environmentObject(taskViewModel)
                    }
                }
            }
        }
        .navigationTitle("Ayahs: \(surah.ayahs.count)")
        .toolbarBackground(Color.clear, for: .navigationBar)
    }

    private func showInterstitialAd() {
        if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
            adManager.showInterstitialAd(from: rootViewController)
        } else {
            print("RootViewController not found.")
        }
    }

    private func backgroundColor(for ayah: AyahAudio) -> Color {
        if let selectedAyah = selectedAyah, ayah.id == selectedAyah.id {
            return .yellow
        } else {
            return Color(UIColor.systemBackground)
        }
    }

    func showToast(message: String) {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            scene.windows.first?.rootViewController?.view.makeToast(message, duration: 3.0, position: .top)
        }
    }
}

struct AyahListenView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleAyahs = [
            AyahAudio(number: 1, audio: "https://example.com/audio1.mp3", audioSecondary: [], text: "Lorem ipsum dolor sit amet.", numberInSurah: 1, juz: 1, manzil: 1, page: 1, ruku: 1, hizbQuarter: 1),
            AyahAudio(number: 2, audio: "https://example.com/audio2.mp3", audioSecondary: [], text: "Consectetur adipiscing elit.", numberInSurah: 2, juz: 1, manzil: 1, page: 1, ruku: 1, hizbQuarter: 1)
        ]
        
        let sampleSurah = SurahObjects(number: 1, name: "Al-Fatiha", englishName: "The Opening", englishNameTranslation: "The Opening", revelationType: "Meccan", ayahs: sampleAyahs)
        
        return AyahListenView(surah: sampleSurah).environmentObject(TextRepository()).environmentObject(AudioRepository()).environmentObject(FavViewModel()).environmentObject(AdManager.shared)
    }
}
