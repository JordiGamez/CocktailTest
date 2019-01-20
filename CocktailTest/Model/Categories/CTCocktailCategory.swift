//
//  CTCocktailCategory.swift
//  CocktailTest
//
//  Created by Daniel Moraleda on 19/11/18.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import Foundation
import Unbox

class CTCocktailCategory: NSObject, NSCoding, Unboxable {
    
    // MARK: Private variables
    
    private var categoryStr: String = ""
    private var key = "strCategory"
    
    // MARK: Overriden methods
    
    override var description: String {
        return "[\(categoryStr)]"
    }
    
    // MARK: Initializers
    
    required init(unboxer: Unboxer) throws {
        self.categoryStr = try unboxer.unbox(key: key)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.categoryStr = aDecoder.decodeObject(forKey: key) as! String
    }
    
    // MARK: Public methods
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.categoryStr, forKey: key)
    }
    
    func getCategory() -> String {
        return categoryStr
    }
}
