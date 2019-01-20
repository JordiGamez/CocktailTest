//
//  CTDrinksModel.swift
//  CocktailTest
//
//  Created by Jordi Gámez on 20/01/2019.
//  Copyright © 2019 Daniel Moraleda. All rights reserved.
//

import Foundation

class CTDrinksModel: NSObject {
    
    // MARK: Variables
    
    var drinkList: [CTDrinkCategory]
    
    // MARK: Initializers
    
    override init() {
        self.drinkList = [CTDrinkCategory]()
        super.init()
    }
    
    // MARK: Public methods
    
    func setDrinksList(catList: [CTDrinkCategory]?) {
        self.drinkList.removeAll()
        if let list = catList {
            if list.count > 0 {
                for category in orderDrinksAlphabetically(list: list) {
                    self.drinkList.append(category)
                }
            }
        }
    }
    
    func getDrinksListCount() -> Int {
        return self.drinkList.count
    }
    
    func getDrinkForIndex(_ index: Int) -> CTDrinkCategory? {
        if self.drinkList.count > 0 {
            return self.drinkList[index]
        }
        return nil
    }
    
    /// Order the given drinks list alphabetically
    ///
    /// - Parameter list: [CTDrink]
    /// - Returns: [CTDrink] ordered alphabetically
    func orderDrinksAlphabetically(list: [CTDrinkCategory]) -> [CTDrinkCategory] {
        return list.sorted(by: { $0.drinkStr < $1.drinkStr })
    }
}
