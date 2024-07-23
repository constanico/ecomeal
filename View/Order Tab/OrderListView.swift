//
//  OrderListView.swift
//  ECOMEAL
//
//  Created by Jason Leonardo on 02/10/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct OrderListView: View {
    @ObservedObject var viewModel: OrderViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedSegment = 0
    
    private let segments = ["Ongoing", "History"]
    var body: some View {
        NavigationView {
            VStack{
                Picker("Segments", selection: $selectedSegment) {
                    ForEach(0..<segments.count, id: \.self) { index in
                        Text(segments[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle()).padding()
                if segments[selectedSegment] == segments[0]{
                    List(viewModel.orders.filter({ $0.orderStatus == OrderStatusString.orderOngoing.orderStatusText })) { item in
                        HStack{
                            NavigationLink(destination: OrderDetailView(order: item, viewModel: viewModel)) {
                                WebImage(url: URL(string: item.imageUrl ?? ""))
                                    .resizable()
                                    .placeholder(Image(systemName: "photo"))
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(8)
                                    .padding(.trailing, 8)
                                VStack(alignment: .leading) {
                                    Text(item.orderBusinessName).bold()
                                        .font(.headline).padding()
                                    Text("Tap to view order") .padding(.horizontal)
                                        .padding(.bottom, 20)
                                        .foregroundColor(.gray)
                                }
                            }
                            
                        }
                        
                    }
                    .navigationBarTitle("Orders")
                }else{
                    List(viewModel.orders.filter {
                        $0.orderStatus == OrderStatusString.orderFinished.orderStatusText ||
                        $0.orderStatus == OrderStatusString.orderCancelled.orderStatusText
                    }) { item in
                        if (item.orderStatus == OrderStatusString.orderFinished.orderStatusText){
                            HStack{
                                NavigationLink(destination: OrderDetailView(order: item, viewModel: viewModel)) {
                                    WebImage(url: URL(string: item.imageUrl ?? ""))
                                        .resizable()
                                        .placeholder(Image(systemName: "photo"))
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(8)
                                        .padding(.trailing, 8)
                                    VStack(alignment: .leading) {
                                        Text(item.orderBusinessName).bold()
                                            .font(.headline).padding()
                                        Text("Tap to view") .padding(.horizontal)
                                            .padding(.bottom, 20)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            
                        } else if (item.orderStatus == OrderStatusString.orderCancelled.orderStatusText){
                            HStack{
                                NavigationLink(destination: OrderDetailView(order: item, viewModel: viewModel)) {
                                    WebImage(url: URL(string: item.imageUrl ?? ""))
                                        .resizable()
                                        .placeholder(Image(systemName: "photo"))
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(8)
                                        .padding(.trailing, 8)
                                    VStack(alignment: .leading) {
                                        Text(item.orderBusinessName).bold()
                                            .font(.headline).padding()
                                        Text("Order cancelled") .padding(.horizontal)
                                            .foregroundColor(.red)
                                        Text("Tap to view") .padding(.horizontal)
                                            .padding(.bottom, 20)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            
                        }
                        
                    }
                }
                
                
            } .navigationBarTitle("Order History")
        }
    }
    
    
}


#Preview {
    OrderListView(viewModel: OrderViewModel())
}
