//
//  StarRatingView.swift
//  ECOMEAL
//
//  Created by Jason Leonardo on 08/10/23.
//

import SwiftUI

struct StarRatingView: View {
    var size: Double
    @Binding var rating: Double
    
    var body: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: rating >= Double(index) ? "star.fill" : "star")
                    .resizable()
                    .frame(width: size, height: size)
                    .foregroundColor(.yellow)
                    .onTapGesture {
                        rating = rating == Double(index) ? Double(index - 1) : Double(index)
                    }
                    .padding(.horizontal, 5)
            }
        }
    }
}


#Preview {
    StarRatingView(size: 25, rating: .constant(3.0))
}
