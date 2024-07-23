//
//  FilePathEnum.swift
//  ECOMEAL
//
//  Created by Jason Leonardo on 01/10/23.
//

import Foundation

enum FilePathString{
    
    case business
    case businessList
    case businessItems
    case orders
    case orderBusiness
    case orderItems
    
    
    var filePathText: String{
        switch self{
            
        case .business:
            return "businesses"
            
        case .businessList:
            return "businessList"
            
        case .businessItems:
            return "items"
            
        case .orders:
            return "orders"
            
        case .orderBusiness:
            return "orderBusinesses"
            
        case .orderItems:
            return "orderItems"
            
            
        }
    }
    
}
