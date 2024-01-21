//
//  SurahListeningScreen.swift
//  LearnTheQuran
//
//  Created by Ömer Tarakci on 28.06.23.
//

import SwiftUI
import UIKit

struct SurahListeAudio: View {
    @EnvironmentObject var text: TextRepository
    @EnvironmentObject var audioRepository: AudioRepository
    @EnvironmentObject var taskViewModel: FavViewModel

    @State private var selectedSurah: SurahObjects?

    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor.systemBackground
        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.label,
            .font: UIFont.systemFont(ofSize: 28)
        ]
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Suren 1-114")
                        .font(Font.custom("Scheherazade", size: 24))
                        .padding()
                        .foregroundColor(Color(UIColor.label))
                        .offset(y: 85)

                    Text("﷽")
                        .font(Font.custom("Scheherazade", size: 40))
                        .padding()
                        .foregroundColor(Color(UIColor.label))
                        .offset(y: 50)

                    List {
                        Text("Suren 1-114")
                            .font(.system(size: 10))
                            .fontWeight(.thin)
                            .foregroundColor(Color(UIColor.secondaryLabel))
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
                            .listRowBackground(Color(UIColor.systemBackground))

                        ForEach(audioRepository.surahAudio?.surahs ?? [], id: \.number) { surah in
                            NavigationLink(destination: AyahListenView(surah: surah).environmentObject(self.audioRepository)) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .fill(Color(UIColor.systemBackground).opacity(0.85))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                                .stroke(LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .leading, endPoint: .trailing), lineWidth: 2)
                                        )

                                    Text("Surah \(surah.number). \(surah.englishName)")
                                        .font(.system(size: 16))
                                        .padding(.all, 6)
                                        .foregroundColor(Color(UIColor.label))
                                }

                                .frame(height: 80)
                            }
                        }
                    }
                    .background(Color(UIColor.systemBackground))
                    .padding(.top, 0)
                    .offset(y: 40)
                }
                .frame(maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            }
            .onAppear {
                audioRepository.fetchSurahAudio()
            }
        }
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        .navigationBarTitle("", displayMode: .inline)

    }
}

struct SurahListeAudio_Previews: PreviewProvider {
    static var previews: some View {
        SurahListeAudio()
    }
}









//struct SurahListeAudio: View {
//    @EnvironmentObject var text: TextRepository
//    @EnvironmentObject var audioRepository: AudioRepository
//    @EnvironmentObject var taskViewModel: FavViewModel
//    
//    @State private var selectedSurah: SurahObjects?
//    
//    init() {
//        let navBarAppearance = UINavigationBarAppearance()
//        // navBarAppearance.configureWithOpaqueBackground() // Diese Zeile entfernen
//        navBarAppearance.backgroundColor = UIColor.clear
//        navBarAppearance.titleTextAttributes = [
//            .foregroundColor: UIColor.clear,
//            .font: UIFont.systemFont(ofSize: 28)
//        ]
//        UINavigationBar.appearance().standardAppearance = navBarAppearance
//        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
//        UINavigationBar.appearance().compactAppearance = navBarAppearance
//    }
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.blue.opacity(0.7)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all) // Hintergrundfarbe für ZStack
//
//                VStack {
////                    Text("Suren 1-114")
////                        .font(Font.custom("Scheherazade", size: 24))
////                        .padding()
////                        .foregroundColor(Color.blue) // Akzentfarbe für Text
//
//                    Text("﷽")
//                        .font(Font.custom("Scheherazade", size: 40))
//                        .padding()
//                        .foregroundColor(Color.blue.opacity(0.8)) // Akzentfarbe für Text
//                        .offset(y: -50)
//
//                    List {
//                        Text("Suren 1-114")
//                            .font(.system(size: 10))
//                            .fontWeight(.thin)
//                            .foregroundColor(Color.gray)
//                            .multilineTextAlignment(.center)
//                            .lineLimit(1)
//
//                        ForEach(audioRepository.surahAudio?.surahs ?? [], id: \.number) { surah in
//                            NavigationLink(destination: AyahListenView(surah: surah).environmentObject(self.audioRepository)) {
//                                ZStack {
//                                    LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.blue]), startPoint: .leading, endPoint: .trailing)
//                                    .frame(height: 80)
//                                    .cornerRadius(10) // Farbverlauf für Listenelemente
//                                    
//                                    Text("Surah \(surah.number). \(surah.englishName)")
//                                        .font(.system(size: 16))
//                                        .padding(.all, 6)
//                                        .foregroundColor(.white)
//                                }
//                            }
//                        }
//                    }
//                    .padding(.top, 0)
//                    .offset(y: 40)
//                }
//                .frame(maxHeight: .infinity)
//            }
//            .onAppear {
//                audioRepository.fetchSurahAudio()
//            }
//        }
//        .navigationBarTitle("", displayMode: .inline)
//    }
//}
//
//struct SurahListeAudio_Previews: PreviewProvider {
//    static var previews: some View {
//        SurahListeAudio()
//    }
//}







