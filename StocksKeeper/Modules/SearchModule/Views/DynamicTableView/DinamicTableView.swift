//
//  SearchBar.swift
//  StocksKeeper
//
//  Created by dev on 6.10.21.
//

import UIKit

class DynamicTableView: UITableView {
    
    let maxHeight = UIScreen.main.bounds.height/2
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        layer.cornerRadius = 15
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        layoutIfNeeded()
    }
    
    override public var intrinsicContentSize: CGSize {
        setNeedsLayout()
        
        let height = max(contentSize.height, 0) //MARK: СДЕЛАТЬ ПО НОРМАЛЬНОМУ ДЛЯ КЕЙСА ЕСЛИ ХОЧУ ОГРАНИЧИТЬ РАЗМЕР TableView
        
        return CGSize(width: contentSize.width, height: height)
    }
}
