//
//  FavoriteManager.swift
//  LearnTheQuran
//
//  Created by Ömer Tarakci on 20.07.23.
//
//


//ggf das noch in die neue Datei Übernehmen



import Foundation

class FavoritesManager: ObservableObject {
    static let shared = FavoritesManager()
    
    private let favoritesKey = "favoritesKey"
    
    @Published var favorites: Set<Int> = {
        if let favorites = UserDefaults.standard.array(forKey: "favoritesKey") as? [Int] {
            return Set(favorites)
        }
        return Set<Int>()
    }()
    
    func saveFavorites() {
        UserDefaults.standard.set(Array(favorites), forKey: favoritesKey)
    }
    
    func addFavorite(_ surahNumber: Int) {
        favorites.insert(surahNumber)
        saveFavorites()
    }
    
    func removeFavorite(_ surahNumber: Int) {
        favorites.remove(surahNumber)
        saveFavorites()
    }
    
    func isFavorite(_ surahNumber: Int) -> Bool {
        return favorites.contains(surahNumber)
    }
}
