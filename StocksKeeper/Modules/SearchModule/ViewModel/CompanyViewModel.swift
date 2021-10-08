//
//  CompanyViewModel.swift
//  StocksKeeper
//
//  Created by dev on 6.10.21.
//

import Foundation
import UIKit

protocol SearchViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol CompanyViewModelProtocol: AnyObject {
    init(view: SearchViewProtocol, networkService: NetworkServiceProtocol)
    func getCompanies(symbol: String)
    var company: [Company] { get set }
    var networkService: NetworkServiceProtocol! { get set }
}

class CompanyViewModel: CompanyViewModelProtocol {
    weak var view: SearchViewProtocol?
    var networkService: NetworkServiceProtocol!
    
    var company = [Company]()
    
    required init(view: SearchViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    func getCompanies(symbol: String) {
        networkService.getCompany(symbol: symbol) { [weak self] result in
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

