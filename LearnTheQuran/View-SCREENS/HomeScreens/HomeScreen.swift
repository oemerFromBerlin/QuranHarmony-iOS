import SwiftUI


// Haupt-HomeScreen-View
struct HomeScreen: View {
//    ------------------------------------------------------------------------------------- //
//    ------------------------------------------------------------------------------------- //
    @StateObject var textRepository = TextRepository()
    @StateObject var audioRepository = AudioRepository()
    @StateObject var taskViewModel = FavViewModel()
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var adManager: AdManager


    var backgroundColor: Color {
        colorScheme == .dark ? Color(UIColor.systemBackground) : Color(UIColor.systemBackground)
    }

    var foregroundColor: Color {
        colorScheme == .dark ? Color.white : Color(UIColor.label)
    }

    var accentColor: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.7), .green.opacity(0.7)]), startPoint: .leading, endPoint: .trailing)
    }

    enum Sprachen {
        case deutsch, englisch, türkisch
    }

    @State private var ausgewählteSprache: Sprachen = .deutsch
    
    func SprachButton(land: String, sprache: Sprachen) -> some View {
        Button(action: {
            ausgewählteSprache = sprache
        }) {
            Text(land)
                .font(.largeTitle)
                .frame(width: 45, height: 45)
                .foregroundColor(ausgewählteSprache == sprache ? .white : foregroundColor)
                .background(ausgewählteSprache == sprache ? foregroundColor : backgroundColor)
                .cornerRadius(30)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(
                            LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.7), .green.opacity(0.7)]), startPoint: .leading, endPoint: .trailing),
                            lineWidth: 1
                        )
                )
        }
    }

    var sprachText: String {
        switch ausgewählteSprache {
        case .deutsch:
            return "Dieses Buch, an dem es keinen Zweifel gibt, ist eine Rechtleitung für die Gottesfürchtigen. (Qur´an 2:2)"
        case .englisch:
            return "This is the exalted Book (the Qur’an), in which there is no place for doubt; a guidance for the pious.(Quran 2:2)"
        case .türkisch:
            return "İşte sana o Kitap! Kuşku/ çelişme/ tutarsızlık yok onda. Bir kılavuzdur o, sakınanlar için.(Kuran 2:2)"
        }
    }

    // Kreisdaten für den HomeScreen
    let circles: [CircleData] = [
        CircleData(id: 1, size: 100, xPosition: .random(in: 0...UIScreen.main.bounds.width), blurRadius: 2, color: Color.blue.opacity(0.7)),
        CircleData(id: 3, size: 150, xPosition: .random(in: 0...UIScreen.main.bounds.width), blurRadius: 6, color: Color.green.opacity(0.7)),
        CircleData(id: 4, size: 75, xPosition: .random(in: 0...UIScreen.main.bounds.width), blurRadius: 5, color: Color.purple.opacity(0.5)),
        CircleData(id: 5, size: 225, xPosition: .random(in: 0...UIScreen.main.bounds.width), blurRadius: 5, color: Color.orange.opacity(0.5)),
        CircleData(id: 6, size: 30, xPosition: .random(in: 0...UIScreen.main.bounds.width), blurRadius: 5, color: Color.red.opacity(0.7)),
        CircleData(id: 7, size: 180, xPosition: .random(in: 0...UIScreen.main.bounds.width), blurRadius: 5, color: Color.black.opacity(0.7)),
        CircleData(id: 8, size: 20, xPosition: .random(in: 0...UIScreen.main.bounds.width), blurRadius: 5, color: Color.green.opacity(0.5)),
        CircleData(id: 9, size: 200, xPosition: .random(in: 0...UIScreen.main.bounds.width), blurRadius: 5, color: Color.white.opacity(0.7)),
        CircleData(id: 10, size: 200, xPosition: .random(in: 0...UIScreen.main.bounds.width), blurRadius: 5, color: Color.black.opacity(0.7)),
    ]

//    ------------------------------------------------------------------------------------- //
//    ------------------------------------------------------------------------------------- //
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor.edgesIgnoringSafeArea(.all)

                // Schwebende Kreise hinter den UI-Elementen
                ForEach(circles) { circle in
                    FloatingCircles(size: circle.size,/* xPosition: circle.xPosition,*/ blurRadius: circle.blurRadius, color: circle.color)
                }

                VStack {
                    HStack {
                        Spacer()
                        NavigationLink(destination: SettingView()) {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(.red.opacity(0.7))
                                .font(.system(size: 16))
                        }
                    }
                    .padding()

                    Spacer()
                    VStack{
                    VStack(spacing: 20) {
                        Text("Qur'an Harmony")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(foregroundColor)
                            .offset(y: -60)
                        
                        Text("﷽")
                            .font(.custom("Scheherazade", size: 40))
                            .foregroundColor(foregroundColor)
                            .offset(y: -80)
                        
                        
                        HStack(spacing: 50) {
                            SprachButton(land: "🇩🇪", sprache: .deutsch)
                            SprachButton(land: "🇬🇧", sprache: .englisch)
                            SprachButton(land: "🇹🇷", sprache: .türkisch)
                        }
                        .padding(.horizontal)
                        .offset(y: -70)
                        
                        Text(sprachText)
                            .foregroundColor(foregroundColor)
                            .font(.system(size: 16))
                            .padding(10)
                            .frame(width: 300, height: 80) // Setze die Breite explizit auf 300 Punkte
                            .background(RoundedRectangle(cornerRadius: 20).fill(foregroundColor.opacity(0.1))/*.opacity(0.55)*/)
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(accentColor, lineWidth: 1))
                            .offset(y: -70)
                    }

                        CustomButton(title: "Hören", destination: AnyView(SurahListeAudio()), accentColor: foregroundColor, backgroundColor: .clear.opacity(0.85))
                        CustomButton(title: "Lesen", subtitle: "Weiterlesen", destination: AnyView(ListReadScreen()), accentColor: foregroundColor, backgroundColor: .clear.opacity(0.85))
                        CustomButton(title: "Favoriten", destination: AnyView(FavoriteScreen()), accentColor: foregroundColor, backgroundColor: .clear.opacity(0.85))
                    }

                    Spacer()
                }
            }
            .navigationTitle("")
            .animation(.easeInOut, value: ausgewählteSprache)
        }
        .environmentObject(taskViewModel)
        .environmentObject(textRepository)
        .environmentObject(audioRepository)
    }
    
    private func showInterstitialAd() {
        if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
            adManager.showInterstitialAd(from: rootViewController)
        } else {
            print("RootViewController not found.")
        }
    }
}






struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
