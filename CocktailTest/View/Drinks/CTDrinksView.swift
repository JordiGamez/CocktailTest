//
//  CTDrinksView.swift
//  CocktailTest
//
//  Created by Jordi Gámez on 20/01/2019.
//  Copyright © 2019 Daniel Moraleda. All rights reserved.
//

import UIKit

class CTDrinksView: UIView {
    
    // MARK: IBOutlets
    
    @IBOutlet var view: UIView! {
        didSet {
            view.backgroundColor = UIColor(rgb: Colors.background)
        }
    }
    @IBOutlet weak var drinksTableView: UITableView! {
        didSet {
            drinksTableView.backgroundColor = UIColor(rgb: Colors.background)
            drinksTableView.tableFooterView = UIView()
            drinksTableView.rowHeight = UITableViewAutomaticDimension
            drinksTableView.estimatedRowHeight = 100
            drinksTableView.tableFooterView = UIView()
        }
    }
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        xibSetup()
    }
    
    // MARK: Private methods
    
    private func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
        
        drinksTableView.register(UINib(nibName: "CTDrinkTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
    }
    
    private func loadViewFromNib() -> UIView {
        let nibName = String(describing: type(of: self)).components(separatedBy: "__").last!
        let nib = UINib(nibName: nibName, bundle: Bundle(for: type(of: self)))
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
}
