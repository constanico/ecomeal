//
//  UserViewModel.swift
//  ECOMEAL
//
//  Created by Jason Leonardo on 10/09/23.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class UserViewModel: ObservableObject {
    private var db = Firestore.firestore()
    
    @Published var user: UserData?
    
    func addUserData(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error creating user: \(error.localizedDescription)")
                completion(false)
            } else {
                print("User created successfully")
                completion(true)
              
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void){
        Auth.auth().fetchSignInMethods(forEmail: email) { (methods, error) in
            if let error = error {
             
                print("Error checking email existence: \(error.localizedDescription)")
                completion(false)
            } else {
                   
                    Auth.auth().signIn(withEmail: email, password: password) { _, signInError in
                        if let signInError = signInError {
                        
                            print("Failed to sign in: \(signInError.localizedDescription)")
                            completion(false)
                        } else {
                     
                            print("Successfully signed in")
                            completion(true)
                        }
                    }
                
            }
        }
        
    }
    
    func fetchUserData() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        db.collection("users").document(userId).getDocument { (document, error) in
            if let document = document, document.exists {
                if let data = try? document.data(as: UserData.self) {
                    self.user = data
                }
            }
        }
    }
}

