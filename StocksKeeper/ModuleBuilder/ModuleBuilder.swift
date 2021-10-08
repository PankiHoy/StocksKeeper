//
//  ModuleBuilder.swift
//  StocksKeeper
//
//  Created by dev on 6.10.21.
//

import Foundation
import UIKit

protocol ModuleBuilderProtocol {
    static func createSearchModule() -> UIViewController
    static func createStocksModule()
    static func createDetailedModule(withSymbol symbol: String) -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {
    static func createSearchModule() -> UIViewController {
        let view = SearchViewController()
        let viewModel = CompanyViewModel(view: view, networkService: NetworkService())
        view.viewModel = viewModel
        
        return view
    }
    
    static func createStocksModule() {
        
    }
    
    static func createDetailedModule(withSymbol symbol: String) -> UIViewController {
        let view = DetailedStockViewController()
        let viewModel = DetailedViewModel(view: view, networkService: NetworkService(), symbol: symbol)
        view.viewModel = viewModel
        
        return view
    }
    
    
}
