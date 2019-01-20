//
//  CTDrinkCategory.swift
//  CocktailTest
//
//  Created by Jordi Gámez on 20/01/2019.
//  Copyright © 2019 Daniel Moraleda. All rights reserved.
//

import Foundation
import Unbox

class CTDrinkCategory: NSObject, NSCoding, Unboxable {
    
    // MARK: Private variables
    
    private var keyName = "strDrink"
    private var keyImage = "strDrinkThumb"
    
    // MARK: Variables
    
    var drinkStr: String = ""
    var drinkImg: String = ""
    
    // MARK: Overriden methods
    
    override var description: String {
        return "[\(drinkStr), \(drinkImg)]"
    }
    
    // MARK: Initializers
    
    required init(unboxer: Unboxer) throws {
        self.drinkStr = try unboxer.unbox(key: keyName)
        self.drinkImg = try unboxer.unbox(key: keyImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.drinkStr = aDecoder.decodeObject(forKey: keyName) as! String
        self.drinkImg = aDecoder.decodeObject(forKey: keyImage) as! String
    }
    
    init(drinkStr: String, drinkImg: String) {
        self.drinkStr = drinkStr
        self.drinkImg = drinkImg
    }
    
    // MARK: Public methods
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.drinkStr, forKey: keyName)
        aCoder.encode(self.drinkImg, forKey: keyImage)
    }
    
    func getDrink() -> CTDrink {
        return CTDrink(name: self.drinkStr, image: self.drinkImg)
    }
}
