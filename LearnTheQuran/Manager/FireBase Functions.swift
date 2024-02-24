//
//  FireBase Functions.swift
//  LearnTheQuran
//
//  Created by Ömer Tarakci on 13.02.24.
//

import Foundation
import SwiftUI
import Firebase
import Toast
import FirebaseAuth


class FirebaseManager: ObservableObject {
    
    @Published var screen : ScreenRegistration?

    
    @Published  var email = ""
    @Published  var confirmEmail = ""
    @Published  var password = ""
    @Published  var userIsLoggedIn = false
    @Published  var confirmPasswort = ""
    @Published  var showConfirmPasswortt = false
    
    
    @Published var emailError: String?
    @Published var confirmEmailError: String?
    @Published var passwordError: String?
    @Published var confirmPasswordError: String?
    @Published var registrationMessage: String?

    
    
    func logIn() {
        if email.isEmpty {
            print("Bitte Email eingeben")
            self.showToast(message: "Bitte Email eingeben")
            return
        }

        if password.isEmpty {
            print("Bitte Passwort eingeben")
            self.showToast(message: "Bitte Passwort eingeben")
            return
        }
        
                    
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                 let err = error as NSError
                 if let authErrorCode = AuthErrorCode.Code(rawValue: err.code) {
                     
                    switch authErrorCode {
                    case .wrongPassword:
                        print("\(err.localizedDescription) Falsches Passwort!")
                        self.showToast(message: "Falsches Passwort")
                    case .userNotFound:
                        print("\(err.localizedDescription) Benutzer nicht gefunden!")
                        self.showToast(message: "Nutzer nicht gefunden")
                    default:
                        print("\(err.localizedDescription) Überprüfen Sie Ihre Eingabe.")
                        self.showToast(message: "Überprüfen Sie Ihre Eingabe.")
                    }
                }
            } else {
                self.userIsLoggedIn = true
                self.showToast(message: "Erfolgreich eingeloggt!")
            }
        }
    }

    
    func register() {
        // Validierung der Eingabedaten
        guard !email.isEmpty else {
            showToast(message: "Bitte Email eingeben")
            return
        }
        
        guard !password.isEmpty else {
            showToast(message: "Bitte Passwort eingeben")
            return
        }
        
        guard email == confirmEmail else {
            showToast(message: "E-Mails stimmen nicht überein")
            return
        }
        
        guard password == confirmPasswort else {
            showToast(message: "Passwörter stimmen nicht überein")
            return
        }
        

        // Versuch, den Benutzer zu registrieren
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                 let err = error as NSError
                 if let authErrorCode = AuthErrorCode.Code(rawValue: err.code) {
                    
                switch authErrorCode {
                    case .emailAlreadyInUse:
                    print("1")
                        self.showToast(message: "E-Mail wird bereits verwendet")
                    case .weakPassword:
                    print("2--")
                        self.showToast(message: "Passwort ist zu schwach")
                    default:
                        self.showToast(message: "Fehler beim Registrieren:\(error.localizedDescription)")
                    print("3")

                    }
                }
            } else {
                // Registrierung erfolgreich
                self.showToast(message: "Sie wurden erfolgreich registriert")
                print("4")

                // Weitere Aktionen nach erfolgreicher Registrierung, z.B. Übergang zum Login-Bildschirm oder zur Hauptanwendung
            }
        }
    }

    
    
    

//    func registerr() {
//        Auth.auth().createUser(withEmail: email, password: password) {
//         result, error in
//           if error != nil {
//               print("\(error!.localizedDescription) Fehler beim Registrieren")
//               self.showToast(message: "Sie wurden erfolgreich registriert")
//                }
//            }
//        }
    
//    func showToast(message: String) {
//         if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
//                scene.windows.first?.rootViewController?.view.makeToast(message, duration: 2.0, position: .top)
//
//            }
//        
//    }
//    
    func showToast(message: String) {
        DispatchQueue.main.async {
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                scene.windows.first?.rootViewController?.view.makeToast(message, duration: 2.0, position: .bottom)
            }
        }
    }
    
    
    func validateEmail() {
        if email.isEmpty {
            emailError = "Bitte E-Mail eingeben"
        } else if !email.contains("@") { // Korrigiert
            emailError = "Ungültige E-Mail-Adresse"
        } else {
            emailError = nil
        }
    }

    func validateConfirmEmail() {
        if confirmEmail != email {
            confirmEmailError = "E-Mails stimmen nicht überein"
        } else {
            confirmEmailError = nil
        }
    }


func validatePassword() {
    if password.isEmpty {
        passwordError = "Bitte Passwort eingeben" // Korrigiert
    } else if password.count < 6 {
        passwordError = "Passwort muss mindestens 6 Zeichen haben"
    } else {
        passwordError = nil
    }
}

func validateConfirmPassword() {
    if confirmPasswort.isEmpty {
        confirmPasswordError = "Bitte Passwort bestätigen"
    } else if confirmPasswort != password {
        confirmPasswordError = "Passwörter stimmen nicht überein"
    } else {
        confirmPasswordError = nil
    }
}

func regSuccess() {
    if !email.isEmpty && !password.isEmpty && !confirmEmail.isEmpty && !confirmPasswort.isEmpty { // Korrigiert
        registrationMessage = "Registrierung erfolgreich"
    } else {
        registrationMessage = "Ein Fehler ist aufgetreten"
    }
}
    
    
    
    
    
    
    }
    
    


