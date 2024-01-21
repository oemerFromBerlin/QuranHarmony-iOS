//
//  LearnTheQuranApp.swift
//  LearnTheQuran
//
//  Created by Ömer Tarakci on 28.06.23.
//

import UIKit
import SwiftUI
import Firebase
import AVFoundation

@main
struct LearnTheQuranApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var ayahPlayer = AyahhPlayer(ayahs: [], textRepository: TextRepository())

    init() {
        FirebaseApp.configure()
        
        // Anpassung der Navigation Bar
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .black
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }

    var body: some Scene {
        WindowGroup {
            RegScreen()
                .environmentObject(ayahPlayer)
                .onAppear {
                    do {
                        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
                        print("Playback OK")
                        try AVAudioSession.sharedInstance().setActive(true)
                        print("Session is Active")
                    } catch {
                        print(error)
                    }
                }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print(">> your code here !!")
        return true
    }
}
