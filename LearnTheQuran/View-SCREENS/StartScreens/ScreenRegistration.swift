//////
//////  RegSuccessScreen.swift
//////  LearnTheQuran
//////
//////  Created by Ömer Tarakci on 28.06.23.
////
////
//


import SwiftUI

struct ScreenRegistration: View {
    var backgroundColor: Color {colorScheme == .dark ? Color.black : Color.white}
    var foregroundColor: Color {colorScheme == .dark ? Color.white : Color.black}
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var firebaseFunctions: FirebaseManager
    
    //    @State private var emailError: String?
    //    @State private var confirmEmailError: String?
    //    @State private var passwordError: String?
    //    @State private var confirmPasswordError: String?
    //    @State private var registrationMessage: String?
    
    var body: some View {
        
        VStack(spacing: 20) {
            Rectangle()
                .frame(width: 80, height: 4)
                .foregroundColor(foregroundColor)
                .offset(y: 0)
            
            
            headerView
                .offset(y: 40)
            
            VStack(spacing: 6) {
                
                emailField
                if let emailError = firebaseFunctions.emailError {
                    Text(emailError).foregroundColor(.red).font(.caption)
                }
                Rectangle()
                    .frame(width: 300, height: 1)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                
                confirmEmailField
                if let confirmEmailError = firebaseFunctions.confirmEmailError {
                    Text(confirmEmailError).foregroundColor(.red).font(.caption)
                }
                Rectangle()
                    .frame(width: 300, height: 1)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                
                passwordField
                if let passwordError = firebaseFunctions.passwordError {
                    Text(passwordError).foregroundColor(.red).font(.caption)
                }
                Rectangle()
                    .frame(width: 300, height: 1)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                
                confirmPasswordField
                if let confirmPasswordError = firebaseFunctions.confirmPasswordError {
                    Text(confirmPasswordError).foregroundColor(.red).font(.caption)
                }
                Rectangle()
                    .frame(width: 300, height: 1)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            }
            .offset(y: -16)
            
            signUpButton
            if let message = firebaseFunctions.registrationMessage {
                Text(message)
                    .foregroundColor(message == "Registrierung erfolgreich" ? .green : .red)
                    .font(.caption)
                    .padding()
            }
            
            Spacer()
        }
        .padding()
        .background(colorScheme == .dark ? Color.black : Color.white)
        .edgesIgnoringSafeArea(.top)
    }
    
    var headerView: some View {
        VStack {
            Text("Quran Harmony")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .padding()
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            
            Image("1024")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Rectangle()
                .frame(width: 300, height: 1)
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                .offset(y: 40)
            Text("Registriere dich, um immer up-to-date zu bleiben. Du erhälst einen Newsletter, indem wir Dir einen Service bieten, Dich regelmäßig mit islamischen Content zu beliefern.")
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .multilineTextAlignment(.leading)
                .font(.system(size: 14))
                .frame(width: 300, height: 150)
            Rectangle()
                .frame(width: 300, height: 1)
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                .offset(y: -40)
        }
    }
    
    
    var emailField: some View {
        
        TextField("E-Mail", text: $firebaseFunctions.email)
                    .textFieldStyle(.plain)
            .onChange(of: firebaseFunctions.email) { _ in firebaseFunctions.validateEmail() }
        //            .offset(y: -40)
        
    }
    
    var confirmEmailField: some View {
        TextField("E-Mail bestätigen", text: $firebaseFunctions.confirmEmail)
        //            .textFieldStyle(.roundedBorder)
            .onChange(of: firebaseFunctions.confirmEmail) { _ in firebaseFunctions.validateConfirmEmail() }
        //            .offset(y: -40)
    }
    
    var passwordField: some View {
        SecureField("Passwort", text: $firebaseFunctions.password)
            .opacity(1.5)
        //            .textFieldStyle(.roundedBorder)
            .onChange(of: firebaseFunctions.password) { _ in firebaseFunctions.validatePassword() }                /*.offset(y: -40)*/
        
    }
    
