//
//  AddBusinessView.swift
//  ECOMEAL
//
//  Created by Jason Leonardo on 07/10/23.
//

import SwiftUI

struct AddBusinessView: View {
    @ObservedObject var cartViewModel = CartViewModel()
    @ObservedObject var businessViewModel = BusinessViewModel()
    @ObservedObject var itemViewModel = ItemViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @State private var latitude: Double = 0
    @State private var longitude: Double = 0
    
    var body: some View {
        NavigationView{
            VStack{
                EditableMarkerMapView(latitude: $latitude, longitude: $longitude)
                
                Button(action: {
                    let businessId = UUID().uuidString
                    let newBusiness = Business(businessId: businessId, businessName: "iPhone", businessRating: 4.5, businessLatitude: latitude, businessLongitude: longitude, businessAddress: "At Park West 12345 Street next to your mom's house")
                    
                    businessViewModel.addBusiness(uuid: businessId, business: newBusiness, image: UIImage(named: "BusinessIcon"))
                    
                    let newItems = businessItemsDummy
                    
                    for item in newItems{
                        itemViewModel.addItem(toBusiness: businessId, item: item, image: UIImage(named: "FoodIcon"))
                    }
                    
                    businessViewModel.fetchBusinesses()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Add Business")
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 300, height: 50)
                        .background(.green)
                        .cornerRadius(12)
                }
                .padding()
               
            }
            .navigationTitle("Map View")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing:
                                        Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                )
        }
    }
}

#Preview {
    AddBusinessView()
}
