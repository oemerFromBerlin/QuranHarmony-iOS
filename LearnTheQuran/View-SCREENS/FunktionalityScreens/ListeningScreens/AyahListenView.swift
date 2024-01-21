//
//  AyahAudioListe.swift
//  LearnTheQuran
//
//  Created by Ömer Tarakci on 04.07.23.
//


import SwiftUI
import AVFoundation

struct AyahListenView: View {
    @EnvironmentObject var text: TextRepository
    @EnvironmentObject var audioRepository: AudioRepository
    @EnvironmentObject var taskViewModel: FavViewModel

    var surah: SurahObjects

    @State private var selectedAyah: AyahAudio?
    @State private var isAudioPlayerPresented = false

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "arrow.left")
                            Text("SurahListeAudio")
                        }
                    }
                    .padding()
                    .foregroundColor(Color(UIColor.label))
                    Spacer()
                }

                Text("Surah \(surah.number). \(surah.englishName)")
                    .font(Font.custom("Scheherazade", size: 24))
                    .font(.title)
                    .padding()
                    .foregroundColor(Color(UIColor.label))
                    .offset(y: 70)

                Text("﷽")
                    .font(Font.custom("Scheherazade", size: 40))
                    .font(.title)
                    .padding()
                    .foregroundColor(Color(UIColor.label))
                    .offset(y: 50)

                List {
                    Text("Ayahs of \(surah.englishName)")
                        .font(.system(size: 10))
                        .fontWeight(.thin)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .listRowBackground(Color(UIColor.systemBackground))

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
                .offset(y: 40)
                .listStyle(InsetGroupedListStyle())
            }
            .navigationBarBackButtonHidden(true)
            .frame(maxHeight: .infinity)
            .background(Color(UIColor.systemBackground))
            .edgesIgnoringSafeArea(.all)
            .foregroundColor(Color(UIColor.label))
            .onAppear {
                audioRepository.fetchSurahAudio()
            }
            .sheet(isPresented: $isAudioPlayerPresented) {
                if let selectedAyah = selectedAyah {
                    AudioPlayerView(audioPlayer: AyahhPlayer(ayahs: surah.ayahs, ayah: selectedAyah.numberInSurah, textRepository: TextRepository()), surah: surah)
                        .environmentObject(audioRepository)
                        .environmentObject(text)
                        .environmentObject(taskViewModel)
                }
            }
        }
        .navigationBarBackButtonHidden(false)
    }

    private func backgroundColor(for ayah: AyahAudio) -> Color {
        if let selectedAyah = selectedAyah {
            if ayah.id == selectedAyah.id {
                return .yellow
            }
        }
        return Color(UIColor.systemBackground)
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
        
        return AyahListenView(surah: sampleSurah)

    }
}
