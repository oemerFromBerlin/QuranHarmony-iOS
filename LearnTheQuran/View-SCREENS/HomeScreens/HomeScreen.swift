//
//  FavoriteScreen.swift
//  LearnTheQuran
//
//  Created by Ömer Tarakci on 28.06.23.
//


import SwiftUI

struct HomeScreen: View {
    @StateObject  var textRepository = TextRepository()
    @StateObject var audioRepository = AudioRepository()
    @StateObject var taskViewModel = FavViewModel()

    @Environment(\.colorScheme) var colorScheme

    var backgroundColor: Color {
        return colorScheme == .dark ? .black : .white
    }

    var foregroundColor: Color {
        return colorScheme == .dark ? .white : .black
    }

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor
                    .ignoresSafeArea(.all)

                ForEach(circles, id: \.id) { circle in
                    FloatingCircle(size: circle.size, xPosition: circle.xPosition, blurRadius: circle.blurRadius, color: circle.color)
                }

                VStack(spacing: 30) {
                    
                    Button(action: {
                        print("Button wurde gedrückt!")
                    }) {
                        Image(systemName: "gear")
                            .foregroundColor(foregroundColor)
                    }
                    .onAppear {
                        print("minusminusminus)")
                    }
                    .offset(x: 160, y: 20)
                    
                    Text("﷽")
                        .font(Font.custom("Scheherazade", size: 40))
                        .font(.title)
                        .padding()
                        .foregroundColor(foregroundColor)
                        .offset(y: -70)
                    
                    Text("Qur'an Harmony")
                        .foregroundColor(foregroundColor)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .offset(y: -105)

                    Text("Dies ist das Buch, an dem es keinen Zweifel gibt, eine Rechteitung für die Gottesfürchtigen.(Qur'an, 2:2)")
                        .foregroundColor(foregroundColor)
                        .multilineTextAlignment(.trailing)
                        .padding(.horizontal, 16)
                        .offset(y: -110)
                    
                    CustomButton(title: "Hören", destination: AnyView(SurahListeAudio()), accentColor: foregroundColor)

                    CustomButton(title: "Lesen", subtitle: "Weiterlesen", destination: AnyView(ListReadScreen()), accentColor: foregroundColor)

                    CustomButton(title: "Favoriten", destination: AnyView(FavoriteScreen()), accentColor: foregroundColor)
                }
                .padding(30)
            }
//            .border(Color.gray.opacity(0.5), width: 1)
            .navigationTitle("")
        }
        .environmentObject(taskViewModel)
        .environmentObject(textRepository)
        .environmentObject(audioRepository)
    }
}

struct CustomButton: View {
    var title: String
    var subtitle: String? = nil
    var destination: AnyView
    var accentColor: Color

    var body: some View {
        NavigationLink(destination: destination) {
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.clear)                    .overlay(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(accentColor, lineWidth: 1)
                    )

                VStack {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(accentColor)
                    if let sub = subtitle {
                        Text(sub)
                            .font(.caption)
                            .foregroundColor(accentColor.opacity(0.7))
                            .padding(.top, 5)
                    }
                }
            }
            .frame(height: 80)
        }
    }
}

struct FloatingCircle: View {
    let size: CGFloat
    let xPosition: CGFloat
    let blurRadius: CGFloat
    let color: Color
    @State private var startY = false

    var body: some View {
        Circle()
            .frame(width: size, height: size)
            .foregroundColor(color.opacity(0.4))
            .blur(radius: blurRadius)
            .position(x: xPosition, y: startY ? UIScreen.main.bounds.height + size : -size)
            .onAppear() {
                withAnimation(Animation.easeInOut(duration: Double.random(in: 15...20))) { //.repeatForever(autoreverses: false)) {
                    startY.toggle()
                }
            }
    }
}

let circles: [CircleData] = [
    CircleData(id: 1, size: 100, xPosition: 50, blurRadius: 5, color: Color.purple.opacity(0.7)),
    CircleData(id: 2, size: 150, xPosition: 250, blurRadius: 6, color: Color.blue.opacity(0.7)),
    CircleData(id: 3, size: 20, xPosition: 10, blurRadius: 5, color: Color.green.opacity(0.7)),
    CircleData(id: 1, size: 100, xPosition: 70, blurRadius: 5, color: Color.purple.opacity(0.7)),
    CircleData(id: 2, size: 40, xPosition: 90, blurRadius: 6, color: Color.blue.opacity(0.7)),
    CircleData(id: 3, size: 80, xPosition: 30, blurRadius: 5, color: Color.green.opacity(0.7)),
    CircleData(id: 1, size: 200, xPosition: 110, blurRadius: 5, color: Color.purple.opacity(0.7)),
    CircleData(id: 2, size: 230, xPosition: 310, blurRadius: 6, color: Color.blue.opacity(0.7)),
    CircleData(id: 3, size: 130, xPosition: 60, blurRadius: 5, color: Color.green.opacity(0.7))
]



struct CircleData: Identifiable {
    let id: Int
    let size: CGFloat
    let xPosition: CGFloat
    let blurRadius: CGFloat
    let color: Color
}




struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}






