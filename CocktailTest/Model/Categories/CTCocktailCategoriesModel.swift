//
//  CTCocktailCategoriesModel.swift
//  CocktailTest
//
//  Created by Daniel Moraleda on 19/11/18.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import Foundation

class CTCocktailCategoriesModel: NSObject {
    
    // MARK: Private variables
    
    private var localDataSource: LocalDataSourceProtocol?
    
    // MARK: Variables
    
    var categoriesList: [CTCocktailCategory]
    
    // MARK: Initializers
    
    override init() {
        self.categoriesList = [CTCocktailCategory]()
        self.localDataSource = LocalDataSource()
        super.init()
    }
    
    // MARK: Public methods
    
    func setCategoriesList(catList: [CTCocktailCategory]?) {
        self.categoriesList.removeAll()
        if let list = catList {
            if list.count > 0 {
                for category in orderCategoriesAlphabetically(list: list) {
                    self.categoriesList.append(category)
                }
            }
        }
    }
    
    func getCategoriesListCount() -> Int {
        return self.categoriesList.count
    }
    
    func getCategoryForIndex(_ index: Int) -> CTCocktailCategory? {
        if self.categoriesList.count > 0 {
            return self.categoriesList[index]
        }
        return nil
    }
    
    /// Order the given categories list alphabetically
    ///
    /// - Parameter list: [CTCocktailCategory]
    /// - Returns: [CTCocktailCategory] ordered alphabetically
    func orderCategoriesAlphabetically(list: [CTCocktailCategory]) -> [CTCocktailCategory] {
        let orderedList = list.sorted(by: { $0.categoryStr < $1.categoryStr })
        localDataSource?.saveCategories(categories: orderedList)
        return orderedList
    }
}
