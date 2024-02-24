import SwiftUI

struct ListReadScreen: View {
    @EnvironmentObject var textRepository: TextRepository
    @State var suchText = ""
    
    var filteredSurahs: [SurahTexte] {
        if suchText.isEmpty {
            return textRepository.surahs
        } else {
            return textRepository.surahs.filter { surah in
                surah.englishName.lowercased().contains(suchText.lowercased()) ||
                surah.englishNameTranslation.lowercased().contains(suchText.lowercased()) ||
                surah.name.lowercased().contains(suchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("﷽")
                    .font(Font.custom("Scheherazade", size: 40))
                    .foregroundColor(Color.primary)
                    .padding(.vertical)
                    .textCase(nil)
                    .frame(maxWidth: .infinity, alignment: .center)) {
                    
                    ForEach(filteredSurahs, id: \.number ) { surah in
                        NavigationLink(destination: AyahReadScreen(surah: surah)) {
                            SurahRowView(surah: surah)
                                .listRowBackground(Color(UIColor.systemBackground))

                        }
                        .listRowBackground(Color(UIColor.systemBackground))
                    }
                }
            }
            .searchable(text: $suchText, prompt: "Suche Surah")
            .listStyle(InsetGroupedListStyle()) // Verwenden Sie den gewünschten List-Style
            .onAppear {
                textRepository.fetchSurahs()
            }
        }
        .navigationTitle("Suren 1-114")
        .toolbarBackground(Color.clear, for: .navigationBar)
    }
}

// Angepasste SurahRow-Komponente für den ListReadScreen
struct SurahRowView: View {
    let surah: SurahTexte
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(UIColor.systemBackground).opacity(0.85))
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .leading, endPoint: .trailing), lineWidth: 2)
                )
            
            Text("Surah \(surah.number). \(surah.englishName) (\(surah.englishNameTranslation))")
                .font(.system(size: 16))
                .padding(.all, 6)
                .foregroundColor(Color.primary)
        }
        .frame(height: 80)
    }
}

struct ListReadScreen_Previews: PreviewProvider {
    static var previews: some View {
        ListReadScreen().environmentObject(TextRepository())
    }
}
