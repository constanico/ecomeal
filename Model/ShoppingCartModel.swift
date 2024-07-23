//
//  CartModel.swift
//  ECOMEAL
//
//  Created by Jason Leonardo on 16/09/23.
//

import Foundation
import FirebaseFirestoreSwift

struct ShoppingCart: Hashable, Encodable, Decodable, Identifiable{
    @DocumentID var id: String?
    var cartBusinessId: String
    var cartBusinessName: String
}
