//
//  SurahReadScreen.swift
//  LearnTheQuran
//
//  Created by Ömer Tarakci on 28.06.23.
//

import SwiftUI

struct ListReadScreen: View {
    @EnvironmentObject var textRepository: TextRepository
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(spacing: 20) {
            Text("Suren 1-114")
                .font(Font.custom("Scheherazade", size: 24))
                .foregroundColor(Color(UIColor.label))
            
            Text("﷽")
                .font(Font.custom("Scheherazade", size: 40))
                .foregroundColor(Color(UIColor.label))
            
            List {
                ForEach(textRepository.surahs, id: \.number) { surah in
                    NavigationLink(destination: AyahReadScreen(surah: surah)) {
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
                                .foregroundColor(Color(UIColor.label))
                                .multilineTextAlignment(.leading)
                        }
                        .frame(height: 80)
                    }
                    .listRowBackground(Color(UIColor.systemBackground))
                }
            }
            .listStyle(PlainListStyle())
        }
        .padding(.top, 30)
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
    }
}

//            .navigationBarTitle("", displayMode: .inline)
//            .onAppear {
//                let navBarAppearance = UINavigationBarAppearance()
//                navBarAppearance.configureWithOpaqueBackground()
//                navBarAppearance.backgroundColor = UIColor.systemBackground
//                navBarAppearance.titleTextAttributes = [
//                    .foregroundColor: UIColor.label,
//                    .font: UIFont.systemFont(ofSize: 28)
//                ]
//                UINavigationBar.appearance().standardAppearance = navBarAppearance
//                UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
//                UINavigationBar.appearance().compactAppearance = navBarAppearance
//            }
//            .onDisappear {
//                UINavigationBar.appearance().standardAppearance = UINavigationBarAppearance()
//                UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBarAppearance()
//                UINavigationBar.appearance().compactAppearance = UINavigationBarAppearance()
//            }
//        }
//    }
//}

struct ListReadScreen_Previews: PreviewProvider {
    static var previews: some View {
        ListReadScreen()
            .environmentObject(TextRepository())
    }
}











//
//
//struct ListReadScreen: View {
//
//    @EnvironmentObject var textRepository : TextRepository
//
//
////    @StateObject private var textRepository: TextRepository = TextRepository()
//
//    var body: some View {
//        NavigationView{
//            VStack {
//                Text("Suren 1-114")
//                    .font(.title)
//                    .padding()
//                    .foregroundColor(.white)
//                    .offset(y: -120)
//                Text("﷽")
//                    .font(Font.custom("Scheherazade", size: 40))
//                    .font(.title)
//                    .padding()
//                    .foregroundColor(.white)
//                    .offset(y: -80)
//
//                Divider()
//
//                List {
//                    ForEach(textRepository.surahs, id: \.number) { surah in
//                        NavigationLink(destination: AyahReadScreen(surah: surah)) {
//                            VStack {
//                                Text("Surah \(surah.number). \(surah.englishName) (\(surah.englishNameTranslation))")
//                                    .padding(.all, 6)
//                                    .foregroundColor(.white)
//                            }
//                        }
//                        .listRowBackground(Color.black)
//                    }
//                }
//                .padding(.top, -60)
////                .padding(.all, 2)
//
//                .listStyle(PlainListStyle())
////                .navigationBarTitle("Suren 1-114", displayMode: .inline)
//                .foregroundColor(.white)
//            }
//            //            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(Color.black)
//            .environmentObject(textRepository)
//            .onAppear {
//                textRepository.fetchSurahs()
//                UINavigationBar.appearance().isTranslucent = false
//            }
//            .onDisappear {
//                UINavigationBar.appearance().isTranslucent = true
//            }
////            .navigationBarHidden(true)
//        }
////        .edgesIgnoringSafeArea(.all)
//        .listStyle(PlainListStyle())
//    }
//}
//
//struct ListReadScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        ListReadScreen()
//    }
//}
