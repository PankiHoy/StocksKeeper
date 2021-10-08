//
//  DetailedStockViewController.swift
//  StocksKeeper
//
//  Created by dev on 7.10.21.
//

import UIKit

class DetailedStockViewController: UIViewController {
    var company: CompanyOverview?
    var viewModel: DetailedStockViewModelProtocol?
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .medium
        view.color = .gray
        
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 30
        view.axis = .vertical
        
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !activityIndicator.isAnimating {
            activityIndicator.startAnimating()
        }
        
        view.backgroundColor = .white
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setup() { //MARK: Is called when data loaded in extension success()
        configureStackView()
        configureStackViewViews()
    }
    
    func configureStackView() {
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -50)
        ])
    }
    
    func configureStackViewViews() {
        let nameLabel = UILabel()
        nameLabel.text = viewModel?.company?.name ?? "Apple technologies"
        nameLabel.font = UIFont.robotoMedium(withSize: 30)
        
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 10
        
        let symbolLabel = UILabel()
        symbolLabel.text = viewModel?.company?.symbol ?? "AAPL"
        symbolLabel.font = UIFont.robotoMedium(withSize: 25)
        symbolLabel.textColor = .gray
        
        let bookMarkLabel = UIButton()
        bookMarkLabel.setImage(UIImage(systemName: "bookmark"), for: .normal)
        bookMarkLabel.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        
        bookMarkLabel.addTarget(self, action: #selector(addBookMark(sender:)), for: .touchUpInside)
        
        horizontalStack.addArrangedSubview(symbolLabel)
        horizontalStack.addArrangedSubview(bookMarkLabel)
        
        bookMarkLabel.translatesAutoresizingMaskIntoConstraints = false
        bookMarkLabel.trailingAnchor.constraint(equalTo: horizontalStack.trailingAnchor).isActive = true
        bookMarkLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = viewModel?.company?.description ?? "desctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiptiondesctiption"
        descriptionLabel.font = UIFont.robotoItalic(withSize: 25)
        descriptionLabel.numberOfLines = 0
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(horizontalStack)
        stackView.addArrangedSubview(configureStocksValues())
        stackView.addArrangedSubview(descriptionLabel)
    }
    
    func configureStocksValues() -> UIStackView {
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 10
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        
        let dayValue = UILabel()
        dayValue.text = viewModel?.company?.day ?? "0"
        dayValue.font = UIFont.robotoMedium(withSize: 25)
        dayValue.textAlignment = .center
        
        let dayBefore = UILabel()
        dayBefore.text = viewModel?.company?.dayLow ?? "0"
        dayBefore.font = UIFont.robotoMedium(withSize: 20)
        dayBefore.textColor = .gray
        dayBefore.textAlignment = .center
        
        stack.addArrangedSubview(dayValue)
        stack.addArrangedSubview(dayBefore)
        
        let randomLabel = UILabel()
        randomLabel.text = "chto nibud"
        randomLabel.numberOfLines = 0
        randomLabel.font = UIFont.robotoMedium(withSize: 25)
        
        horizontalStack.addArrangedSubview(stack)
        horizontalStack.addArrangedSubview(randomLabel)
        
        return horizontalStack
    }
    
    @objc func addBookMark(sender: UIButton) {
        if !sender.isSelected {
            sender.isSelected = true
            dump("company \(viewModel?.company?.name) is added to bookmarks")
        } else {
            dump("already added")
        }
    }
}

extension DetailedStockViewController: DetailedViewProtocol {
    func success() {
        if activityIndicator.isAnimating {
            activityIndicator.stopAnimating()
        }
        setup()
    }
    
    func failure(error: Error) {
        dump(error)
    }
}
