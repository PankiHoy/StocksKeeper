//
//  ViewController.swift
//  StocksKeeper
//
//  Created by dev on 6.10.21.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate {
    var viewModel: CompanyViewModelProtocol?
    
    let arrayOfData = [
        "Ben",
        "Vlad",
        "Alexander",
        "Igor",
        "Anaken",
        "Vailiy"
    ]
    
    var searchArray: [String] = []
    
    let searchTableView: DynamicTableView = {
        let view = DynamicTableView()
        
        return view
    }()
    
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.sizeToFit()
        
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    
    func setup() {
        searchBar.delegate = self
        view.backgroundColor = .white
        configureTabBar()
    }
    
    func configureTabBar() {
        tabBarItem = UITabBarItem(title: "Favorites",
                                  image: UIImage(systemName: "star"),
                                  selectedImage: UIImage(systemName: "star.fill"))
        tabBarController?.tabBar.tintColor = .black
        navigationController?.navigationBar.tintColor = .black
        title = "Favorites"
        configureSearchBar()
    }
    
    func configureSearch(_ check: Bool) {
        if check {
            searchTableView.delegate = self
            searchTableView.dataSource = self
            
            searchTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            
            searchTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
            
            view.addSubview(searchTableView)
            searchTableView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                searchTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                searchTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                searchTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
            ])
        } else {
            if view.subviews.contains(searchTableView) {
                view.willRemoveSubview(searchTableView)
                searchTableView.removeFromSuperview()
            }
        }
    }
    
    func configureSearchBar() {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        navigationItem.titleView = nil
        navigationItem.rightBarButtonItem = (UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"),
                                                             style: .plain,
                                                             target: self,
                                                             action: #selector(searchButtonPressed(sender:))))
    }
    
    @objc func searchButtonPressed(sender: UIBarButtonItem) {
        configureSearch(true)
        
        navigationItem.titleView = searchBar
        searchBar.showsCancelButton = true
        searchBar.becomeFirstResponder()
        navigationItem.rightBarButtonItem = nil
    }
    
    @objc func resignSearchBar(sender: UIView) {
        searchBar.resignFirstResponder()
    }
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.company.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell = UITableViewCell(style: .value2, reuseIdentifier: "cell")
        cell?.detailTextLabel?.text = viewModel?.company[indexPath.row].name
        cell?.textLabel?.text = viewModel?.company[indexPath.row].symbol
        cell?.backgroundColor = UIColor(named: "rsWhite")
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.resignFirstResponder()
        let detailedController = ModuleBuilder.createDetailedModule(withSymbol: (viewModel?.company[indexPath.row].symbol)!)
        navigationController?.pushViewController(detailedController, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        configureSearch(false)
        configureSearchBar()
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dump(searchText)
        searchArray.removeAll()
        viewModel?.getCompanies(symbol: searchText)
        searchArray.sort(by: <)
        searchTableView.reloadData()
    }
}

extension SearchViewController: SearchViewProtocol {
    func success() {
        self.searchTableView.reloadData()
    }
    
    func failure(error: Error) {
        dump(error)
    }
}
