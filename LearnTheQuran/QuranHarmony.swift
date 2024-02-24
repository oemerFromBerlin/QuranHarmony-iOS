import UIKit
import SwiftUI
import Firebase
import AVFoundation
import GoogleMobileAds

@main
struct QuranHarmony: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var ayahPlayer = AyahhPlayer(ayahs: [], textRepository: TextRepository())
    let firebaseManager = FirebaseManager()
    let adManager = AdManager.shared // Erstellen Sie eine Instanz von AdManager


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
                .environmentObject(firebaseManager)
                .environmentObject(ayahPlayer)
                .environmentObject(adManager) 
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
        // Initialisieren des Google Mobile Ads SDK
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
    }
}
