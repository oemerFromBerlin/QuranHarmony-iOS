//
//  SurahTexte.swift
//  LearnTheQuran
//
//  Created by Ömer Tarakci on 28.06.23.
//

import Foundation

struct SurahTexte: Codable, Identifiable {
    var id: Int {number}
    let number: Int
    let name: String
    let englishName: String
    let englishNameTranslation: String
    let revelationType: String
    let ayahs: [AyahText]
//    var isFavorite: Bool
    var isFavorite: Bool {
        return FavoritesManager.shared.isFavorite(number)
    }
}
