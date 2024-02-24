
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
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("﷽")
                    .font(Font.custom("Scheherazade", size: 40).lowercaseSmallCaps())
                    .foregroundColor(Color.primary)
                    .padding(.vertical)) {
                        
                        ForEach(audioRepository.surahAudio?.surahs ?? [], id: \.number) { surah in
                            NavigationLink(destination: AyahListenView(surah: surah).environmentObject(self.audioRepository)) {
                                SurahRow(surah: surah)
                            }
                            .listRowBackground(Color(UIColor.systemBackground))
                        }
                }
            }
            .listStyle(InsetGroupedListStyle()) // Verwenden Sie den gewünschten List-Style
            .onAppear {
                audioRepository.fetchSurahAudio()
            }
            .navigationTitle("Suren 1-114")
            .toolbarBackground(Color.clear, for: .navigationBar)
        }
    }
}


struct SurahRow: View {
    var surah: SurahObjects
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(UIColor.systemBackground).opacity(0.85))
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .leading, endPoint: .trailing), lineWidth: 2)
                )
                .listRowBackground(Color(UIColor.systemBackground))

            
            Text("Surah \(surah.number). \(surah.englishName) \((surah.englishNameTranslation))")
                .font(.system(size: 16))
                .padding(.all, 6)
                .foregroundColor(Color.primary)
            
        }
        .frame(height: 80)
    }
}

struct SurahListeAudio_Previews: PreviewProvider {
    static var previews: some View {
        SurahListeAudio()
    }
}
