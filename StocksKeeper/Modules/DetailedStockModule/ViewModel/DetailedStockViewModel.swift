//
//  CompanyViewModel.swift
//  StocksKeeper
//
//  Created by dev on 6.10.21.
//

import Foundation
import UIKit

protocol DetailedViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol DetailedStockViewModelProtocol: AnyObject {
    init(view: DetailedViewProtocol, networkService: NetworkServiceProtocol, symbol: String)
    func getCompany(symbol: String)
    var company: CompanyOverview? { get set }
    var networkService: NetworkServiceProtocol! { get set }
}

class DetailedViewModel: DetailedStockViewModelProtocol {
    weak var view: DetailedViewProtocol?
    var networkService: NetworkServiceProtocol!
    
    var company: CompanyOverview?
    
    required init(view: DetailedViewProtocol, networkService: NetworkServiceProtocol, symbol: String) {
        self.view = view
        self.networkService = networkService
        getCompany(symbol: symbol)
    }
    
    func getCompany(symbol: String) {
        networkService.getCompanyOverview(symbol: symbol) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let companies):
                    self.company = companies
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
}

