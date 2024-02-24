//
//  SettingView.swift
//  LearnTheQuran
//
//  Created by Ömer Tarakci on 19.02.24.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var textHeight: CGFloat = 0 // Variable für die Text-Höhe
    @State private var ausgewählteSprache: Sprachen = .deutsch
    enum Sprachen {
        case deutsch
        case englisch
        case türkisch
    }
    var sprachText: String {
        switch ausgewählteSprache {
        case .deutsch:
            return """
            Liebe Geschwister im Glauben und liebe Freunde,
            
            As-Salamu Alaykum
            
            Vielen Dank, dass Du dich für unsere App Quran Harmony entschieden hast!
            
            Entdeckt mit unserer App die Weisheiten des Quran in einem schlichten, aber eleganten Design. Sie erleichtert den Zugang zu den heiligen Schriften und vertieft eure Glaubensverbindung. Werdet Teil unserer Gemeinschaft.
            
            Die App ist für alle zugänglich und wird bald auch im türkischen und englischem verfügbar sein. Eure Sicherheit und Privatsphäre sind gesichert; wir speichern nur eure E-Mail für den Newsletter (sofern Du dich registrierst).
            
            Unsere App ist kostenfrei, doch eure Unterstützung durch Feedback, Anregungen und Spenden hilft uns, unseren Service kontinuierlich zu verbessern. Möge Allah uns rechtleiten.
            
            Wenn Du dein uns Feedback geben möchtest, kannst Du uns über folgende E-Mail kontaktieren:
            oemer36@hotmail.de
            
            Wenn auch Du uns finanziell unterstützen möchtest, kannst Du uns durch freiwillige Spenden unterstützen. Einfach via PayPal "Geld an einen Freund senden" an:
            oemer36@hotmail.de
            
            In Verbundenheit,
            Ömer Tarakci
            CEO Quran Harmony
            """
        case .englisch:
            return """
            Dear brothers and sisters in faith and dear friends,
            
            As-Salamu Alaykum,
            
            Thank you for choosing our app, Quran Harmony!
            
            Discover the wisdoms of the Quran through our app's simple yet elegant design. It facilitates access to the sacred scriptures and deepens your connection to faith. Become part of our community.
            
            The app is accessible to all and will soon be available in Turkish and English. Your security and privacy are assured; we only store your email for the newsletter (if you register).
            
            Our app is free, but your support through feedback, suggestions, and donations helps us continuously improve our service. May Allah guide us rightly.
            
            If you would like to provide us with feedback, you can contact us via the following email:
            oemer36@hotmail.de
            
            If you would also like to support us financially, you can do so through voluntary donations. Simply use PayPal to "Send money to a friend" at:
            oemer36@hotmail.de
            
            With kind regards,
            Ömer Tarakci
            CEO of Quran Harmony
            """
        case .türkisch:
            return """
            Sevgili inanç kardeşlerimiz ve değerli dostlarımız,
            
            As-Salamu Alaykum
            
            Quran Harmony uygulamamızı seçtiğiniz için teşekkür ederiz!
            
            Uygulamamız ile Kuran'ın hikmetlerini sade fakat şık bir tasarımda keşfedin. Kutsal yazılara erişimi kolaylaştırır ve inancınızla bağınızı derinleştirir. Topluluğumuzun bir parçası olun.
            
            Uygulamamız herkese açıktır ve yakında Türkçe ve İngilizce olarak da kullanılabilecek. Güvenliğiniz ve gizliliğiniz garanti altındadır; yalnızca haber bülteni için e-postanızı saklarız (kayıt olursanız).
            
            Uygulamamız ücretsizdir, ancak geri bildirimleriniz, önerileriniz ve bağışlarınız servisimizi sürekli iyileştirmemize yardımcı olur. Allah bizi doğru yola iletir.
            
            Bize geri bildirimde bulunmak isterseniz, aşağıdaki e-posta adresi üzerinden bizimle iletişime geçebilirsiniz:
            oemer36@hotmail.de
            
            Maddi olarak destek olmak isterseniz, PayPal üzerinden "Bir arkadaşa para gönder" seçeneği ile gönüllü bağışta bulunabilirsiniz:
            oemer36@hotmail.de
            
            Saygılarımızla,
            Ömer Tarakci
            Quran Harmony CEO'su
            """
        }
    }
    
    var backgroundColor: Color {
        colorScheme == .dark ? .black : .white
    }
    
    var foregroundColor: Color {
        colorScheme == .dark ? .white : .black
    }
    
    var accentColor: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.7), .green.opacity(0.7)]), startPoint: .leading, endPoint: .trailing)
    }
    
    let circles: [CircleData] = [
        CircleData(id: 1, size: 100, xPosition: .random(in: 0...UIScreen.main.bounds.width), blurRadius: 2, color: Color.blue.opacity(0.7)),
        CircleData(id: 3, size: 150, xPosition: .random(in: 0...UIScreen.main.bounds.width), blurRadius: 6, color: Color.green.opacity(0.7)),
        CircleData(id: 4, size: 75, xPosition: .random(in: 0...UIScreen.main.bounds.width), blurRadius: 5, color: Color.purple.opacity(0.5)),
        CircleData(id: 5, size: 225, xPosition: .random(in: 0...UIScreen.main.bounds.width), blurRadius: 5, color: Color.orange.opacity(0.5)),
        CircleData(id: 6, size: 30, xPosition: .random(in: 0...UIScreen.main.bounds.width), blurRadius: 5, color: Color.red.opacity(0.7)),
        CircleData(id: 7, size: 180, xPosition: .random(in: 0...UIScreen.main.bounds.width), blurRadius: 5, color: Color.black.opacity(0.7)),
        CircleData(id: 8, size: 20, xPosition: .random(in: 0...UIScreen.main.bounds.width), blurRadius: 5, color: Color.green.opacity(0.5)),
        CircleData(id: 9, size: 200, xPosition: .random(in: 0...UIScreen.main.bounds.width), blurRadius: 5, color: Color.white.opacity(0.7)),
        CircleData(id: 10, size: 200, xPosition: .random(in: 0...UIScreen.main.bounds.width), blurRadius: 5, color: Color.black.opacity(0.6)),
    ]
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                ForEach(circles) { circle in
                    FloatingCircles(size: circle.size, blurRadius: circle.blurRadius, color: circle.color)
                }
                VStack{
                SprachauswahlButtons
                ScrollView {
                    VStack(spacing: 20) {
                        Text(sprachText)
                            .font(.system(size: 16))
                            .padding()
                            .foregroundColor(foregroundColor)
                            .background(RoundedRectangle(cornerRadius: 10).fill(foregroundColor.opacity(0.1)))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(accentColor, lineWidth: 2))
                    }.padding()
                }
            }
            }.navigationTitle("Über Quran Harmony")
                .toolbarBackground(Color.clear, for: .navigationBar)
            
        }
    }
    
    
    var SprachauswahlButtons: some View {
        HStack(spacing: 50) {
            SprachButton(land: "🇩🇪", sprache: .deutsch)
            SprachButton(land: "🇬🇧", sprache: .englisch)
            SprachButton(land: "🇹🇷", sprache: .türkisch)
        }
        .padding(.horizontal)
    }
    
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
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
