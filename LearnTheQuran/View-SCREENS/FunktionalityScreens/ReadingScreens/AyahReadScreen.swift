//
//  AyahReadScreen.swift
//  LearnTheQuran
//
//  Created by Ömer Tarakci on 28.06.23.
//

import SwiftUI

struct AyahReadScreen: View {
    
    @EnvironmentObject var fav : FavViewModel
    @EnvironmentObject var textRepository: TextRepository
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedAyah: AyahText?
    @State private var heights: [CGFloat] = []
    var surah: SurahTexte
    var scrollToAyah : Int?
    
    init(surah: SurahTexte, scrollToAyah: Int? = nil) {
        self.surah = surah
        self.scrollToAyah = scrollToAyah
        _heights = State(initialValue: Array(repeating: 0, count: surah.ayahs.count))
    }

    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer(minLength: 20)
                
                Text("\(surah.number). \(surah.englishName)")
                    .font(Font.custom("Scheherazade", size: 24))
                    .foregroundColor(foregroundColor)
                
                Text("﷽")
                    .font(Font.custom("Scheherazade", size: 40))
                    .foregroundColor(foregroundColor)
                    .padding(.top, 20)

                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach(Array(surah.ayahs.enumerated()), id: \.element.id) { index, ayah in
                            ZStack {
                                RoundedRectangle(cornerRadius: 3, style: .continuous)
                                    .fill(backgroundColor(for: ayah))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 13, style: .continuous)
                                            .stroke(LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.3), .gray.opacity(0.3)]), startPoint: .leading, endPoint: .trailing), lineWidth: 2)
                                    )
                                    .frame(height: index < heights.count ? heights[index] : 0)
                                
                                HStack {
                                    CopyableTextView(text: "\(ayah.numberInSurah). \(ayah.text)", height: $heights[index])
//                                        .foregroundColor(foregroundColor)
                                        .frame(height: index < heights.count ? heights[index] : 0)
                                        .padding(.all, 8)
                                        .onTapGesture {
                                            selectedAyah = ayah
                                        }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        fav.toggleFavorite(id: ayah.id)
                                        showToast(message: "zu Favoriten hinzugefügt")
                                    }, label: {
                                        Image(systemName: fav.isFavorite(id: ayah.id) ? "bookmark.fill" : "bookmark")
                                            .font(.title2)
                                            .foregroundColor(.orange)
                                            .padding(.trailing, 10)
                                    })
                                }
                            }
                            .id(ayah.id)
                        }
                    }
                    .onAppear {
                        if let scrollToAyah = scrollToAyah {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                proxy.scrollTo(scrollToAyah)
                            }
                        }
                    }
                }
            }
            .onAppear {
                textRepository.fetchSurahs()
            }
        }
    }

    private func backgroundColor(for currentAyah: AyahText) -> Color {
        if let selected = selectedAyah, currentAyah.id == selected.id {
            return .yellow.opacity(0.5)
        } else if currentAyah.numberInSurah % 2 == 0 {
            return colorScheme == .dark ? Color.gray.opacity(0.1) : Color.gray.opacity(0.05)
        }
        return backgroundColor
    }

    private var backgroundColor: Color {
        return colorScheme == .dark ? Color.black : Color.white
    }
    
    private var foregroundColor: Color {
        return colorScheme == .dark ? Color.white : Color.black
    }
}

struct CopyableTextView: UIViewRepresentable {
    var text: String
    @Binding var height: CGFloat

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.backgroundColor = .clear
        textView.delegate = context.coordinator
//        textView.textColor = .white
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        DispatchQueue.main.async {
            height = uiView.contentSize.height
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: CopyableTextView

        init(_ parent: CopyableTextView) {
            self.parent = parent
        }
    }
}

func showToast(message: String) {
    if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
        scene.windows.first?.rootViewController?.view.makeToast(message, duration: 3.0, position: .top)
    }
}

struct AyahReadScreen_Previews: PreviewProvider {
    static var previews: some View {
        let sampleAyahs = [
            AyahText(number: 2, text: "Ein langer Beispieltext, um zu zeigen, wie der Text sich innerhalb der TextView umbricht und vollständig angezeigt wird.", numberInSurah: 2, juz: 2, manzil: 2, page: 2, ruku: 2, hizbQuarter: 2),
            AyahText(number: 3, text: "Ein weiterer Beispieltext.", numberInSurah: 3, juz: 3, manzil: 3, page: 3, ruku: 3, hizbQuarter: 3),
        ]
        
        let sampleSurah = SurahTexte(number: 1, name: "Al-Fatiha", englishName: "The Opening", englishNameTranslation: "The Opening", revelationType: "Meccan", ayahs: sampleAyahs)
        
        return AyahReadScreen(surah: sampleSurah)
            .environmentObject(TextRepository())
    }
}







