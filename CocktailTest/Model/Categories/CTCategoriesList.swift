//
//  CTCategoriesList.swift
//  CocktailTest
//
//  Created by Daniel Moraleda on 19/11/18.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import Foundation
import Unbox

class CTCategoriesList: NSObject, NSCoding, Unboxable {
    
    // MARK: Private constants
    
    private let key = "drinks"
    
    // MARK: Private variables
    
    private var categoriesList: [CTCocktailCategory]?
    
    required init(unboxer: Unboxer) throws {
        self.categoriesList = unboxer.unbox(key: key)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.categoriesList = aDecoder.decodeObject(forKey: key) as? [CTCocktailCategory]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.categoriesList, forKey: key)
    }
    
    func getCategoriesList() -> [CTCocktailCategory]? {
        return categoriesList
    }
}
