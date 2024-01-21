//
//  HomeScreen.swift
//  LearnTheQuran
//
//  Created by Ömer Tarakci on 28.06.23.
//

import SwiftUI

struct FavoriteScreen: View {
    @Environment(\.colorScheme) var colorScheme

    @EnvironmentObject private var textRepository: TextRepository
    @EnvironmentObject private var favoritesManager: FavViewModel

    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor.edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer(minLength: 20)

                    Text("Favoriten")
                        .font(Font.custom("Scheherazade", size: 24))
                        .foregroundColor(.orange)

//                    Divider().background(foregroundColor)

                    List {
                        ForEach(textRepository.surahs, id: \.number) { surah in
                            ForEach(surah.ayahs.filter { favoritesManager.isFavorite(id: $0.number) }) { ayah in
                                NavigationLink(destination: AyahReadScreen(surah: surah, scrollToAyah: ayah.id)) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                                            .fill(backgroundColor.opacity(0.85))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                                    .stroke(LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .leading, endPoint: .trailing), lineWidth: 2)
                                            )

                                        VStack(alignment: .leading) {
                                            Text("Surah: \(surah.number) - \(surah.englishName)")
                                                .font(.system(size: 16))
                                                .padding(.all, 6)
                                                .foregroundColor(foregroundColor)

                                            Divider()

                                            Text("\(ayah.numberInSurah) - \(ayah.text)")
                                                .multilineTextAlignment(.leading)
                                                .font(.system(size: 16))
                                                .padding(.all, 6)
                                                .foregroundColor(foregroundColor)
                                        }
                                    }
                                    .padding(.vertical)
                                }
                                .listRowBackground(backgroundColor)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
                .offset(y: 70)
                .onAppear {
                    textRepository.fetchSurahs()
                }
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("Favoriten", displayMode: .inline)
            .background(NavigationConfigurator { nc in
                nc.navigationBar.barTintColor = UIColor(backgroundColor)
                nc.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(foregroundColor)]
            })
        }
    }

    private var backgroundColor: Color {
        return colorScheme == .dark ? Color.black : Color.white
    }

    private var foregroundColor: Color {
        return colorScheme == .dark ? Color.white : Color.black
    }
}



struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }
}





struct FavoriteScreen_Previews: PreviewProvider {
    static var previews: some View {
        let sampleAyahs = [
            AyahText(number: 0, text: "", numberInSurah: 2, juz: 2, manzil: 2, page: 2, ruku: 2, hizbQuarter: 2),
            AyahText(number: 0, text: "", numberInSurah: 3, juz: 3, manzil: 3, page: 3, ruku: 3, hizbQuarter: 3),
        ]
        
        let sampleSurah = SurahTexte(number: 1, name: "Al-Fatiha", englishName: "The Opening", englishNameTranslation: "The Opening", revelationType: "Meccan", ayahs: sampleAyahs)
        
        let textRepo = TextRepository()
        textRepo.surahs = [sampleSurah]
        
//        FavoritesManager.shared.addFavorite(ayahNumber: 2)
        
        return FavoriteScreen()
    }
}







//struct FavoriteScreen: View {
//    @EnvironmentObject private var audioRepository: AudioRepository
//    @StateObject private var textRepository: TextRepository = TextRepository()
//    private let favoritesManager = FavoritesManager.shared
//
//    var body: some View {
//        NavigationView {
//            List {
////                ForEach(textRepository.surahs ) { surah in
////                    surah.ayahs.filter( favoritesManager.isFavorite(ayahs.number))
////                    NavigationLink(destination: AyahReadScreen(surah: surah))
////                }
//            }
//
////            { favoritesManager.isFavorite($0.number) }
////            NavigationLink(destination: AyahReadScreen(surah: surah)) {
////                Text("Surah \(surah.number). \(surah.englishName)")
////            }
//
//
//            .navigationTitle("Favoriten")
//            .onAppear {
//                textRepository.fetchSurahs()
//            }
//        }
//    }
//}
//
//struct FavoriteScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteScreen()
//            .environmentObject(AudioRepository())
//    }
//}
