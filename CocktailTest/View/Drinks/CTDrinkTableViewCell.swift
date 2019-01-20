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
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.numberOfLines = numberOfLines
        }
    }
    @IBOutlet weak var pictureImageView: UIImageView!
    
    // MARK: Private constants
    
    private let numberOfLines = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func xibSetup() {
        self.selectionStyle = .none
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
    }
}
