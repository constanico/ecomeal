//
//  CustomListView.swift
//  ECOMEAL
//
//  Created by Jason Leonardo on 11/10/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct CustomRowView: View {
    var imageUrl: String
    var title: String
    var subTitle: String
    var isStarRatingVisible: Bool
    var starRating: Double?
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.2), radius: 7.5, y: 5)
            
            VStack(alignment: .leading){
                HStack{
                    VStack{
                        WebImage(url: URL(string: imageUrl))
                            .resizable()
                            .placeholder(Image(systemName: "photo"))
                            .frame(width: 50, height: 50)
                            .cornerRadius(8)
                            .padding(.trailing, 8)
                        if isStarRatingVisible{
                            HStack{
                                
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                if starRating ?? 0 > 0{
                                    Text(String(format: "%.1f", starRating ?? 0))
                                        .foregroundColor(.black).bold().padding(.horizontal, -5)
                                }else{
                                    Text("-")
                                    
                                        .foregroundColor(.black)
                                        .padding(.horizontal, -5)
                                }
                            }.padding(.vertical, 5)
                        }
                    }
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text(title)
                                .bold()
                                .foregroundColor(.black)
                                Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .opacity(0.5)
                            
                            
                        }.padding(.horizontal)
                            .padding(.top, 15)
                        
                        Divider()
                            .background(Color.gray)
                            .frame(height: 1)
                            .padding(.horizontal)
                        Text("\(subTitle)")
                            .foregroundColor(.gray)
                            .foregroundColor(.black)
                            .padding(.vertical, 5)
                            .padding(.horizontal)
                        
                        
                        
                    }.padding(.bottom, 15)
                }.padding(.horizontal, 20)
            }
            Spacer()
        }
    }
}

#Preview {
    CustomRowView(
        imageUrl: "yourImageUrlString",
        title: "iPhone",
        subTitle: "At Apple Park",
        isStarRatingVisible: true,
        starRating: 5.0
    )
}