//struct AyahReadScreen: View {
//
//    @EnvironmentObject var textRepository : TextRepository
//    @State private var selectedAyah: AyahText?
//    @State private var heights: [CGFloat] = []
//    var surah: SurahTexte
//
//
//    init(surah: SurahTexte) {
//        self.surah = surah
//        _heights = State(initialValue: Array(repeating: 0, count: surah.ayahs.count))
//    }
//
//    var body: some View {
//        VStack {
//            Text(surah.englishName)
//                .offset(y: -20)
//            List {
//                ForEach(Array(surah.ayahs.enumerated()), id: \.element.id) { index, ayah in
//                    VStack {
//                        CopyableTextView(text: "\(ayah.numberInSurah). \(ayah.text)", height: $heights[index])
//                            .frame(height: index < heights.count ? heights[index] : 0)
//                            .background(backgroundColor(for: ayah))
//                            .padding(.vertical, 8)
//                    }
//                    .onTapGesture {
//                        selectedAyah = ayah
//                    }
//                    .listRowBackground(Color.black)
//                    Divider()
//                        .background(Color.white)
//                }
//            }
//            .listStyle(PlainListStyle())
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.black)
//        .navigationTitle("\(surah.number). \(surah.englishName)")
//        .navigationBarItems(trailing: Button(action: {
//            // Ihre Action hier
//        }, label: {
//            Image(systemName: "heart") // Beispiel
//                .font(.title)
//                .foregroundColor(.gray)
//        }))
//        .environmentObject(textRepository)
//        .onAppear {
//            textRepository.fetchSurahs()
//            UINavigationBar.appearance().isTranslucent = false
//
//            // Initialisieren Sie das heights Array
//            heights = Array(repeating: 0, count: surah.ayahs.count)
//        }
//        .onDisappear {
//            UINavigationBar.appearance().isTranslucent = true
//        }
//        .foregroundColor(.white)
//        .listStyle(PlainListStyle())
//    }
//
//    private func backgroundColor(for currentAyah: AyahText) -> Color {
//        if let selected = selectedAyah, currentAyah.id == selected.id {
//            return .yellow.opacity(0.3)
//        } else if currentAyah.numberInSurah % 2 == 0 {
//            return Color.gray.opacity(0.1)
//        }
//        return .clear
//    }
//}
//
//struct CopyableTextView: UIViewRepresentable {
//    var text: String
//    @Binding var height: CGFloat
//
//    func makeUIView(context: Context) -> UITextView {
//        let textView = UITextView()
//        textView.isEditable = false
//        textView.isSelectable = true
//        textView.isUserInteractionEnabled = true
//        textView.font = UIFont.systemFont(ofSize: 20)  // Setzen Sie hier die gewünschte Schriftgröße
//        textView.backgroundColor = .clear
//        textView.delegate = context.coordinator
//        return textView
//    }
//
//    func updateUIView(_ uiView: UITextView, context: Context) {
//        uiView.text = text
//        DispatchQueue.main.async {
//            height = uiView.contentSize.height
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, UITextViewDelegate {
//        var parent: CopyableTextView
//
//        init(_ parent: CopyableTextView) {
//            self.parent = parent
//        }
//    }
//}
//
//
//struct AyahReadScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        let sampleAyahs = [
//            AyahText(number: 2, text: "Ein langer Beispieltext, um zu zeigen, wie der Text sich innerhalb der TextView umbricht und vollständig angezeigt wird.", numberInSurah: 2, juz: 2, manzil: 2, page: 2, ruku: 2, hizbQuarter: 2),
//            AyahText(number: 3, text: "Ein weiterer Beispieltext.", numberInSurah: 3, juz: 3, manzil: 3, page: 3, ruku: 3, hizbQuarter: 3),
//        ]
//
//        let sampleSurah = SurahTexte(number: 1, name: "Al-Fatiha", englishName: "The Opening", englishNameTranslation: "The Opening", revelationType: "Meccan", ayahs: sampleAyahs)
//
//        return AyahReadScreen(surah: sampleSurah)
//            .environmentObject(TextRepository())
//    }
//}
