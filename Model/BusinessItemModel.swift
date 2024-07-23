//
//  SellerItemModel.swift
//  ECOMEAL
//
//  Created by Jason Leonardo on 16/09/23.
//

import Foundation
import FirebaseFirestoreSwift

struct BusinessItem: Hashable, Encodable, Decodable, Identifiable{
    @DocumentID var id: String?
    var itemId: String
    var itemName: String
    var itemOldPrice: Float
    var itemNewPrice: Float
    var itemDescription: String?
    var itemQuantity: Int
}
