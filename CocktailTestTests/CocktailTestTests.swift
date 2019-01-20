//
//  CocktailTestTests.swift
//  CocktailTestTests
//
//  Created by Daniel Moraleda on 19/11/18.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import CocktailTest

class CocktailTestTests: QuickSpec {
    
    override func spec() {
        
        // Constants
        
        let nilList: [CTDrinkCategory]? = nil
        let validList: [CTDrinkCategory] = [
            CTDrinkCategory(drinkStr: "wdrinkStr", drinkImg: "wdrinkImg"),
            CTDrinkCategory(drinkStr: "drinkStr", drinkImg: "drinkImg")
        ]
        
        // Variables
        
        var model: CTDrinksModel?
        
        // Tests
        
        beforeEach {
            model = CTDrinksModel()
        }
        describe("when model is initialized") {
            context("given a valid model class") {
                it("should create an empty drinkList variable") {
                    expect(model?.drinkList).to(equal([]))
                }
            }
        }
        describe("when setting the drinks list") {
            context("given a nil array") {
                beforeEach {
                    model?.setDrinksList(catList: nilList)
                }
                it("should remove the current array content") {
                    expect(model?.drinkList).to(equal([]))
                }
            }
            context("given valid array") {
                var result: [CTDrinkCategory]? = nil
                beforeEach {
                    model?.setDrinksList(catList: validList)
                    result = model?.orderDrinksAlphabetically(list: (model?.drinkList)!)
                }
                it("should add the content to the current array") {
                    expect(model?.drinkList).to(equal(result))
                }
            }
        }
        describe("when getting the drinks list count") {
            context("given an empty list") {
                var result = 0
                beforeEach {
                    model?.drinkList = []
                    result = (model?.getDrinksListCount())!
                }
                it("should return zero") {
                    expect(result).to(be(0))
                }
            }
            context("given a valid list") {
                var result = 0
                beforeEach {
                    model?.drinkList = validList
                    result = (model?.getDrinksListCount())!
                }
                it("should return one") {
                    expect(result).to(be(validList.count))
                }
            }
        }
        describe("when getting the first element from the array") {
            context("given an empty list") {
                var result: CTDrinkCategory? = nil
                beforeEach {
                    model?.drinkList = []
                    result = model?.getDrinkForIndex(0)
                }
                it("should return nil") {
                    expect(result).to(beNil())
                }
            }
            context("given a valid list") {
                var result: CTDrinkCategory? = nil
                beforeEach {
                    model?.drinkList = validList
                    result = model?.getDrinkForIndex(0)
                }
                it("should return the first element name") {
                    expect(result?.drinkStr).to(be("wdrinkStr"))
                }
                it("should return the first element image") {
                    expect(result?.drinkImg).to(be("wdrinkImg"))
                }
            }
        }
        describe("when ordering the array alphabetically") {
            context("given a valid list") {
                var result: [CTDrinkCategory]? = nil
                beforeEach {
                    model?.drinkList = validList
                    result = model?.orderDrinksAlphabetically(list: (model?.drinkList)!)
                }
                it("should order the array alphabetically first element name check") {
                    if let list = result {
                        expect(list[0].drinkStr).to(be("drinkStr"))
                    }
                }
                it("should order the array alphabetically first element image check") {
                    if let list = result {
                        expect(list[0].drinkImg).to(be("drinkImg"))
                    }
                }
                it("should order the array alphabetically second element name check") {
                    if let list = result {
                        expect(list[1].drinkStr).to(be("wdrinkStr"))
                    }
                }
                it("should order the array alphabetically second element image check") {
                    if let list = result {
                        expect(list[1].drinkImg).to(be("wdrinkImg"))
                    }
                }
            }
        }
        afterEach {
            
        }
    }
}
