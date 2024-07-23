//
//  EcoPayCardView.swift
//  ECOMEAL
//
//  Created by Jason Leonardo on 15/10/23.
//

import SwiftUI

struct EcoPayCardView: View {
    @ObservedObject var userViewModel = UserViewModel()
    var body: some View {
        ZStack{
            Rectangle()
            
                .foregroundColor(Color(ColorString.darkGreen.colorText))
                .cornerRadius(20)
                .frame(height: 200)
                .shadow(radius: 3, y: 3)
            
            VStack{
                HStack{
                    Text("EcoPay").bold()
                        .foregroundColor(.white)
                    Spacer()
                    Text("\(currencyString)" + "\(String(format: "%.0f", userViewModel.currentUser?.ecoPayBalance ?? 0))")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                }.padding()
                Spacer()
                

                
                Spacer()
                HStack{
                    VStack{
                        Button(action: {
                            
                        }) {
                            VStack{
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                                    .bold()
                                Text("Top up")
                                    .font(.footnote)
                                    .foregroundColor(.white)
                            }.frame(width: 70, height: 70)
                                .background(Color.white.opacity(0.15))
                                .cornerRadius(12)
                        }
                        
                    }.padding(.horizontal, 5)
                    
                    VStack{
                        Button(action: {
                            
                        }) {
                            VStack{
                                Image(systemName: "qrcode.viewfinder")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                                    .bold()
                                Text("Pay")
                                    .font(.footnote)
                                    .foregroundColor(.white)
                            }.frame(width: 70, height: 70)
                                .background(Color.white.opacity(0.15))
                                .cornerRadius(12)
                        }
                        
                    }.padding(.horizontal, 5)
                    
                    VStack{
                        Button(action: {
                            
                        }) {
                            VStack{
                                Image(systemName: "clock")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                                    .bold()
                                Text("History")
                                    .font(.footnote)
                                    .foregroundColor(.white)
                            }.frame(width: 70, height: 70)
                                .background(Color.white.opacity(0.15))
                                .cornerRadius(12)
                        }
                        
                    }.padding(.horizontal, 5)
                }
            }.padding()
            .padding(.bottom, 5)
        }.padding()
    }
}

#Preview {
    EcoPayCardView()
}
