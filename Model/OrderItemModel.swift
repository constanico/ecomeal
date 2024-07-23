//
//  CartItemModel.swift
//  ECOMEAL
//
//  Created by Jason Leonardo on 01/10/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Item: Hashable, Identifiable, Codable{
    @DocumentID var id: String?
    var itemId: String
    var itemName: String
    var itemOldPrice: Float
    var itemNewPrice: Float
    var itemDescription: String?
    var itemQuantity: Int
}
