//
//  OrderViewModel.swift
//  ECOMEAL
//
//  Created by Jason Leonardo on 10/09/23.
//

import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

/*
 
 This view model covers:
 - Shopping cart items
 - Order items (ongoing)
 - Ordered items (history)
 
 To do that, orderStatus from order collection needs to be updated
 
 */

class CartViewModel: ObservableObject {
    @Published var shoppingCarts: [ShoppingCart] = []
    
    @Published var orderItems: [OrderItem] = []
    
    private var db = Firestore.firestore()
    
    init(){
        fetchOrders()
        
    }
}
    
    
    // ORDER BUSINESS
    
    extension CartViewModel{
        func fetchOrders() {
            guard let userId = Auth.auth().currentUser?.uid else {
                print("User is not authenticated")
                return
            }
            
            let userOrdersCollection = db.collection("users").document(userId).collection(FilePathString.orders.filePathText)
            
            
            userOrdersCollection.addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching orders: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                
                self.shoppingCarts = documents.compactMap { queryDocumentSnapshot in
                    try? queryDocumentSnapshot.data(as: ShoppingCart.self)
                    
                    
                    
                }
            }
        }
        
    }
    
    //ITEMS PER ORDER BUSINESS
    
    extension CartViewModel{
        
        func fetchItems(forOrder orderId: String) {
            guard let userId = Auth.auth().currentUser?.uid else {
                print("User is not authenticated")
                return
            }
            
            let userOrdersCollection = db.collection("users").document(userId).collection(FilePathString.orders.filePathText)
            
            let orderQuery = userOrdersCollection
                .whereField("cartBusinessId", isEqualTo: orderId)
            
            orderQuery.getDocuments { [weak self] (querySnapshot, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error querying orders: \(error.localizedDescription)")
                    return
                }
                
                guard let orderDocument = querySnapshot?.documents.first else {
                    print("Order with ID \(orderId) not found.")
                    return
                }
                
                let itemsCollection = orderDocument.reference.collection(FilePathString.orderItems.filePathText)
                
                itemsCollection.addSnapshotListener { [self] querySnapshot, error in
                    guard let documents = querySnapshot?.documents else {
                        print("Error fetching order items: \(error?.localizedDescription ?? "Unknown error")")
                        return
                    }
                    
                    self.orderItems = documents.compactMap { queryDocumentSnapshot in
                        try? queryDocumentSnapshot.data(as: OrderItem.self)
                    }
                }
            }
        }
        
        func getTotalPrice() -> Float {
            let totalPrice = orderItems.reduce(0.0) { (result, item) in
                return result + item.itemNewPrice * Float(item.itemQuantity)
            }
            return totalPrice
        }
        
        func addOrderItem(item: OrderItem, toOrder order: ShoppingCart) {
            guard let userId = Auth.auth().currentUser?.uid else {
                print("User is not authenticated")
                return
            }
            
            do {
                let userOrdersCollection = db.collection("users").document(userId).collection(FilePathString.orders.filePathText)
                
                let query = userOrdersCollection.whereField("cartBusinessId", isEqualTo: order.cartBusinessId)
                
                query.getDocuments { (querySnapshot, error) in
                    if let error = error {
                        print("Error querying orders: \(error.localizedDescription)")
                        return
                    }
                    
                    if let existingOrder = querySnapshot?.documents.first {
                        let orderID = existingOrder.documentID
                        let orderRef = userOrdersCollection.document(orderID)
                        
                        let itemsCollection = orderRef.collection(FilePathString.orderItems.filePathText)
                        
                        let itemQuery = itemsCollection.whereField("itemId", isEqualTo: item.itemId)
                        
                        itemQuery.getDocuments { [self] (itemQuerySnapshot, itemError) in
                            if let itemError = itemError {
                                print("Error querying order items: \(itemError.localizedDescription)")
                                return
                            }
                            
                            fetchItems(forOrder: order.cartBusinessId)
                            
                            if let itemDocument = itemQuerySnapshot?.documents.first {
                              
                                var existingItem = try? itemDocument.data(as: OrderItem.self)
                                existingItem?.itemQuantity += item.itemQuantity
                                try? itemDocument.reference.setData(from: existingItem)
                                
                                print("Item quantity updated in the order successfully")
                            } else {
                                let itemRef = itemsCollection.document()
                                try? itemRef.setData(from: item)
                                
                                print("Item added to the existing order successfully")
                            }
                        }
                    } else {
                        var newItem = order
                        newItem.id = nil
                        
                        let orderRef = try? userOrdersCollection.addDocument(from: newItem)
                        
                        if let orderRef = orderRef {
                            let itemsCollection = orderRef.collection(FilePathString.orderItems.filePathText)
                            let itemRef = itemsCollection.document()
                            try? itemRef.setData(from: item)
                            print("Item added to a new order successfully")
                        } else {
                            print("Error creating a new order")
                        }
                    }
                }
            } catch {
                print("Error adding item to the order: \(error.localizedDescription)")
            }
        }

        
        func deleteOrderItem(item: OrderItem, fromOrder order: ShoppingCart) {
            guard let userId = Auth.auth().currentUser?.uid else {
                print("User is not authenticated")
                return
            }
            
            let userOrdersCollection = db.collection("users").document(userId).collection(FilePathString.orders.filePathText)
            
            let orderQuery = userOrdersCollection.whereField("orderId", isEqualTo: order.cartBusinessId).whereField("orderStatus", isEqualTo: OrderStatusString.orderInCart.orderStatusText)
            
            orderQuery.getDocuments { [weak self] (querySnapshot, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error querying orders: \(error.localizedDescription)")
                    return
                }
                
                guard let orderDocument = querySnapshot?.documents.first else {
                    print("Order with ID \(order.cartBusinessId) not found.")
                    return
                }
                
                let itemsCollection = orderDocument.reference.collection(FilePathString.orderItems.filePathText)
                
                let itemQuery = itemsCollection.whereField("itemId", isEqualTo: item.itemId)
                
                itemQuery.getDocuments { (itemQuerySnapshot, itemError) in
                    if let itemError = itemError {
                        print("Error querying order items: \(itemError.localizedDescription)")
                        return
                    }
                    
                    if let itemDocument = itemQuerySnapshot?.documents.first {
                        
                        itemDocument.reference.delete()
                        
                        print("Item deleted from order successfully")
                        
                        itemsCollection.getDocuments { (remainingItemsQuerySnapshot, remainingItemsError) in
                            if let remainingItemsError = remainingItemsError {
                                print("Error querying remaining order items: \(remainingItemsError.localizedDescription)")
                                return
                            }
                            
                            if remainingItemsQuerySnapshot?.isEmpty == true {
                                orderDocument.reference.delete()
                                print("Order deleted as there are no remaining items.")
                            }
                        }
                    } else {
                        print("Item with ID \(item.itemId) not found in the order.")
                    }
                }
            }
        }
    }

