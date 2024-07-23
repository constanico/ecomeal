//
//  RegisterView.swift
//  ECOMEAL
//
//  Created by Jason Leonardo on 10/09/23.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var emailField: String = ""
    @State private var passwordField: String = ""
    @State private var confirmPasswordField: String = ""
    
    @State private var showAlert = false
    @State private var showAlertFormat = false
    @State private var navigateToRegisterView2 = false // State variable to control navigation
    
    @ObservedObject var userViewModel = UserViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Register an account")
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
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .padding(.horizontal, 30)
                
                SecureField("Confirm Password", text: $confirmPasswordField)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .padding(.horizontal, 30)
                
                Button(action: {
                    if passwordField != confirmPasswordField {
                        showAlert = true
                    } else if passwordField.isEmpty || confirmPasswordField.isEmpty {
                        showAlert = true
                    }
                    else {
                        // If the conditions are met, navigate to RegisterView2
                        userViewModel.addUserData(email: emailField, password: passwordField){
                            success in
                            if success{
                                navigateToRegisterView2 = true
                            }else{
                                showAlertFormat = true
                            }
                        }
                        
                    }
                }) {
                    Text("Next")
                        .frame(width: 300, height: 50)
                        .foregroundColor(.white)
                        .bold()
                }
                .background(Color.blue)
                .cornerRadius(12)
                .padding(.top, 75)
                .padding(.bottom, 30)
                .alert("Passwords do not match.", isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                }
                .alert("That email address is invalid.", isPresented: $showAlertFormat) {
                    Button("OK", role: .cancel) { }
                }
                
                // NavigationLink to RegisterView2
                NavigationLink(
                    destination: RegisterView2(),
                    isActive: $navigateToRegisterView2,
                    label: {
                        EmptyView()
                    })
                    .hidden()
            }.onAppear {
                userViewModel.fetchUserData() // Fetch data when the view appears
            }
        }
    }
    
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
