//
//  NavigationManager.swift
//  ECOMEAL
//
//  Created by Jason Leonardo on 16/09/23.
//

import Foundation

enum PageNavigation{
    
    case loginPage
    case homePage
    
    var pageText: String{
        switch self{
            
        case .loginPage:
            return "LoginPage"
            
        case .homePage:
            return "HomePage"
            
        }
    }
    
}

class PageNavigator: ObservableObject {
    @Published var currentPage: PageNavigation
    
    init(currentPage: PageNavigation) {
        self.currentPage = currentPage
    }
}


