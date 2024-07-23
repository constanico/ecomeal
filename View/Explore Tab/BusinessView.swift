//
//  BusinessView.swift
//  ECOMEAL
//
//  Created by Jason Leonardo on 18/09/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import SDWebImageSwiftUI

struct BusinessView: View {
    
    
    @State private var isCartSheetPresented = false
    @State private var isMapViewShown = false
    
    @ObservedObject var cartViewModel = CartViewModel()
    
    @ObservedObject var businessViewModel = BusinessViewModel()
    
    @ObservedObject var itemViewModel = ItemViewModel()
    
    var body: some View {
        NavigationView {
            List(businessViewModel.businesses) { item in
                HStack{
                    NavigationLink(destination: BusinessDetailView(business: item)) {
                        WebImage(url: URL(string: item.imageUrl ?? ""))
                            .resizable()
                            .placeholder(Image(systemName: "photo"))
                            .frame(width: 50, height: 50)
                            .cornerRadius(8)
                            .padding(.trailing, 8)
                        
                        VStack(alignment: .leading) {
                            Text(item.businessName).bold()
                                .font(.headline).padding()
                            HStack{
                                Image(systemName: "star.fill").padding(.leading).padding(.bottom, 20)
                                Text("\(String(format: "%.1f", item.businessRating))")
                                
                                    .padding(.bottom, 20)
                            }
                        }
                    }
                    
                }
                
            }
            
            .navigationBarTitle("Explore")
            .navigationBarItems(trailing:
                                    Button(action: {
                isCartSheetPresented = true
            }) {
                Image(systemName: "cart")
            }
            )
            .navigationBarItems(trailing:
                                    Button(action: {
                isMapViewShown = true
                
            }) {
                Image(systemName: "doc.badge.plus")
            }
            )
           
        }
        
        
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $isCartSheetPresented) {
            ShoppingCartView(viewModel: cartViewModel)
                .onAppear{
                    if let userId = Auth.auth().currentUser?.uid {
                        print("User is authenticated with UID: \(userId)")
                    } else {
                        print("User is not authenticated")
                    }
                    
                    
                }
        }
        .sheet(isPresented: $isMapViewShown) {
            AddBusinessView()
               
        }
        
        
    }
}



struct BusinessView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessView(cartViewModel: CartViewModel(), businessViewModel: BusinessViewModel())
    }
}

