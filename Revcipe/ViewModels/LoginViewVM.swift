//
//  LoginViewVM.swift
//  Revcipe
//
//  Created by SamuelJ on 10/8/23.
//
import FirebaseAuth
import Foundation

class LoginViewVM: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {
    }
    
    func login() {
        guard validate() else {return}
        Auth.auth().signIn(withEmail: email, password: password, completion: handleLoginError)
    }
    
    func validate() -> Bool {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields"
            return false
        }
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email"
            return false
        }
        guard password.count >= 6 else {
            errorMessage = "Please use a longer password"
            return false
        }
        return true
    }
    
    func handleLoginError(authResult: AuthDataResult?, error: Error?) {
        if error != nil {
            errorMessage = "Error signing in"
        }
    }
}

