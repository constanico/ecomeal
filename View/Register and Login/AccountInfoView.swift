//
//  AccountInfoView.swift
//  ECOMEAL
//
//  Created by Jason Leonardo on 05/09/23.
//

import SwiftUI

struct AccountInfoView: View {
    
    @ObservedObject var viewModel = UserViewModel()
    
    @State private var emailField: String = ""
    @State private var passwordField: String = ""
    @State private var nameField: String = ""
    @State private var addressField: String = ""
    
    var body: some View {
        VStack {
            // Text fields for adding new data
            TextField("Email", text: $emailField)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 30)
                .padding(.horizontal)
            
            TextField("Password", text: $passwordField)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            TextField("Name", text: $nameField)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            TextField("Address", text: $addressField)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button(action: {
//                viewModel.addUserData(email: emailField, password: passwordField)// Fetch data after adding
            }) {
                Text("Add Data")
            }
            .padding()
            
            // List to display fetched data
            //                List(viewModel.users, id: \.name) { user in
            //                    VStack(alignment: .leading) {
            //                        Text("Email: \(user.email)")
            //                        Text("Password: \(user.password)")
            //                        Text("Name: \(user.name)")
            //                        Text("Email: \(user.address)")
            //                    }
            //                }
            //            }
            .onAppear {
                viewModel.fetchUserData() // Fetch data when the view appears
            }
        }}
    
    struct AccountInfoView_Previews: PreviewProvider {
        static var previews: some View {
            AccountInfoView()
        }
    }
}
