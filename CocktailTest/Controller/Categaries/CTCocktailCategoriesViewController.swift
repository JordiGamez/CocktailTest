//
//  CTCocktailCategoriesViewController.swift
//  CocktailTest
//
//  Created by Daniel Moraleda on 19/11/18.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import UIKit

class CTCocktailCategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var categoryView: CTCocktailCategoriesView!
    
    private var categoryModel: CTCocktailCategoriesModel
    private var localDataSource: LocalDataSourceProtocol?

    init() {
        self.categoryModel = CTCocktailCategoriesModel()
        self.localDataSource = LocalDataSource()
        super.init(nibName: "CTCocktailCategoriesViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.getCocktailCategories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private methods
    
    private func setupController() {
        self.setupTable()
    }
    
    private func setupTable() {
        self.categoryView.categoriesTableView.delegate = self
        self.categoryView.categoriesTableView.dataSource = self
    }
    
    private func getCocktailCategories() {
        if let localCategories = localDataSource?.getCategories() {
            categoryModel.setCategoriesList(catList: localCategories)
            categoryView.categoriesTableView.reloadData()
            return
        }
        CTAPI.getCocktailCategories { [weak self] (success, failure) in
            if let this = self {
                if let catList = success {
                    this.categoryModel.setCategoriesList(catList: catList.getCategoriesList())
                    this.categoryView.categoriesTableView.reloadData()
                }
                if let error = failure {
                    print("Error: \(error.description)")
                }
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryModel.getCategoriesListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
        cell.textLabel?.text = self.categoryModel.getCategoryForIndex(indexPath.row)?.getCategory()
        
        return cell
    }
}
