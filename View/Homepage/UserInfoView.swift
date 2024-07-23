//
//  UserInfoView.swift
//  ECOMEAL
//
//  Created by Jason Leonardo on 04/10/23.
//

import SwiftUI
import FirebaseAuth

struct UserInfoView: View {
    @State private var loggedOut = false
    @State private var showAlert = false
    @Binding var loggedIn: Bool
    var body: some View {
        NavigationView{
            if Auth.auth().currentUser?.uid != nil{
                VStack{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: 200, height: 200)
                        .padding()
                        .padding(.top, 70)
                    
                    
                    Text("Current user ID: \(Auth.auth().currentUser?.uid ?? "User ID is null")").bold().padding()
                    Text("Current user email: \(Auth.auth().currentUser?.email ?? "User email is null")").bold().padding(.horizontal)
                    
                    Button(action: {
                        showAlert = true
                    }) {
                        Text("Log out")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .padding(.top, 50)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Are you sure you want to log out?"),
                            primaryButton: .cancel(),
                            secondaryButton: .destructive(Text("Log out")) {
                                do {
                                    try Auth.auth().signOut()
                                    loggedIn = false
                                    
                                } catch let signOutError as NSError {
                                    print("Error signing out: \(signOutError.localizedDescription)")
                                }
                            }
                        )
                    }
                    Spacer()
                    
                    
                }.navigationBarTitle("Profile")
            }else{
                LoginPage()
            }
            
            
        }
    }
}

#Preview {
    UserInfoView(loggedIn: .constant(true))
}
