
//
//  ProductFetchViewController.swift
//  SwipeAssignment
//
//  Created by Sudeepa Pal on 10/11/24.
//

import UIKit
import RealmSwift

class ProductFetchViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    let realm = try! Realm()
    private var favs: [Favourites] = []
    
    private let loadingView = LoadingView()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // Data source for the table view
    var products: [ProductListModel] = []
    var filteredProducts: [ProductListModel] = [] // For search results
    
    // API URL
    let productURL = "https://app.getswipe.in/api/public/get"
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search Products"
        //searchBar.layer.borderWidth = 1
        //searchBar.layer.borderColor = UIColor.systemOrange.cgColor
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.systemOrange.cgColor
            textField.layer.cornerRadius = 10
            textField.clipsToBounds = true
        }
        return searchBar
    }()
    
    let addProductsBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add New", for: .normal)
        button.backgroundColor = .systemOrange
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(addProductVC), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup view and table view
        view.backgroundColor = .white
        title = "All Products"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProductListTableViewCell.self, forCellReuseIdentifier: "cell")
        
        searchBar.delegate = self // Set the search bar delegate
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(addProductsBtn)
        
        setupContraints()
        
        // Fetch data from the API
        fetchProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favs = Array(realm.objects(Favourites.self))
        tableView.reloadData()
        fetchProducts()
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            addProductsBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            addProductsBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            addProductsBtn.widthAnchor.constraint(equalToConstant: 100),
            addProductsBtn.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc func addProductVC() {
        navigationController?.pushViewController(ProductAddViewController(), animated: true)
    }
    
    // Fetch products from the API
    func fetchProducts() {
        
        loadingView.show(on: view)
        
        guard let url = URL(string: productURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                DispatchQueue.main.async {
                    self.loadingView.hide()
                }
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.loadingView.hide()
                }
                print("No data found")
                return
            }
            
            do {
                // Decode the JSON data
                let products = try JSONDecoder().decode([ProductListModel].self, from: data)
                DispatchQueue.main.async {
                    // Update the data source and reload the table view
                    self.products = products
                    self.filteredProducts = products // Initialize filtered products with full list
                    self.tableView.reloadData()
                    self.loadingView.hide()
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        task.resume()
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Filter products based on search text
        if searchText.isEmpty {
            filteredProducts = products // Show all products if search text is empty
        } else {
            filteredProducts = products.filter { product in
                product.product_name.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductListTableViewCell
        
        // Configure cell with filtered product data
        let product = filteredProducts[indexPath.row]
        cell.nameLabel.text = product.product_name
        cell.priceLabel.text = "\(product.price)"
        cell.taxLabel.text = "\(product.tax)"
        cell.favButton.tag = indexPath.row
        cell.favButton.addTarget(self, action: #selector(addedToFavourite), for: .touchUpInside)
        
        // Load image from URL
        if let imageURL = URL(string: product.image) {
            loadImage(from: imageURL) { image in
                DispatchQueue.main.async {
                    cell.apiImageView.image = image
                }
            }
        } else {
            cell.apiImageView.image = UIImage(named: "InsteadImage") // fallback image
            cell.apiImageView.layer.cornerRadius = 40
        }
        
        if let fav = favs.first(where: { $0.uniqueKey == product.uniqueKey }), fav.fav {
            cell.favButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
            print("true")
        } else {
            cell.favButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
            print("false")
        }
        
        cell.setupUI()
        return cell
    }
    
    // Helper function to load images asynchronously
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, error == nil {
                completion(UIImage(data: data))
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    @objc func addedToFavourite(_ sender: UIButton) {
        print("Sender ->", sender.tag)
        AlertView.showAlert("Alert", message: "Product have been added to favourites", okTitle: "Okay")
        sender.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        
        let rowIndex = sender.tag
        let productTitle = products[rowIndex].product_name
        let productPrice = products[rowIndex].price
        let productType = products[rowIndex].product_type
        let productTax = products[rowIndex].tax
        let productImg = products[rowIndex].image
        
        let product = products[rowIndex]
        
        if let fav = favs.first(where: { $0.uniqueKey == product.uniqueKey }) {
            try! realm.write {
                fav.fav.toggle()
            }
        } else {
            let newFav = Favourites()
            newFav.title = productTitle
            newFav.price = productPrice
            newFav.productType = productType
            newFav.productTax = productTax
            newFav.productImage = productImg
            newFav.fav = true
            favs.append(newFav)
            try! realm.write {
                realm.add(newFav)
            }
        }
        
        tableView.reloadRows(at: [IndexPath(row: rowIndex, section: 0)], with: .none)
        
    }
}

extension ProductFetchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
}
