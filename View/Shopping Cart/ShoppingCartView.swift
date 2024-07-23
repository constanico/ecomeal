//
//  ShoppingCartView.swift
//  ECOMEAL
//
//  Created by Jason Leonardo on 18/09/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ShoppingCartView: View {
    @ObservedObject var viewModel: CartViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            
            List(viewModel.shoppingCarts) { item in
                HStack{
                    NavigationLink(destination: ShoppingCartDetailView(cart: item, cartViewModel: viewModel)) {
                        WebImage(url: URL(string: item.imageUrl ?? ""))
                            .resizable()
                            .placeholder(Image(systemName: "photo"))
                            .frame(width: 50, height: 50)
                            .cornerRadius(8)
                            .padding(.trailing, 8)
                        VStack(alignment: .leading) {
                            Text(item.cartBusinessName).bold()
                                .font(.headline).padding()
                            Text("Tap to view cart") .padding(.horizontal)
                                .padding(.bottom, 20)
                        }
                    }
                    
                }
                
            }
            .navigationBarTitle("Shopping Cart")
            .navigationBarItems(trailing:
                                    Button("Close") {
                presentationMode.wrappedValue.dismiss()
            }
            )
        }
        
        
    }
}



struct ShoppingCartView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCartView(viewModel: CartViewModel())
    }
}
