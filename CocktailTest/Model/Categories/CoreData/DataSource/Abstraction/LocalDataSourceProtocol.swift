//
//  LocalDataSourceProtocol.swift
//  CocktailTest
//
//  Created by Jordi Gámez on 20/01/2019.
//  Copyright © 2019 Daniel Moraleda. All rights reserved.
//

import Foundation

/// Abstraction for LocalDataSource
protocol LocalDataSourceProtocol {
    
    /// Get the categories list
    ///
    /// - Returns: Categories array
    func getCategories() -> [CTCocktailCategory]?
    
    /// Save the categories list
    ///
    /// - Parameter categories: Categories array
    func saveCategories(categories: [CTCocktailCategory])
}
