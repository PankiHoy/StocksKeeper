//
//  NetworkService.swift
//  rs.ios.stage-task11
//
//  Created by dev on 9.09.21.
//

import Foundation
import UIKit

protocol NetworkServiceProtocol: AnyObject {
    func getCompany(symbol: String, completion: @escaping (Result<[Company], Error>)->Void)
    func getCompanyOverview(symbol: String, completion: @escaping (Result<CompanyOverview, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func getCompany(symbol: String, completion: @escaping (Result<[Company], Error>)->Void) {
        let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(symbol)&apikey=6O8FZ2GBGJR485JE"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                completion(.failure(error))
            }

            var dict: [String: Any]?
            
            do {
                dict = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String : Any]
            } catch {
                print(error)
            }
            
            let data = self?.parseCompanyDictionary(withData: dict!)
            completion(.success(data!))
        }.resume()
    }
    
    func getCompanyOverview(symbol: String, completion: @escaping (Result<CompanyOverview, Error>) -> Void) {
        let urlString = "https://www.alphavantage.co/query?function=OVERVIEW&symbol=\(symbol)&apikey=6O8FZ2GBGJR485JE"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                dump(error)
                return
            }
            
            do {
                let companyJson = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: String]
                let data = self?.parseCompanyOverviewDictionary(withData: companyJson!)
                completion(.success(data!))
            } catch {
                dump(error)
            }
            
        }.resume()
    }
    
    func parseCompanyDictionary(withData data: [String: Any]) -> [Company] {
        let companiesArray = data["bestMatches"] as? [[String: String]]
        var companies = [Company]()
        
        if let companiesArray = companiesArray {
            for company in companiesArray {
                let companyObject = Company(symbol: company["1. symbol"]!, name: company["2. name"]!)
                companies.append(companyObject)
            }
        }
        
        return companies
    }
    
    func parseCompanyOverviewDictionary(withData data: [String: String]) -> CompanyOverview {
        let company = CompanyOverview(symbol: data["Symbol"]!,
                                      name: data["Name"]!,
                                      description: data["Description"]!,
                                      day: data["50DayMovingAverage"]!,
                                      dayLow: data["200DayMovingAverage"]!)
        
        return company
    }
}

