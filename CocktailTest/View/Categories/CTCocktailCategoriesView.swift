//
//  CTCocktailCategoriesView.swift
//  CocktailTest
//
//  Created by Daniel Moraleda on 19/11/18.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import UIKit

class CTCocktailCategoriesView: UIView {

    // MARK: - IBOutlets
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var categoriesTableView: UITableView!
    
    // MARK: - Private constants
    
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Variables
    
    var reloadTableCallback: (() -> Void)?
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
        categoriesTableView.tableFooterView = UIView()
        addRefreshControl()
    }
    
    func loadViewFromNib() -> UIView {
        let nibName = String(describing: type(of: self)).components(separatedBy: "__").last!
        let nib = UINib(nibName: nibName, bundle: Bundle(for: type(of: self)))
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    /// Add pull to refresh to TableView
    private func addRefreshControl() {
        categoriesTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(reloadTableView(_:)), for: .valueChanged)
    }
    
    /// Call the callback is pull to refresh is triggered
    ///
    /// - Parameter sender: <#sender description#>
    @objc private func reloadTableView(_ sender: Any) {
        if let callback = reloadTableCallback {
            callback()
        }
    }
    
    /// Stop refresh animation
    func stopRefreshAnimation() {
        refreshControl.endRefreshing()
    }
}
