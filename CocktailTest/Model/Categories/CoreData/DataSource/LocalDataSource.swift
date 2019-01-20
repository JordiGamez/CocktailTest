//
//  LocalDataSource.swift
//  CocktailTest
//
//  Created by Jordi Gámez on 20/01/2019.
//  Copyright © 2019 Daniel Moraleda. All rights reserved.
//

import UIKit
import CoreData

/// Responsible for accessing, saving and deleting the local data
class LocalDataSource {
    
    // MARK: - Private constants
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let entityName = "Drink"
    private let fieldName = "strCategory"
    
    // MARK: - Private methods
    
    /// Check if there is local data
    ///
    /// - Returns: True if it exists, false otherwise
    fileprivate func checkIfLocalDataIsEmpty() -> Bool {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for _ in result as! [NSManagedObject] {
                return false
            }
        } catch {
            print("Fail: checkIfLocalDataIsEmpty()")
        }
        
        return true
    }
    
    /// Delete all the local data
    fileprivate func deleteLocalData() {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                context.delete(data)
            }
        } catch {
            print("Fail: delete()")
        }
        
        do {
            try context.save()
        } catch {
            print("Fail: save()")
        }
    }
}

// MARK: - LocalDataSourceProtocol protocol conformance

extension LocalDataSource: LocalDataSourceProtocol {
    
    /// Get the categories list
    ///
    /// - Returns: Categories Observable
    func getCategories() -> [CTCocktailCategory]? {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.returnsObjectsAsFaults = false
        
        var categoriesArray = [CTCocktailCategory]()
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let object = CTCocktailCategory(
                    categoryStr: data.value(forKey: self.fieldName) as! String)
                categoriesArray.append(object)
            }
            if categoriesArray.count > 0 { return categoriesArray } else { return nil }
        } catch {
            return nil
        }
    }
    
    /// Save the categories list
    ///
    /// - Parameter categories: Categories list
    func saveCategories(categories: [CTCocktailCategory]) {
        if !checkIfLocalDataIsEmpty() {
            deleteLocalData()
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        
        for category in categories {
            let object = NSManagedObject(entity: entity!, insertInto: context)
            object.setValue(category.categoryStr, forKey: fieldName)
        }
        
        do {
            try context.save()
        } catch {
            print("Fail: saveCategories()")
        }
    }
}
