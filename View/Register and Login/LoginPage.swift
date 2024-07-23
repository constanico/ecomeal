//
//  LoginPage.swift
//  ECOMEAL
//
//  Created by Jason Leonardo on 10/09/23.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct LoginPage: View {
    
    @State private var emailField: String = ""
    @State private var passwordField: String = ""
    @State private var showAlert = false
    
    @ObservedObject var userViewModel = UserViewModel()
    var body: some View {
        VStack{
        
            Text("ECOMEAL")
                .font(.title)
                .bold()
                .padding()
            
            TextField("Email", text: $emailField)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .padding(.horizontal, 30)
            
            SecureField("Password", text: $passwordField)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .padding(.horizontal, 30)
                .padding(.bottom, 50)
            
            Button(action: {
                userViewModel.signIn(email: emailField, password: passwordField){ success in
                    if success{
                        print("Success")
                    }else{
                        showAlert = true
                        print("Account not found")
                    }
                }
            }) {
                Text("Log in")
                    .foregroundColor(.white)
                    .bold()
                    .frame(width: 300, height: 50)
                    .background(.blue)
                    .cornerRadius(12)
            }
            .padding()
            .padding(.bottom, 30)
            .alert("Invalid email or password.", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
            
            Text("Don't have an account?")
            
            Button(action: {
           
            }) {
                Text("Register an account")
                    .bold()
            }
            .padding()
            
            
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