//import SwiftUI
//
//struct HomeScreen: View {
//    @StateObject  var textRepository = TextRepository()
//    @StateObject var audioRepository = AudioRepository()
//    @StateObject var favViewModel = TaskViewModel()
//
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                Color.black
//                    .ignoresSafeArea(.all)
//
//                VStack(spacing: 30) {
//                    Spacer()
//
//                    CustomButton(title: "Hören", destination: AnyView(SurahListeAudio()), accentColor: Color.purple.opacity(0.7))
//
//                    CustomButton(title: "Lesen", subtitle: "Weiterlesen", destination: AnyView(ListReadScreen()), accentColor: Color.blue.opacity(0.7))
//
//                    CustomButton(title: "Favoriten", destination: AnyView(FavoriteScreen()), accentColor: Color.green.opacity(0.7))
//
//                    Spacer()
//                }
//                .padding(30)
//            }
//            .navigationTitle("Home")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//        .environmentObject(taskViewModel)
//        .environmentObject(textRepository)
//        .environmentObject(audioRepository)
//    }
//}
//
//struct CustomButton: View {
//    var title: String
//    var subtitle: String? = nil
//    var destination: AnyView
//    var accentColor: Color
//
//    var body: some View {
//        NavigationLink(destination: destination) {
//            ZStack {
//                RoundedRectangle(cornerRadius: 20, style: .continuous)
//                    .fill(Color.black.opacity(0.85))
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 20, style: .continuous)
//                            .stroke(accentColor, lineWidth: 2)
//                    )
//
//                VStack {
//                    Text(title)
//                        .font(.title2)
//                        .fontWeight(.medium)
//                        .foregroundColor(accentColor)
//                    if let sub = subtitle {
//                        Text(sub)
//                            .font(.caption)
//                            .foregroundColor(accentColor.opacity(0.7))
//                            .padding(.top, 5)
//                    }
//                }
//            }
//            .frame(height: 80)
//        }
//    }
//}
//
//struct HomeScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeScreen()
//    }
//}
//







//struct HomeScreen: View {
//    @StateObject  var textRepository = TextRepository()
//    @StateObject var audioRepository = AudioRepository()
//    @StateObject var taskViewModel = TaskViewModel()
//
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                Color.black
//                    .ignoresSafeArea(.all)
//
//                VStack(spacing: 16) {
//                    Spacer()
//
//                    NavigationLink(destination: SurahListeAudio()) {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 33, style: .continuous)
//                                .fill(.linearGradient(colors: [.black.opacity(0.9), .blue, .green], startPoint: .top, endPoint: .bottomTrailing))
//                                .shadow(color: .init(white: 1.0), radius: 33)
//                            Text("Hören")
//                                .font(.title)
//                                .foregroundColor(.white)
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                                .frame(maxHeight: .infinity)
//                        }
//
//                        .foregroundColor(.white)
//                        .cornerRadius(33)
//                    }
////                    .environmentObject(taskViewModel)
////                    .environmentObject(textRepository)
////                    .environmentObject(audioRepository)
//
//
//
//                    NavigationLink(destination: ListReadScreen()) {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 33, style: .continuous)
//                                .fill(.linearGradient(colors: [.black.opacity(0.9), .green, .blue], startPoint: .top, endPoint: .bottomTrailing))
//                                .shadow(color: .init(white: 1.0), radius: 3)
//                            VStack{
//                                Text("Lesen")
//                                    .font(.title)
//                                    .foregroundColor(.white)
//                                    .padding()
//                                    .frame(maxWidth: .infinity)
//                                    .frame(maxHeight: .infinity)
//                                Text("Weiterlesen")
//                                    .font(.title)
//                                    .foregroundColor(.white)
//                                    .padding()
//                                    .frame(maxWidth: .infinity)
//                                    .frame(maxHeight: .infinity)
//                            }
//                        }
//                        .foregroundColor(.white)
//                        .cornerRadius(33)
//                    }
//
//
//
//
//                    NavigationLink(destination: FavoriteScreen()) {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 33, style: .continuous)
//                                .fill(.linearGradient(colors: [.black.opacity(0.9), .red, .pink], startPoint: .top, endPoint: .bottomTrailing))
//                                .shadow(color: .init(white: 1.0), radius: 3)
//                            Text("Favoriten")
//                                .font(.title)
//                                .foregroundColor(.white)
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                                .frame(maxHeight: .infinity)
//                        }
//                        .foregroundColor(.white)
//                        .cornerRadius(33)
//                    }
////                    .environmentObject(taskViewModel)
////                    .environmentObject(textRepository)
////                    .environmentObject(audioRepository)
//
//
//
//
//                    Spacer()
//                }
//                .padding()
//            }
////            .navigationBarTitleDisplayMode(.inline)
//            .navigationTitle("Home")
//            .offset(y: 0)
////            .navigationBarItems(leading: Text("").foregroundColor(.white).font(.title2))
//
//        }
//        .environmentObject(taskViewModel)
//        .environmentObject(textRepository)
//        .environmentObject(audioRepository)
//    }
//}
//
//struct HomeScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeScreen()
//    }
//}