    var confirmPasswordField: some View {
        SecureField("Passwort bestätigen", text: $firebaseFunctions.confirmPasswort)
        //            .textFieldStyle(.roundedBorder)
            .onChange(of: firebaseFunctions.confirmPasswort) { _ in firebaseFunctions.validateConfirmPassword() }
        //            .offset(y: -40)
        
    }
    
    var signUpButton: some View {
        Button("Registrieren") {
            firebaseFunctions.register()
            firebaseFunctions.regSuccess()
            
        }
        
        .frame(width: 145, height: 40)
        .background(RoundedRectangle(cornerRadius: 10).fill(LinearGradient(colors: [.pink, .red], startPoint: .top, endPoint: .bottomTrailing)))
        .foregroundColor(.white)
        .padding()
    }
}


struct ScreenRegistration_Previews: PreviewProvider {
    static var previews: some View {
        ScreenRegistration().environmentObject(FirebaseManager())
    }
}


    
    
    //     Validierungsfunktionen
    //        func validateEmail() {
    //            if firebaseFunctions.email.isEmpty {
    //                emailError = "Bitte E-Mail eingeben"
    //            } else if !firebaseFunctions.email.contains("@") {
    //                emailError = "Ungültige E-Mail-Adresse"
    //            } else {
    //                emailError = nil
    //            }
    //        }
    //
    //        func validateConfirmEmail() {
    //            if firebaseFunctions.confirmEmail != firebaseFunctions.email {
    //                confirmEmailError = "E-Mails stimmen nicht überein"
    //            } else {
    //                confirmEmailError = nil
    //            }
    //        }
    //
    //
    //    func validatePassword() {
    //        if firebaseFunctions.password.isEmpty {
    //            passwordError = "Bitte Passwort eingeben"
    //        } else if firebaseFunctions.password.count < 6 {
    //            passwordError = "Passwort muss mindestens 6 Zeichen haben"
    //        } else {
    //            passwordError = nil
    //        }
    //    }
    //
    //    func validateConfirmPassword() {
    //        if firebaseFunctions.confirmPasswort.isEmpty {
    //            confirmPasswordError = "Bitte Passwort bestätigen"
    //        } else if firebaseFunctions.confirmPasswort != firebaseFunctions.password {
    //            confirmPasswordError = "Passwörter stimmen nicht überein"
    //        } else {
    //            confirmPasswordError = nil
    //        }
    //    }
    //
    //    func regSuccess() {
    //        if !firebaseFunctions.email.isEmpty && !firebaseFunctions.password.isEmpty && !firebaseFunctions.confirmEmail.isEmpty && !firebaseFunctions.confirmPasswort.isEmpty {
    //            registrationMessage = "Registrierung erfolgreich"
    //        } else {
    //            registrationMessage = "Ein Fehler ist aufgetreten"
    //        }
    //    }
    
    






