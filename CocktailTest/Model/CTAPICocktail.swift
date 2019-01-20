//
//  CTAPICocktail.swift
//  CocktailTest
//
//  Created by Daniel Moraleda on 19/11/18.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import Alamofire
import Unbox

extension CTAPI {
    static func getCocktailCategories(_ completion: @escaping (_ response: CTCategoriesList?, _ error: NSError?) -> Void) {
        Alamofire.request(apiHsot() + "list.php", method: .get, parameters: ["c":"list"], encoding: URLEncoding.default, headers: nil).validate().responseJSON { (response) in
            switch response.result {
            case .success(let data):
                do {
                    if data is NSNull {
                        completion(nil, nil)
                    }
                    else {
                        let categoriesList: CTCategoriesList = try unbox(dictionary: data as! UnboxableDictionary)
                        completion(categoriesList, nil)
                    }
                } catch {
                    completion(nil, NSError())
                }
            case .failure(let error):
                completion(nil, error as NSError)
            }
        }
    }
}
