//
//  OrderOngoingView.swift
//  ECOMEAL
//
//  Created by Jason Leonardo on 08/10/23.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseAuth

struct OrderBreakdownView: View {
    var order: Order
    @State private var fixedPlatformFee: Float = 5000.00
    @ObservedObject var orderViewModel: OrderViewModel
    @ObservedObject var businessModel = BusinessViewModel()
    @ObservedObject var reviewViewModel = BusinessReviewViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @State private var rating: Double = 0
    @State private var reviewContent: String = ""
    
    @Binding var latitude: Double
    @Binding var longitude: Double
    
    var body: some View {
        NavigationView {
            VStack {
                if order.orderStatus == OrderStatusString.orderOngoing.orderStatusText{
                    StaticMapView(latitude: $latitude, longitude: $longitude, lockToPin: false)
                }
                
                ScrollView{
                    VStack{
                        HStack{
                            WebImage(url: URL(string: order.imageUrl ?? ""))
                                .resizable()
                                .placeholder(Image(systemName: "photo"))
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                                .padding(.trailing, 10)
                            VStack(alignment: .leading){
                                Text(order.orderBusinessName)
                                    .bold()
                                Text(order.orderBusinessAddress)
                                    .foregroundColor(.gray)
                            }
                        }
                    }.padding()
                    Text("\(orderViewModel.orderItems.count) items ordered")
                        .bold()
                        .padding(.bottom)
                    ForEach(orderViewModel.orderItems, id: \.self) { item in
                        HStack{
                            HStack {
                                WebImage(url: URL(string: item.imageUrl ?? ""))
                                    .resizable()
                                    .placeholder(Image(systemName: "photo"))
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(8)
                                    .padding(.trailing, 8)
                                VStack (alignment: .leading) {
                                    Text(item.itemName + " x" + "\(item.itemQuantity)").bold()
                                        .font(.headline).padding(.horizontal)
                                    Text(currencyString + String(format: "%.2f", item.itemNewPrice)).padding(.horizontal)
                                        .padding(.bottom, 20)
                                }
                            }
                            Spacer()
                        }.padding(.horizontal, 30)
                        
                    }
                    
                    VStack{
                        HStack {
                            Text("Subtotal")
                                .font(.headline)
                            Spacer()
                            Text(currencyString + String(format: "%.2f", orderViewModel.getTotalPrice()))
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
                            Text(currencyString + String(format: "%.2f", orderViewModel.getTotalPrice() + fixedPlatformFee))
                            
                        }.padding(.top)
                        .padding(.horizontal)
                    }.padding()
                    
                    if order.orderStatus == OrderStatusString.orderOngoing.orderStatusText{
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                            orderViewModel.updateOrderStatus(orderId: order.orderId, newStatus: OrderStatusString.orderFinished.orderStatusText)
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
                        if order.orderStatus == OrderStatusString.orderFinished.orderStatusText{
                            Text("Rate your meal").font(.headline)
                            TextField("Review content", text: $reviewContent)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                            
                            Button(action: {
                                let newReview = Review(reviewerName: Auth.auth().currentUser?.email ?? "Tim Cook", reviewStarRating: 4, reviewContent: reviewContent, reviewTimestamp: getDateString(date: Date()))
                                presentationMode.wrappedValue.dismiss()
                                reviewViewModel.addReview(toBusiness: order.orderBusinessId, review: newReview)
                                
                                orderViewModel.updateOrderStatus(orderId: order.orderId, newStatus: OrderStatusString.orderReviewed.orderStatusText)
                                
                            }) {
                                Text("Submit Review")
                                    .foregroundColor(.white)
                                    .bold()
                                    .frame(width: 300, height: 50)
                                    .background(.green)
                                    .cornerRadius(12)
                            }.padding()
                        }
                    }
                    
                }
            }
            .onAppear{
                orderViewModel.fetchOrderItems(orderId: order.orderId)
                print("Order id: " + order.orderId)
                print("Latitude: \(latitude) Longitude: \(longitude)")
            }
            
            
        }
        
    }
}
#Preview {
    OrderBreakdownView(order: orderDummy, orderViewModel: OrderViewModel(), latitude: .constant(0), longitude: .constant(1))
    
}
