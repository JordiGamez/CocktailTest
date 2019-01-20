//
//  CTDrinksList.swift
//  CocktailTest
//
//  Created by Jordi Gámez on 20/01/2019.
//  Copyright © 2019 Daniel Moraleda. All rights reserved.
//

import Foundation
import Unbox

class CTDrinksList: NSObject, NSCoding, Unboxable {
    
    // MARK: Private constants
    
    private let key = "drinks"
    
    // MARK: Private variables
    
    private var drinksList: [CTDrinkCategory]?
    
    required init(unboxer: Unboxer) throws {
        self.drinksList = unboxer.unbox(key: key)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.drinksList = aDecoder.decodeObject(forKey: key) as? [CTDrinkCategory]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.drinksList, forKey: key)
    }
    
    func getDrinksList() -> [CTDrinkCategory]? {
        return drinksList
    }
}
