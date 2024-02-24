////
////  RegSuccessScreen.swift
////  LearnTheQuran
////
////  Created by Ömer Tarakci on 28.06.23.
//
//
//import SwiftUI
//
//struct ScreenRegistration: View {
////--------------------------------------------------------------------------------------------//
//
//    var backgroundColor: Color {colorScheme == .dark ? Color.black : Color.white}
//    var foregroundColor: Color {colorScheme == .dark ? Color.white : Color.black}
//    @Environment(\.colorScheme) var colorScheme
//    @EnvironmentObject var firebaseFuntions : FirebaseManager
//
////--------------------------------------------------------------------------------------------//
//    
//    
//    var body: some View {
//        ZStack {
//            backgroundColor
//                .edgesIgnoringSafeArea(.all)
//            
//            RoundedRectangle(cornerRadius: 30, style: .continuous)
//                .foregroundColor(backgroundColor.opacity(0.8))
//                .frame(width: 350, height: 400)
//                .offset(y: -50)
//            
//            VStack(spacing: 20){
//                Text("Quran Harmony")
//                    .foregroundColor(foregroundColor)
//                    .font(.system(size: 32, weight: .bold, design: .rounded))
//                
//                TextField("E-Mail", text: $firebaseFuntions.email)
//                    .foregroundColor(foregroundColor)
//                    .textFieldStyle(.plain)
//                
//                Rectangle()
//                    .frame(height: 1)
//                    .foregroundColor(foregroundColor)
//                
//                SecureField("Password", text: $firebaseFuntions.password)
//                    .foregroundColor(foregroundColor)
//                    .textFieldStyle(.plain)
//                
//                Rectangle()
//                    .frame(height: 1)
//                    .foregroundColor(foregroundColor)
//                
//                
//                if firebaseFuntions.showConfirmPasswortt {
//                    SecureField("confirm Password", text: $firebaseFuntions.confirmPasswort)
//                        .foregroundColor(.white)
//                        .textFieldStyle(.plain)
//                    
//                    Rectangle()
//                        .frame(height: 1)
//                        .foregroundColor(.white)
//                }
//                
//            }
//        }
//    }
//}
//
//
//struct ScreenRegistration_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            ScreenRegistration()
//                .environment(\.colorScheme, .light)
//            
//            ScreenRegistration()
//                .environment(\.colorScheme, .dark)
//        }
//    }
//}
//
//
