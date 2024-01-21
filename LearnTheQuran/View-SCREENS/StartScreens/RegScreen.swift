//
//  RegScreen.swift
//  LearnTheQuran
//
//  Created by Ömer Tarakci on 28.06.23.
//


import SwiftUI
import Firebase
import Toast

extension View {
    func placeholder<Content: View>( when shouldShow: Bool, alignment: Alignment = .leading, @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}


struct RegScreen: View {
    
    @Environment(\.colorScheme) var colorScheme // Dies wird verwendet, um das aktuelle Farbschema zu überprüfen
    
    @State private var email = ""
    @State private var password = ""
    @State private var userIsLoggedIn = false
    @State private var confirmPasswort = ""
    @State private var showConfirmPasswortt = false
    
    // Farben für den Hintergrund und die Textfelder entsprechend dem Farbschema
    var backgroundColor: Color {
        colorScheme == .dark ? Color.black : Color.white
    }
    
    var foregroundColor: Color {
        colorScheme == .dark ? Color.white : Color.black
    }
    
    var body: some View {
        if userIsLoggedIn {
            HomeScreen()
        } else {
            content
        }
    }
    
    
    var content: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundColor(backgroundColor.opacity(0.8))
                .frame(width: 350, height: 400)
                .offset(y: -50)
            
            VStack(spacing: 20){
                Text("SelamuAleykum")
                .foregroundColor(foregroundColor)
                .font(.system(size: 32, weight: .bold, design: .rounded))
                
                TextField("E-Mail", text: $email)
                .foregroundColor(foregroundColor)
                .textFieldStyle(.plain)
                
                Rectangle()
                .frame(height: 1)
                .foregroundColor(foregroundColor)
                
                SecureField("Password", text: $password)
                .foregroundColor(foregroundColor)
                .textFieldStyle(.plain)
                
                Rectangle()
                .frame(height: 1)
                .foregroundColor(foregroundColor)
                
                //  dieser Block soll erscheinen, wenn User auf "SignUp" Button klickt
                if showConfirmPasswortt {
                    SecureField("confirm Password", text: $confirmPasswort)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    
                    Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.white)
                }
                // bis hier hin
                
                VStack{
                    HStack{
                        Button{
                            logIn()
                        } label: {
                            Text("Login")
                                .bold()
                                .frame(width: 145, height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.linearGradient(colors: [.green, .blue], startPoint: .top, endPoint: .bottomTrailing))
                            )
                         .foregroundColor(.white)
                        }
                        
                        Button{
                            showConfirmPasswortt.toggle()
                            registerr()
                        } label: {
                            Text("Sign Up")
                                .bold()
                                .frame(width: 145, height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.linearGradient(colors: [.pink, .red], startPoint: .top, endPoint: .bottomTrailing))
                          ).foregroundColor(.white)
                        }
                    }
                    

                    Button{
                        userIsLoggedIn = true
                    } label: {
                        Text("Skip an use lightversion")
                            .bold()
                            .frame(width: 300, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.linearGradient(colors: [.blue, .green], startPoint: .top, endPoint: .bottomTrailing))
                            ).foregroundColor(.white)
                    }
                }
            }.frame(width: 300)
        }
    }
    
    
func logIn() {
     Auth.auth().signIn(withEmail: email, password: password) { result, error in
        if let error = error {
           if error._code == AuthErrorCode.wrongPassword.rawValue {
             print("\(error) Falsches Passwort!")
             showToast(message: "Falsches Passwort!")
                } else if error._code == AuthErrorCode.userNotFound.rawValue {
                    print("\(error) Benutzer nicht gefunden!")
                    showToast(message: "Benutzer nicht gefunden!")
                } else {
                    print("\(error) Ein unerwarteter Fehler ist aufgetreten.")
                    showToast(message: "Ein unerwarteter Fehler ist aufgetreten.")
                }
                } else {
                userIsLoggedIn = true
                showToast(message: "SelamuAleykum")
            }
        }
    }
    
    
func registerr() {
     Auth.auth().createUser(withEmail: email, password: password) {
     result, error in
       if error != nil {
           print("\(error!.localizedDescription) joösoxkvjo")
           showToast(message: "Sie wurden erfolgreich registriert")
            }
        }
    }
    
    
func showToast(message: String) {
     if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            scene.windows.first?.rootViewController?.view.makeToast(message, duration: 8.0, position: .top)
        }
    }
}



struct RegScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RegScreen()
                .environment(\.colorScheme, .light)
            
            RegScreen()
                .environment(\.colorScheme, .dark)
        }
    }
}
