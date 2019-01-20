//
//  CTCocktailCategoriesView.swift
//  CocktailTest
//
//  Created by Daniel Moraleda on 19/11/18.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import UIKit

class CTCocktailCategoriesView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var categoriesTableView: UITableView!
    
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
    }
    
    func loadViewFromNib() -> UIView {
        let nibName = String(describing: type(of: self)).components(separatedBy: "__").last!
        let nib = UINib(nibName: nibName, bundle: Bundle(for: type(of: self)))
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }

}
