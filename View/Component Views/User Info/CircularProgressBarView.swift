//
//  CircularProgressBarView.swift
//  ECOMEAL
//
//  Created by Jason Leonardo on 15/10/23.
//

import SwiftUI

struct CircularProgressBarView: View {
    var weightSaved: Double
    var progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.green.opacity(0.3),
                    lineWidth: 30
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.green,
                    style: StrokeStyle(
                        lineWidth: 30,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(90))
               
                .animation(.easeOut, value: progress)
            
            VStack{
                Text("\(String(format: "%.1f", weightSaved / 1000)) kg")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color(ColorString.darkGreen.colorText))
                
                Text("food waste saved")
                    .foregroundColor(Color(ColorString.darkGreen.colorText).opacity(0.75))
            }

        }.padding(.horizontal, 60)
    }
}

#Preview {
    CircularProgressBarView(weightSaved: 300, progress: 0.4)
}
