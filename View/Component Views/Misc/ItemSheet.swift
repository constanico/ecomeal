//
//  ItemSheet.swift
//  ECOMEAL
//
//  Created by Jason Leonardo on 12/10/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ItemSheet: View {
    var imageUrl: String
    var itemName: String
    var itemPrice: Int
    var itemQuantity: Int
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            ZStack{
                Color(ColorString.lightGreen.colorText)
                ScrollView{
                    VStack{
                        ZStack {
                            
                            VStack{
                                HStack {
                                    WebImage(url: URL(string: imageUrl))
                                        .resizable()
                                        .placeholder(Image(systemName: "photo"))
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(8)
                                        .padding(.trailing, 8)
                                    
                                    VStack{
                                        Text(itemName)
                                            .bold()
                                        Text(currencyString + "\(itemPrice)")
                                    }
                                    
                                    
                                }
                                
                                HStack{
                                    Button(action: {
                                        
                                        
                                    }) {
                                        Text("-")
                                            .foregroundColor(.white)
                                            .font(.system(size: 30))
                                            .frame(width: 50, height: 50)
                                            .background(.green)
                                            .cornerRadius(50)
                                    }.shadow(color: .gray, radius: 3, x: 0, y: 2)
                                        .padding(.vertical)
                                    
                                    Text("\(itemQuantity)")
                                        .font(.title3)
                                        .bold()
                                        .padding(.horizontal)
                                    
                                    Button(action: {
                                        
                                        
                                    }) {
                                        Text("+")
                                            .foregroundColor(.white)
                                            .font(.system(size: 30))
                                            .frame(width: 50, height: 50)
                                            .background(.green)
                                            .cornerRadius(50)
                                    }.shadow(color: .gray, radius: 3, x: 0, y: 2)
                                        .padding(.vertical)
                                    
                                }.padding()
                                
                                
                                
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    
                                    Text("Update Cart")
                                        .foregroundColor(.white)
                                        .bold()
                                        .frame(width: 300, height: 50)
                                        .background(.green)
                                        .cornerRadius(12)
                                }
                                
                            }
                            
                            
                        }.padding(.horizontal, 30)
                            .padding(.vertical)
                        
                    }
                    .padding(.vertical, 2)
                    .padding(.horizontal, 15)
                }
            }.navigationTitle("Edit Cart Item")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing:
                                        Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                }
                                    
                )
            
            
        }.frame(maxHeight: 350)
            .edgesIgnoringSafeArea(.all)
        
    }
}


#Preview {
    ItemSheet(imageUrl: "", itemName: "Apple Juice", itemPrice: 10000, itemQuantity: 2)
}
