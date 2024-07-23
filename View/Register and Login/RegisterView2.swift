//
//  RegisterView2.swift
//  ECOMEAL
//
//  Created by Jason Leonardo on 10/09/23.
//

import SwiftUI

struct RegisterView2: View {
    @State private var nameField: String = ""
    @State private var addressField: String = ""
    var body: some View {
        
        NavigationView {
            VStack {
                
                Text("Register an account")
                    .font(.title)
                    .bold()
                    .padding()
                
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.gray)
                
                TextField("Enter name", text: $nameField)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .padding(.horizontal, 30)
                
                HStack{
                    Text("Enter your address")
                        .multilineTextAlignment(.leading)
                    Spacer()
                }.padding(.horizontal)
                
                
                TextEditor(text: $addressField)
                    .frame(height: 100) // Set a minimum height for the TextEditor
                
                    .border(Color.gray, width: 1)
                    .padding()
                
                
                
                
                
                Button(action: {
                    
                }) {
                    Text("Register")
                        .frame(width: 300, height: 50)
                        .foregroundColor(.white)
                        .bold()
                }
                .background(Color.blue)
                .cornerRadius(12)
                .padding()
                .padding(.bottom, 30)
                
                
                
            }
        }
    }
}

struct RegisterView2_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView2()
    }
}
