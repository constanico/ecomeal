//
//  OrderDetailView.swift
//  ECOMEAL
//
//  Created by Jason Leonardo on 03/10/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct OrderDetailView: View {
    var order: Order
    @State private var fixedPlatformFee: Float = 5000.00
    @ObservedObject var viewModel: OrderViewModel
    @ObservedObject var businessModel = BusinessViewModel()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            VStack {
                //Text(order.orderBusinessName).font(.headline)
                List {
                    ForEach(viewModel.orderItems, id: \.self) { item in
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
                }
                
                if order.orderStatus == OrderStatusString.orderOngoing.orderStatusText{
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        viewModel.updateOrderStatus(orderId: order.orderId, newStatus: OrderStatusString.orderCancelled.orderStatusText)
                    }) {
                        Text("Cancel Order")
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: 300, height: 50)
                            .background(.red)
                            .cornerRadius(12)
                    }.padding()
                } else if order.orderStatus == OrderStatusString.orderCancelled.orderStatusText{
                    Text("Order cancelled")
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding()
                }else{
                    Text("Order finished")
                        .font(.headline)
                        .foregroundColor(.green)
                        .padding()
                }
            }
                .onAppear{
                    viewModel.fetchOrderItems(orderId: order.orderId)
                    print("Order id: " + order.orderId)
                    //print(viewModel.orderItems.count)
                }
                
            
        }.navigationBarTitle(order.orderBusinessName)
            .navigationBarTitleDisplayMode(.inline)
                
    }
}

#Preview {
    OrderDetailView(order: Order(orderId: "1", orderUserId: "1", orderBusinessId: "1", orderBusinessName: "Freddy's Pizzeria", orderBusinessLatitude: 0, orderBusinessLongitude: 0, orderStatus: OrderStatusString.orderOngoing.orderStatusText), viewModel: OrderViewModel())
}
