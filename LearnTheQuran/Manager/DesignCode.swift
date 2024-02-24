//
//  DesinFrameWorks.swift
//  LearnTheQuran
//
//  Created by Ömer Tarakci on 23.02.24.
//

import Foundation
import SwiftUI




//--------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------//

struct CircleData: Identifiable {
    let id: Int
    let size: CGFloat
    let xPosition: CGFloat
    let blurRadius: CGFloat
    let color: Color
}


struct FloatingCircles: View {
    let size: CGFloat
    let blurRadius: CGFloat
    let color: Color
    @State private var position = CGPoint(x: .random(in: 0...UIScreen.main.bounds.width), y: .random(in: 0...UIScreen.main.bounds.height)) // Startposition

    let animation = Animation
        .linear(duration: 33)
        .repeatForever(autoreverses: true)
        .speed(3.3)

    var body: some View {
        Circle()
//            .stroke(color, lineWidth: 1)
            .frame(width: size, height: size)
            .foregroundColor(color.opacity(0.4))
            .blur(radius: 33)
            .position(position)
            .onAppear() {
                withAnimation(self.animation) {
                    // Zufällige Endposition innerhalb der Bildschirmgrenzen
                    position = CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                                       y: CGFloat.random(in: 0...UIScreen.main.bounds.height))
                }
            }
    }
}

//--------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------//
//Button für HomeScreen Hören, Lesen, Favoriten
struct CustomButton: View {
    var title: String
    var subtitle: String? = nil
    var destination: AnyView?
    var accentColor: Color
    var backgroundColor: Color

    var body: some View {
        NavigationLink(destination: destination) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(backgroundColor.opacity(0.77))
                    .shadow(radius: 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
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
            .frame(width: 300, height: 80)
        }
    }
}

//--------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------//

struct LanguageButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 20))
                .foregroundColor(.primary)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10)/*.fill(accentColor)*/)
                .shadow(radius: 5)
        }
    }
}

//--------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------//

// Für die Surah Liste Buttons nach Homescreen zu Hören & Lesen
//struct SurahRow: View {
//    var surah: SurahObjects // Verwenden Sie hier die tatsächliche Datenstruktur SurahObjects
//    
//    var body: some View {
//        ZStack {
//            RoundedRectangle(cornerRadius: 20, style: .continuous)
//                .fill(Color(UIColor.systemBackground).opacity(0.85))
//                .overlay(
//                    RoundedRectangle(cornerRadius: 20, style: .continuous)
//                        .stroke(LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .leading, endPoint: .trailing), lineWidth: 2)
//                )
//            
//            HStack {
//                Text("Surah \(surah.number). \(surah.englishName) (\(surah.englishNameTranslation))")
//                    .font(.system(size: 16))
//                    .foregroundColor(Color.primary)
//                Spacer()
//            }
//            .padding(.all, 6)
//        }
//        .frame(height: 80)
//    }
//}



//struct FloatingCircles: View {
//    let size: CGFloat
//    let xPosition: CGFloat
//    let blurRadius: CGFloat
//    let color: Color
//    @State private var startY = false
//
//    var body: some View {
//        Circle()
//            .frame(width: size, height: size)
//            .foregroundColor(color.opacity(0.4))
//            .blur(radius: blurRadius)
//            .position(x: xPosition, y: startY ? UIScreen.main.bounds.height + size : -size)
//            .onAppear() {
//                withAnimation(Animation.interpolatingSpring(stiffness: 1, damping: 5).repeatForever(autoreverses: true)) {
//                    startY.toggle()
//                }
//            }
//
//    }
//}


