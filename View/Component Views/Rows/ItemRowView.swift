//
//  ItemRowView.swift
//  ECOMEAL
//
//  Created by Jason Leonardo on 12/10/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ItemRowView: View {
    var imageUrl: String
    var itemName: String
    var oldPrice: Double
    var newPrice: Double
    var quantity: Int
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.3), radius: 5, y: 2)
            VStack(alignment: .leading){
                HStack {
                    WebImage(url: URL(string: imageUrl))
                        .resizable()
                        .placeholder(Image(systemName: "photo"))
                        .frame(width: 50, height: 50)
                        .cornerRadius(8)
                        .padding(.trailing, 8)
                    
                    VStack(alignment: .leading) {
                        Text(itemName)
                           .padding(.horizontal)
                            .padding(.bottom, 5)
                        Divider()
                            .background(Color.gray)
                            .frame(height: 1)
                            .padding(.horizontal, 15)
                        Text(currencyString + String(format: "%.2f", oldPrice)).padding(.horizontal)
                            .foregroundColor(.gray)
                            .strikethrough(true)
                        
                        Text(currencyString + String(format: "%.2f", newPrice))
                            .bold()
                            .padding(.horizontal)
                    

                    }
                    Spacer()
                    
                }
                HStack{
                    Spacer()
                    Button(action: {
                        
                        
                    }) {
                        Text("-")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                            .frame(width: 40, height: 40)
                            .background(.green)
                            .cornerRadius(50)
                    }.shadow(color: .gray, radius: 3, x: 0, y: 2)
                    
                    Text("\(quantity)").padding(.horizontal)
                    
                    Button(action: {
                        
                        
                    }) {
                        Text("+")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                            .frame(width: 40, height: 40)
                            .background(.green)
                            .cornerRadius(50)
                    }.shadow(color: .gray, radius: 3, x: 0, y: 2)
                }
                
            }.padding(.horizontal, 30)
                .padding(.vertical)

        }
        .padding(.vertical, 2)
        .padding(.horizontal, 15)
    }
}

#Preview {
    ItemRowView(imageUrl: "", itemName: "Apple Juice", oldPrice: 10000, newPrice: 5000, quantity: 2)
}
