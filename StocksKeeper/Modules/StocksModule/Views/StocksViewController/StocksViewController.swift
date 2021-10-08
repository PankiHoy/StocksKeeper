//
//  StocksViewController.swift
//  StocksKeeper
//
//  Created by dev on 6.10.21.
//

import UIKit

class StocksViewController: UIViewController {
    
    override func didMove(toParent parent: UIViewController?) {
        configureTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    
    func setup() {
        view.backgroundColor = .white
        
        configureTabBar()
    }
    
    func configureTabBar() {
        tabBarItem = UITabBarItem(title: "Stocks",
                                  image: UIImage(systemName: "bag"),
                                  selectedImage: UIImage(systemName: "bag.fill"))
    }
}
