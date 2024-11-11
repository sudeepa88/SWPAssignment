//
//  ProductFetchViewController.swift
//  SwipeAssignment
//
//  Created by Sudeepa Pal on 10/11/24.
//

import UIKit

class ProductFetchViewController: UIViewController, UITableViewDataSource {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // Data source for the table view
    var products: [ProductListModel] = []
    
    // API URL
    let productURL = "https://app.getswipe.in/api/public/get"
    
    
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
        view.addSubview(tableView)
        view.addSubview(addProductsBtn)
        
        setupContraintsOfTableView()
        
        // Fetch data from the API
        fetchProducts()
    }

    override func viewWillAppear(_ animated: Bool) {
        fetchProducts()
        tableView.reloadData()
    }
    
    
    
    func setupContraintsOfTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
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
        guard let url = URL(string: productURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data found")
                return
            }
            
            do {
                // Decode the JSON data
                let products = try JSONDecoder().decode([ProductListModel].self, from: data)
                DispatchQueue.main.async {
                    // Update the data source and reload the table view
                    self.products = products
                    self.tableView.reloadData()
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        task.resume()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductListTableViewCell
        
        // Configure cell with product data
        let product = products[indexPath.row]
        cell.nameLabel.text = product.product_name
        cell.priceLabel.text = "\(product.price)"
        cell.taxLabel.text = "\(product.tax)"
        
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
}

extension ProductFetchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
}
