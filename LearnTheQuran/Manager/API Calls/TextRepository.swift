//
//  TextDeutschRepository.swift
//  LearnTheQuran
//
//  Created by Ömer Tarakci on 28.06.23.
//

import Foundation

class TextRepository: ObservableObject {
    @Published var surahs = [SurahTexte]()
    @Published var areSurahsLoaded = false
//    @Published var ayahs = [AyahText]()
    @Published var lastSelectedAyah: AyahText?


    
    func fetchSurahs() {
        guard let url = URL(string: "https://api.alquran.cloud/v1/quran/de.bubenheim") else {
            print("Fehler beim Aufrufen der URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Fehler in Textrepository: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Keine Daten empfangen")
                return
            }
//            print(data)
            do {
                let responseText = try JSONDecoder().decode(ResponseText.self, from: data)
//                print(responseText)
                DispatchQueue.main.async {
                    let surahResponse = responseText.data.surahs
                    self.surahs = surahResponse
                    self.areSurahsLoaded = true

//                    print(surahResponse)
                }
            } catch {
                print("Fehler bei der JSON-Dekodierung: \(error)")
            }
        }
        task.resume()
    }
}


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



//    private let context: NSManagedObjectContext
//
//    init(context: NSManagedObjectContext) {
//        self.context = context
//    }
//
//    func fetchSurahTexts(completion: @escaping ([SurahText]?) -> Void) {
//        guard let url = URL(string: "http://api.alquran.cloud/v1/quran/de.bubenheim")
//        else {
//            print("Ungültige URL")
//            completion(nil)
//            return
//        }
//
//        func fetchSavedAudioData() -> [SURAH] {
//            let fetchRequest: NSFetchRequest<SURAH> = SURAH.fetchRequest()
//
//            do {
//                let surahs = try context.fetch(fetchRequest)
//                return surahs
//            } catch {
//                print("Fehler beim Abrufen der gespeicherten Audio-Daten: \(error.localizedDescription)")
//                return []
//            }
//        }
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
//
//    func fetchAyahTexts(completion: @escaping ([AyahText]?) -> Void) {
//    }
//}
