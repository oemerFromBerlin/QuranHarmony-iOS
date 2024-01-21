//
//  Repository.swift
//  LearnTheQuran
//
//  Created by Ömer Tarakci on 28.06.23.
//

import Foundation

//import Foundation
//import CoreData
//
//class Repository {
//    private let context: NSManagedObjectContext
//    @Published var list = [SurahAudio]()
//
//    init(context: NSManagedObjectContext) {
//        self.context = context
//    }
//
//    func fetchAudioData(completion: @escaping (ResponseAudio?) -> Void) {
//        guard let url = URL(string: "http://api.alquran.cloud/v1/quran/de.bubenheim")
//        else {
//            print("Ungültige URL")
//            completion(nil)
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("Fehler: \(error.localizedDescription)")
//                completion(nil)
//                return
//            }
//
//            guard let data = data else {
//                print("Keine Daten empfangen")
//                completion(nil)
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let responseAudio = try decoder.decode(ResponseAudio.self, from: data)
//                completion(responseAudio)
//                DispatchQueue.main.async {
//                    self.list = responseAudio.data
//                    print(self.list)
//                }
//            } catch {
//                print("Fehler bei der JSON-Dekodierung: \(error.localizedDescription)")
//                completion(nil)
//            }
//        }.resume()
//    }
//
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



// hier kommt die DatenLogik
// bsplw. structs
// api 1 sura
// api 2 audio
// api 3 für deutsche übersetzung
// api 4 für türkisch usw
// funktion, die alle daten in die coredata gespeichert werden können, wo schon alles drinne ist
