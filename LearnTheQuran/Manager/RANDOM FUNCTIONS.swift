//
//  RANDOM FUNCTIONS.swift
//  LearnTheQuran
//
//  Created by Ömer Tarakci on 24.07.23.
//


import Foundation
import Firebase
import Toast
import SwiftUI
import AVFoundation


class AlleFunktionen : ObservableObject {
    @State private var selectedAyah: AyahAudio?
    
    
//    MARK: funk. LogIn
    func logIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print("unknown User. Please Sign In !\(error!.localizedDescription) jojo")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    //    MARK: funk. Registrieren
    func registerr(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print("\(error!.localizedDescription) joösoxkvjo")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    //    MARK: funk. Toaster
    func showToast(message: String) {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            scene.windows.first?.rootViewController?.view.makeToast(message, duration: 2.0, position: .center)
        }
    }
    
    
    //    MARK: funk. aus "AyahPlayerScreen"
    //    TODO: diese func von ayahplayerscreen löschen und von hier aus darauf zugreifen
    private func timeString(from time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    //    MARK: funk. aus "AyahListenView"
    //    TODO: diese func von ayahplayerscreen löschen und von hier aus darauf zugreifen
    //    "selectedAyah" ist eine var, welche in "AyahListenView" deklariert wurde. ggf hier implementieren
    private func backgroundColor(for ayah: AyahAudio) -> Color {
        if let selectedAyah = selectedAyah {
            if ayah.id == selectedAyah.id {
                return .yellow
            }
        }
        return .clear
    }
}
    

