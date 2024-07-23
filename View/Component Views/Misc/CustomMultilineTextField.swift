//
//  CustomMultilineTextField.swift
//  ECOMEAL
//
//  Created by Jason Leonardo on 08/10/23.
//

import SwiftUI

struct CustomMultilineTextField: View {
    var height: Double
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
            
            TextEditor(text: $text)
                .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                .background(Color.clear)
                .foregroundColor(.primary)
                .cornerRadius(10)
                .disableAutocorrection(true)
                .font(.body)
        }
        .frame(height: CGFloat(height)) // Adjust the height as needed
    }
}


#Preview {
    CustomMultilineTextField(height: 120, text: .constant("Text"))
}
