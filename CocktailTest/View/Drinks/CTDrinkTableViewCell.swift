//
//  CTDrinkTableViewCell.swift
//  CocktailTest
//
//  Created by Jordi Gámez on 20/01/2019.
//  Copyright © 2019 Daniel Moraleda. All rights reserved.
//

import UIKit

class CTDrinkTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    
    @IBOutlet var view: UIView! {
        didSet {
            view.backgroundColor = UIColor(rgb: Colors.background)
        }
    }
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.numberOfLines = numberOfLines
            nameLabel.textColor = .white
            nameLabel.font = .systemFont(ofSize: 18.0, weight: UIFont.Weight.semibold)
        }
    }
    @IBOutlet weak var pictureImageView: UIImageView!
    
    // MARK: Private constants
    
    private let numberOfLines = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
    }
    
    func xibSetup() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor(rgb: Colors.background)
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
    }
}
