//
//  AudioRepository.swift
//  LearnTheQuran
//
//  Created by Ömer Tarakci on 28.06.23.
//
import Foundation
import AVFoundation

class AudioRepository: ObservableObject {
    @Published var surahAudio: AudioData?
    @Published var isPlaying: [String: Bool] = [:]
    
    
    func fetchSurahAudio() {
        guard let url = URL(string: "https://api.alquran.cloud/v1/quran/ar.alafasy") else {
            print("Fehler beim Aufrufen der URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Fehler beim Abrufen der Daten: \(error)")
                return
            }
            
            guard let data = data else {
                print("Keine Daten empfangen")
                return
            }
            
            do {
                let responseAudio = try JSONDecoder().decode(ResponseAudio.self, from: data)
                DispatchQueue.main.async {
                    self.surahAudio = responseAudio.data
                }
            } catch {
                print("Fehler bei der JSON-Dekodierung: \(error)")
            }
        }
        task.resume()
    }
}


    //
//    func toggleFavorite(for surah: inout SurahObjects) {
//        surah.isFavorite.toggle()
//    }



//    func fetchSavedAudioData() -> [SURAH] {
//        let fetchRequest: NSFetchRequest<SURAH> = SURAH.fetchRequest()
//
//        do {
//            let surahs = try context.fetch(fetchRequest)
//            return surahs
//        } catch {
//            print("Fehler beim Abrufen der gespeicherten Audio-Daten: \(error.localizedDescription)")
//            return []
//        }
//    }
//}

// MARK für persistente Speicherung (offlineBetrieb)
//    func saveAudioData(_ responseAudio: ResponseAudio, completion: @escaping (Bool) -> Void) {
//
//        context.perform {
//            for surahAudio in responseAudio.data {
//                let surahEntity = SURAH(context: self.context)
//
//                surahEntity.number = Int32(surahAudio.number)
//                surahEntity.englishName = surahText.englishName
//                surahEntity.englishNameTranslation = surahAudio.englishNameTranslation
//                surahEntity.revelationType = surahAudio.revelationType
//
//                for ayahAudio in surahAudio.ayahs {
//                    let ayahEntity = AYAH(context: self.context)
//                    ayahEntity.number = Int32(ayahAudio.number)
//                    ayahEntity.text = ayahAudio.text
//                    ayahEntity.surah = surahEntity
//
//                    surahEntity.addToAyahs(ayahEntity)
//                }
//            }
//
//            do {
//                try self.context.save()
//                completion(true)
//            } catch {
//                print("Fehler beim Speichern des Kontexts: \(error.localizedDescription)")
//                completion(false)
//            }
//        }
//    }
