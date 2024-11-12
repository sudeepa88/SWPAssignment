//
//  ProductAddViewController.swift
//  SwipeAssignment
//
//  Created by Sudeepa Pal on 10/11/24.
//

import UIKit
import Alamofire

class ProductAddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let productTitle: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.systemOrange.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 10

        // Set placeholder with color
        textField.attributedPlaceholder = NSAttributedString(
            string: "Product Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemOrange]
        )

        // Add left padding
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always

        return textField
    }()

    let productType: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.systemOrange.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 10

        // Set placeholder with color
        textField.attributedPlaceholder = NSAttributedString(
            string: "Product Type",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemOrange]
        )

        // Add left padding
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always

        return textField
    }()

    let productPrice: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.systemOrange.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 10

        // Set placeholder with color
        textField.attributedPlaceholder = NSAttributedString(
            string: "Rate",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemOrange]
        )

        // Add left padding
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always

        return textField
    }()

    let productTax: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.systemOrange.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 10

        // Set placeholder with color
        textField.attributedPlaceholder = NSAttributedString(
            string: "Tax",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemOrange]
        )

        // Add left padding
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always

        return textField
    }()

    
    let addButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("Add Product", for: .normal)
        button.backgroundColor = .systemOrange
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(dataSubmitting), for: .touchUpInside)
        return button
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderColor = UIColor.systemOrange.cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = 10  // Optional, adds rounded corners
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    // Button to open image picker
    let uploadButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 20
        button.backgroundColor = .systemBlue
        button.setTitle("Choose Image", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "Add Product"
        
        view.addSubview(imageView)
        view.addSubview(uploadButton)
        
        view.addSubview(productTitle)
        view.addSubview(productType)
        view.addSubview(productPrice)
        view.addSubview(productTax)
        
        view.addSubview(addButton)
        
        setUpLayout()
        
    }
    
    
    func setUpLayout() {
        NSLayoutConstraint.activate([
            productTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            productTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            productTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            productTitle.heightAnchor.constraint(equalToConstant: 50),
            
            productType.topAnchor.constraint(equalTo: productTitle.bottomAnchor, constant: 2),
            productType.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            productType.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            productType.heightAnchor.constraint(equalToConstant: 50),
            
            
            productPrice.topAnchor.constraint(equalTo: productType.bottomAnchor, constant: 2),
            productPrice.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            productPrice.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            productPrice.heightAnchor.constraint(equalToConstant: 50),
            
            productTax.topAnchor.constraint(equalTo: productPrice.bottomAnchor, constant: 2),
            productTax.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            productTax.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            productTax.heightAnchor.constraint(equalToConstant: 50),
            
            
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: productTax.bottomAnchor, constant: 5),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            // uploadButton constraints
            uploadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uploadButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            uploadButton.widthAnchor.constraint(equalToConstant: 100),
            uploadButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            addButton.topAnchor.constraint(equalTo: uploadButton.bottomAnchor, constant: 2),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 120),
            addButton.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    
    
    @objc func dataSubmitting() {
        
        if productTitle.text?.isEmpty ?? true {
            AlertView.showAlert("Alert", message: "Please add a name", okTitle: "Okay")
            print("Product title is empty")
        } else if productType.text?.isEmpty ?? true {
            AlertView.showAlert("Alert", message: "Please add a type of product", okTitle: "Okay")
        } else if productPrice.text?.isEmpty ?? true {
            AlertView.showAlert("Alert", message: "Please add a product price", okTitle: "Okay")
        } else if productTax.text?.isEmpty ?? true {
            AlertView.showAlert("Alert", message: "Please add tax on this product", okTitle: "Okay")
        } else {
            let nameOfProduct = productTitle.text!
            let typeOfProduct = productType.text!
            let priceOfProduct = productPrice.text!
            let taxOfProduct = productTax.text!
            
            uploadImageAndData(image: imageView.image!, textField1: nameOfProduct, textField2: typeOfProduct, textField3: priceOfProduct, textField4: taxOfProduct) { result in
                switch result {
                case .success(let data):
                    print("Upload successful with response data: \(String(data: data ?? Data(), encoding: .utf8) ?? "")")
                    self.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    print("Upload failed with error: \(error)")
                }
            }
        }
    }

    
    @objc func openImagePicker() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // Handle the image picked
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        // Retrieve and set the selected image
        if let selectedImage = info[.originalImage] as? UIImage {
            imageView.image = selectedImage
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func uploadImageAndData(image: UIImage, textField1: String, textField2: String, textField3: String, textField4: String, completion: @escaping (Result<Data?, AFError>) -> Void) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.7) else {
            print("Failed to convert image to data")
            return
        }
        
        
        let url = "https://app.getswipe.in/api/public/add"
        
        
        let parameters: [String: String] = [
            "product_name": textField1,
            "product_type": textField2,
            "price": textField3,
            "tax": textField4
        ]
        
        
        AF.upload(
            multipartFormData: { multipartFormData in
                
                multipartFormData.append(imageData, withName: "files[]", fileName: "image.jpg", mimeType: "image/jpeg")
                
                
                for (key, value) in parameters {
                    multipartFormData.append(Data(value.utf8), withName: key)
                }
            },
            to: url,
            method: .post
        ).response { response in
            
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
