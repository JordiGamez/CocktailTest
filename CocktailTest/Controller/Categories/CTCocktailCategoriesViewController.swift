//
//  CTCocktailCategoriesViewController.swift
//  CocktailTest
//
//  Created by Daniel Moraleda on 19/11/18.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import UIKit

class CTCocktailCategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var categoryView: CTCocktailCategoriesView!
    
    // MARK: - Private constants
    
    private let screenTitle = "Categories"
    private let cellId = "cellId"
    private let customNibName = "CTCocktailCategoriesViewController"
    
    // MARK: - Private variables
    
    private var categoryModel: CTCocktailCategoriesModel
    private var localDataSource: LocalDataSourceProtocol?
    
    // MARK: - Initializers
    
    init() {
        self.categoryModel = CTCocktailCategoriesModel()
        self.localDataSource = LocalDataSource()
        super.init(nibName: customNibName, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupController()
        listenForPullToRefresh()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.getCocktailCategories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Private methods
    
    private func setupController() {
        self.setupTable()
        setTitle()
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
        getCocktailCategoriesFromAPI()
    }
    
    /// Get categories from API
    private func getCocktailCategoriesFromAPI () {
        CTAPI.getCocktailCategories { [weak self] (success, failure) in
            if let this = self {
                this.categoryView.stopRefreshAnimation()
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
    
    /// Listen for pull to refresh TableView
    private func listenForPullToRefresh() {
        categoryView.reloadTableCallback = {
            self.getCocktailCategoriesFromAPI()
        }
    }
    
    /// Set view title
    private func setTitle() {
        self.title = screenTitle
    }

    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryModel.getCategoriesListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        
        cell.textLabel?.text = self.categoryModel.getCategoryForIndex(indexPath.row)?.getCategory()
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedCategory = self.categoryModel.getCategoryForIndex(indexPath.row)?.getCategory() {
            let drinksViewController = CTDrinksViewController()
            drinksViewController.setCocktailCategory(name: selectedCategory)
            self.navigationController?.pushViewController(drinksViewController, animated: true)
        }
    }
}
