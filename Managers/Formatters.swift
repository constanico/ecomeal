//
//  DateFormatter.swift
//  ECOMEAL
//
//  Created by Jason Leonardo on 08/10/23.
//

import Foundation

func getDateString(date: Date) -> String{
    let dateFormatter = DateFormatter()

    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

    return dateFormatter.string(from: date)
    
}