//
//import SwiftUI
//
//struct ScreenRegistration: View {
////--------------------------------------------------------------------------------------------//
//    var backgroundColor: Color {colorScheme == .dark ? Color.black : Color.white}
//    var foregroundColor: Color {colorScheme == .dark ? Color.white : Color.black}
//    @Environment(\.colorScheme) var colorScheme
//    @EnvironmentObject var firebaseFuntions : FirebaseManager
//
//    @State private var isEmailValid = true
//    @State private var isEmailMatch = true
//
//
//    @State private var emailError: String?
//    @State private var passwordError: String?
//    @State private var confirmEmailError: String?
//    @State private var confirmPasswordError: String?
////--------------------------------------------------------------------------------------------//
//
//    var body: some View {
//        VStack{
//            Rectangle()
//                .frame(width: 80, height: 4)
//                .foregroundColor(foregroundColor)
//                .offset(y: 8)
//            //                .padding(.top)
//            Spacer()
//                .padding(8)
//
//
//            VStack(spacing: 12){
//                Text("Quran Harmony")
//                    .font(.system(size: 32, weight: .bold, design: .rounded))
//                    .padding()
//                    .font(.system(size: 40))
//                    .foregroundColor(foregroundColor)
//                    .offset(y: 0)
//
//                Image("1024")
//                    .resizable()
//                    .frame(width: 100, height: 100)
//                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular)
//                        .path(in: CGRect(x: 0, y: 0, width: 100, height: 100)))//                    .cornerRadius()
//
//                VStack{
//                    Rectangle()
//                        .frame(width: 300, height: 1)
//                        .foregroundColor(foregroundColor)
//                        .offset(y: 40)
//                    Text("Registriere dich, um immer up-to-date zu bleiben. Du erhälst einen Newsletter, indem wir Dir einen Service bieten, Dich regelmäßig mit islamischen Content zu beliefern.")
//                        .font(.system(size: 14, weight: .bold, design: .rounded))
//                        .multilineTextAlignment(.leading)
//                        .font(.system(size: 14))
//                        .frame(width: 300, height: 150)
//                    //.padding(.leading, 10)
//                        .foregroundColor(foregroundColor)
//                    Rectangle()
//                        .frame(width: 300, height: 1)
//                        .foregroundColor(foregroundColor)
//                        .offset(y: -40)
//                }
//                .offset(y: -35)
//
//            }.offset(y: -100)
//
//
////--------------------------------------------------------------------------------------------
//            VStack{
//                Rectangle()
//                    .frame(width: 300, height: 1)
//                    .foregroundColor(foregroundColor)
//                TextField("E-Mail", text: $firebaseFuntions.email)
//                    .font(.system(size: 16, design: .rounded))
//                    .foregroundColor(foregroundColor)
//                //                        .textFieldStyle(.plain)
//                    .foregroundColor(isEmailValid ? foregroundColor : .red)
//                    .onChange(of: firebaseFuntions.email) { newValue in
//                        isEmailValid = newValue.contains("@")
//                    }
//                    .textFieldStyle(.plain)
//                //                        .frame(maxWidth: .infinity, alignment: .leading)
//                Rectangle()
//                    .frame(width: 300, height: 1)
//                    .foregroundColor(foregroundColor)
//
////--------------------------------------------------------------------------------------------
//
//
//                TextField("E-Mail", text: $firebaseFuntions.email)
//                    .onChange(of: firebaseFuntions.email) { _ in validateEmail() }
//                if let emailError = emailError {
//                    Text(emailError).foregroundColor(.red).font(.caption)
//                }
//
//                // E-Mail Bestätigungs Eingabefeld und Fehlermeldung
//                TextField("E-Mail bestätigen", text: $firebaseFuntions.confirmEmail)
//                    .onChange(of: firebaseFuntions.confirmEmail) { _ in validateConfirmEmail() }
//                if let confirmEmailError = confirmEmailError {
//                    Text(confirmEmailError).foregroundColor(.red).font(.caption)
//                }
//
//                // Passwort Eingabefeld und Fehlermeldung
//                SecureField("Passwort", text: $firebaseFuntions.password)
//                    .onChange(of: firebaseFuntions.password) { _ in validatePassword() }
//                if let passwordError = passwordError {
//                    Text(passwordError).foregroundColor(.red).font(.caption)
//                }
//
//                // Passwort Bestätigungs Eingabefeld und Fehlermeldung
//                SecureField("Passwort bestätigen", text: $firebaseFuntions.confirmPasswort)
//                    .onChange(of: firebaseFuntions.confirmPasswort) { _ in validateConfirmPassword() }
//                if let confirmPasswordError = confirmPasswordError {
//                    Text(confirmPasswordError).foregroundColor(.red).font(.caption)
//                }
//
//                // Dein Registrierungsbutton...
//            }
//            .padding()
//            .background(backgroundColor)
//        }
//
//
//
////                TextField("E-Mail bestätigen", text: $firebaseFuntions.confirmEmail)
////                    .font(.system(size: 16, design: .rounded))
////                    .foregroundColor(foregroundColor)
////                    .foregroundColor(isEmailMatch ? foregroundColor : .red)
////                    .onChange(of: firebaseFuntions.confirmEmail) { newValue in
////                        isEmailMatch = (newValue == firebaseFuntions.email)
////                    }
////                    .textFieldStyle(.plain)
////                Rectangle()
////                    .frame(width: 300, height: 1)
////                    .foregroundColor(foregroundColor)
////--------------------------------------------------------------------------------------------
//
////                SecureField("Password", text: $firebaseFuntions.password)
////                    .foregroundColor(foregroundColor)
////                    .textFieldStyle(.plain)
////                Rectangle()
////                    .frame(width: 300, height: 1)
////                    .foregroundColor(foregroundColor)
////--------------------------------------------------------------------------------------------
//
////                SecureField("Password", text: $firebaseFuntions.confirmPasswort)
////                    .foregroundColor(foregroundColor)
////                    .textFieldStyle(.plain)
////                Rectangle()
////                    .frame(width: 300, height: 1)
////                    .foregroundColor(foregroundColor)
////
////
////                if firebaseFuntions.showConfirmPasswortt {
////                    SecureField("confirm Password", text: $firebaseFuntions.confirmPasswort)
////                        .foregroundColor(.white)
////                        .textFieldStyle(.plain)
////
////                    Rectangle()
////                        .frame(width: 300, height: 1)
////                        .foregroundColor(.white)
////                }
//
//
//
//                TextField("E-Mail", text: $firebaseFuntions.email)
//                    .onChange(of: firebaseFuntions.email) { _ in validateEmail() }
//                if let emailError = emailError {
//                    Text(emailError).foregroundColor(.red).font(.caption)
//                }
//
//                TextField("E-Mail bestätigen", text: $firebaseFuntions.confirmEmail)
//                    .onChange(of: firebaseFuntions.confirmEmail) { _ in validateConfirmEmail() }
//                if let confirmEmailError = confirmEmailError {
//                    Text(confirmEmailError).foregroundColor(.red).font(.caption)
//                }
//
//
//
//
//
////--------------------------------------------------------------------------------------------
//
//                Button{
//                    firebaseFuntions.userIsLoggedIn = false
//                    //firebaseFuntions.showConfirmPasswortt.toggle()
//                    firebaseFuntions.register()
////                    firebaseFuntions.showToast(message: "Registrieren erfolgriech")
//
//                } label: {
//                    Text("Sign Up")
//                        .bold()
//                        .frame(width: 145, height: 40)
//                        .background(
//                        RoundedRectangle(cornerRadius: 10, style: .continuous)
//                        .fill(.linearGradient(colors: [.pink, .red], startPoint: .top, endPoint: .bottomTrailing))
//                        ).foregroundColor(.white)
//                        .offset(y: 50)
//                }
//                Spacer()
//            }
//            .offset(y: -130)
//        }
//        .edgesIgnoringSafeArea(.top)
//    }
//
//    func validateEmail() {
//        if firebaseFuntions.email.isEmpty {
//            emailError = "Bitte E-Mail eingeben"
//        } else if !firebaseFuntions.email.contains("@") {
//            emailError = "Ungültige E-Mail-Adresse"
//        } else {
//            emailError = nil
//        }
//    }
//
//    func validateConfirmEmail() {
//        if firebaseFuntions.confirmEmail != firebaseFuntions.email {
//            confirmEmailError = "E-Mails stimmen nicht überein"
//        } else {
//            confirmEmailError = nil
//        }
//    }
//
//
//    func validatePassword() {
//        if firebaseFuntions.password.isEmpty {
//            emailError = "Bitte E-Mail eingeben"
//        } else if !firebaseFuntions.password.contains("@") {
//            emailError = "Ungültige E-Mail-Adresse"
//        } else {
//            emailError = nil
//        }
//    }
//
//    func validateConfirmPassword() {
//        if firebaseFuntions.confirmPasswort != firebaseFuntions.confirmPasswort {
//            confirmEmailError = "E-Mails stimmen nicht überein"
//        } else {
//            confirmEmailError = nil
//        }
//    }
//
//
//
//
//
//}
//
//
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
