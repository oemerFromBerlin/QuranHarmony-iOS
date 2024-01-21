//
//  SAVEtheFAVORITE.swift
//  LearnTheQuran
//
//  Created by Ömer Tarakci on 10.08.23.
//

import Foundation
import CoreData


class FavViewModel : ObservableObject {
    let container: NSPersistentContainer
    @Published var favorites: [Favorites] = []
    
    init(){
        container = NSPersistentContainer(name: "CoreData")
        
        container.loadPersistentStores { descripton, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        fetchFavorites()
    }
    
    
    
    func fetchFavorites() {
        let request = NSFetchRequest<Favorites>(entityName: "Favorites")
        
        do{
            favorites = try container.viewContext.fetch(request)
        } catch {
            print("error fetching: \(error)")
        }
    }
    
    
    func saveFavorites(id : Int) {
        let newTask = Favorites(context: container.viewContext)
        newTask.id = Int32(id)
        
        do {
            try container.viewContext.save()
            fetchFavorites()
        } catch {
            print("fehler und so jooo")
        }
    }
    
    func deleteFavorite(id: Int) {
        do {
            container.viewContext.delete(favorites.first(where: { faves in
                faves.id == Int32(id)
            })!)
            try container.viewContext.save()
            fetchFavorites()
        } catch {
            print("Fehler beim Löschen des Tasks: \(error)")
        }
    }
    
    func toggleFavorite(id: Int) {
        if (isFavorite(id : id)) {
            deleteFavorite(id: id)
        } else {
            saveFavorites(id: id)
        }
    }
    
    
    
    func isFavorite(id: Int) -> Bool {
        return favorites.contains { Favorites in
            id == Favorites.id
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //    func updateTask(ayah: Favorites) {
    //        ayah.toggle()
    //
    //        do {
    //            try container.viewContext.save()
    //            fetchTask()
    //        } catch {
    //            print("Error updating task: \(error)")
    //        }
    //    }
}

