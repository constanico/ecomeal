//
//  ShoppingCartDetailView.swift
//  ECOMEAL
//
//  Created by Jason Leonardo on 01/10/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ShoppingCartDetailView: View {
    var cart: ShoppingCart
    @State private var fixedPlatformFee: Float = 5000.00
    @ObservedObject var cartViewModel: CartViewModel
    @ObservedObject var orderViewModel = OrderViewModel()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            VStack {
                    List {
                        Section(header: Text("Your order")) {
                            ForEach(cartViewModel.orderItems, id: \.self) { item in
                                HStack {
                                    WebImage(url: URL(string: item.imageUrl ?? ""))
                                        .resizable()
                                        .placeholder(Image(systemName: "photo"))
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(8)
                                        .padding(.trailing, 8)
                                    VStack(alignment: .leading) {
                                        Text(item.itemName + " x" + "\(item.itemQuantity)").bold()
                                            .font(.headline).padding()
                                        Text(currencyString + String(format: "%.2f", item.itemNewPrice)).padding(.horizontal)
                                            .padding(.bottom, 20)
                                    }
                                }
                            }
                            
                            .onDelete { indexSet in
                                // Handle item deletion here
                                let itemToDelete = cartViewModel.orderItems[indexSet.first!]
                                cartViewModel.deleteOrderItem(item: itemToDelete, fromOrder: cartViewModel.shoppingCarts.first(where: { $0.cartBusinessId == cart.cartBusinessId })!)
                                
                            }
                        }
                }
                
                HStack {
                    Text("Subtotal")
                        .font(.headline)
                    Spacer()
                    Text(currencyString + String(format: "%.2f", cartViewModel.getTotalPrice()))
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Platform Fee")
                        .font(.headline)
                    Spacer()
                    Text(currencyString + String(format: "%.2f", fixedPlatformFee))
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Total Cost")
                        .font(.headline)
                    Spacer()
                    Text(currencyString + String(format: "%.2f", cartViewModel.getTotalPrice() + fixedPlatformFee))
                    
                }
                .padding(.horizontal)
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    let id = UUID().uuidString
                    
                    let newOrder =
                    Order(orderId: id,
                          orderUserId: orderViewModel.getUserId(),
                          orderBusinessId: cart.cartBusinessId,
                          orderBusinessName: cart.cartBusinessName,
                          orderBusinessLatitude: cart.cartBusinessLatitude,
                          orderBusinessLongitude: cart.cartBusinessLongitude,
                          orderStatus: OrderStatusString.orderOngoing.orderStatusText,
                          imageUrl: cart.imageUrl)
                    
                    orderViewModel.addOrder(uuid: id, order: newOrder, orderItems: cartViewModel.orderItems)
                    cartViewModel.deleteShoppingCart(cart)
                }) {
                    Text("Checkout")
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 300, height: 50)
                        .background(.green)
                        .cornerRadius(12)
                }.padding()
            }
        }
        .navigationBarTitle(cart.cartBusinessName)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            cartViewModel.fetchItems(forOrder: cart.cartBusinessId)
            //print(viewModel.orderItems.count)
        }
        
    }
}


#Preview {
    ShoppingCartDetailView(cart: ShoppingCart(cartBusinessId: "1", cartBusinessName: "Josef's Pizza", cartBusinessLatitude: 0, cartBusinessLongitude: 0), cartViewModel: CartViewModel(), orderViewModel: OrderViewModel())
}
