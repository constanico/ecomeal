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

struct BusinessDetailView: View {
    
    var business: Business
    
    @State private var latitude: Double = 0
    @State private var longitude: Double = 0
    
    @State private var isCartSheetPresented = false
    @State private var isShoppingCartPresented = false
    @State private var isMapSheetShown = false
    
    @ObservedObject var cartViewModel = CartViewModel()
    @ObservedObject var businessViewModel = BusinessViewModel()
    @ObservedObject var itemViewModel = ItemViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                List(itemViewModel.items) { item in
                    HStack{
                        WebImage(url: URL(string: item.imageUrl ?? ""))
                            .resizable()
                            .placeholder(Image(systemName: "photo"))
                            .frame(width: 50, height: 50)
                            .cornerRadius(8)
                            .padding(.trailing, 8)
                        VStack(alignment: .leading) {
                            Text(item.itemName).bold()
                                .font(.headline).padding(.horizontal)
                            Text(currencyString + String(format: "%.2f", item.itemOldPrice))
                                .foregroundColor(.gray)
                                .strikethrough(true, color: .red)
                                .padding(.horizontal)
                            Text(currencyString + String(format: "%.2f", item.itemNewPrice))
                                .padding(.horizontal)
                            
                            Text(item.itemDescription ?? "No description").padding(.horizontal)
                                .foregroundColor(.gray)
                            
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            if cartViewModel.orderItems.isEmpty{
                                
                            }
                            addItemToCart(item: item)
                            
                        }) {
                            Text("+ Add")
                        }
                        
                    }
                    
                }
                
                Button(action: {
                    isShoppingCartPresented = true
                    
                }) {
                    Text("View cart items (\(cartViewModel.orderItems.count))")
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 300, height: 50)
                        .background(.green)
                        .cornerRadius(12)
                }.padding()
                    .opacity(cartViewModel.orderItems.isEmpty ? 0.0 : 1.0)
                
            }
            
            .onAppear{
                itemViewModel.fetchItems(forBusiness: business.businessId)
                cartViewModel.fetchOrders()
                cartViewModel.fetchItems(forOrder: business.businessId)
                
                latitude = business.businessLatitude
                longitude = business.businessLongitude
                
            }
        }.navigationTitle("\(businessViewModel.getBusinessName(fromId: business.businessId))")
            .navigationBarTitleDisplayMode(.inline)
        
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
        
            .navigationBarItems(trailing:
                                    Button(action: {
                isMapSheetShown = true
                
            }) {
                Image(systemName: "map")
            }
            )

        
            .sheet(isPresented: $isShoppingCartPresented) {
                NavigationView {
                    if let matchedCart = cartViewModel.shoppingCarts.first(where: { $0.cartBusinessId == business.businessId }) {
                        ShoppingCartDetailView(cart: matchedCart, cartViewModel: cartViewModel)
                            .navigationBarItems(trailing: Button(action: {
                                isShoppingCartPresented = false
                            }) {
                                Text("Close")
                            })
                    } else {
                        Text("Shopping Cart not found") // Handle the case where the cart is not found
                    }
                }
                
            }
        
            .sheet(isPresented: $isMapSheetShown) {
                BusinessLocationView(latitude: $latitude, longitude: $longitude)
                
            }
    }
    
    
    func addItemToCart(item: BusinessItem) {
        let business = ShoppingCart(cartBusinessId: business.businessId, cartBusinessName: business.businessName, cartBusinessLatitude: business.businessLatitude, cartBusinessLongitude: business.businessLongitude, imageUrl: business.imageUrl)
        
        let cartItem = OrderItem(itemId: item.itemId, itemName: item.itemName, itemOldPrice: item.itemOldPrice, itemNewPrice: item.itemNewPrice, itemQuantity: 1, imageUrl: item.imageUrl)
        
        cartViewModel.addOrderItem(item: cartItem, toOrder: business)
        itemViewModel.fetchItems(forBusiness: business.cartBusinessId)
    }
}
    
    
    struct BusinessDetailView_Previews: PreviewProvider {
        static var previews: some View {
            BusinessDetailView(business: Business(businessId: "1", businessName: "Food", businessRating: 4.5, businessLatitude: 0, businessLongitude: 0), cartViewModel: CartViewModel(), businessViewModel: BusinessViewModel())
        }
    }

