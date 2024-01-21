//
//  SurahAudio.swift
//  LearnTheQuran
//
//  Created by Ömer Tarakci on 28.06.23.
//

import Foundation

struct SurahObjects: Codable, Identifiable { //Equatable
    var id: Int { number }
    var number: Int
    var name: String
    var englishName: String
    var englishNameTranslation: String
    var revelationType: String
    var ayahs: [AyahAudio]
//    var isFavorite: Bool {
//        return FavoritesManager.shared.isFavorite(number)
//    }
}
//    var isFavorite : Bool = false
    
    enum CodingKeys: String, CodingKey {
        case number
        case name
        case englishName
        case englishNameTranslation
        case revelationType
        case ayahs
//        case isFavorite
    }

