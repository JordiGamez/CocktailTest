//
//  CTDrinksViewController.swift
//  CocktailTest
//
//  Created by Jordi Gámez on 20/01/2019.
//  Copyright © 2019 Daniel Moraleda. All rights reserved.
//

import UIKit
import Kingfisher

class CTDrinksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var drinksView: CTDrinksView!
    
    // MARK: - Private constants
    
    private let cellId = "customCell"
    private let customNibName = "CTDrinksViewController"
    private let heightRow: CGFloat = 110.0
    
    // MARK: - Private variables
    
    private var drinkModel: CTDrinksModel
    
    // MARK: - Variables
    
    var categoryName: String? = nil
    
    // MARK: - Initializers
    
    init() {
        self.drinkModel = CTDrinksModel()
        super.init(nibName: customNibName, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
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
    }
    
    // MARK: - Private methods
    
    private func setupController() {
        self.setupTable()
        setTitle()
    }
    
    private func setupTable() {
        self.drinksView.drinksTableView.delegate = self
        self.drinksView.drinksTableView.dataSource = self
    }
    
    private func getCocktailCategories() {
        getCocktailCategoriesFromAPI()
    }
    
    /// Get categories from API
    private func getCocktailCategoriesFromAPI () {
        if let categoryName = categoryName {
            CTAPI.getDrinksByCategory(name: categoryName) { [weak self] (success, failure) in
                if let this = self {
                    if let catList = success {
                        this.drinkModel.setDrinksList(catList: catList.getDrinksList())
                        this.drinksView.drinksTableView.reloadData()
                    }
                    if let error = failure {
                        print("Error: \(error.description)")
                    }
                }
            }
        }
    }
    
    /// Set view title
    private func setTitle() {
        if let categoryName = categoryName {
            self.title = categoryName
        }
    }
    
    // MARK: - Public methods
    
    /// Set category
    ///
    /// - Parameter name: Category name
    func setCocktailCategory(name: String) {
        self.categoryName = name
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.drinkModel.getDrinksListCount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = drinksView.drinksTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CTDrinkTableViewCell
        
        cell.nameLabel?.text = self.drinkModel.getDrinkForIndex(indexPath.row)?.getDrink().name
        if let image = self.drinkModel.getDrinkForIndex(indexPath.row)?.getDrink().image {
            cell.pictureImageView.kf.setImage(with: URL(string: image))
        }
        
        return cell
    }
}
