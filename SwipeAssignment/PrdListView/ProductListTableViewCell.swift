//
//  ProductListTableViewCell.swift
//  SwipeAssignment
//
//  Created by Sudeepa Pal on 10/11/24.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let taxLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let apiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.systemOrange.cgColor
        imageView.layer.borderWidth = 2
        return imageView
    }()
    
    
    let favButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemRed
        button.contentMode = .scaleAspectFill
        // button.addTarget(TableViewCell.self, action: #selector(tappingTheButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupUI() {
        // Add subviews
        contentView.addSubview(nameLabel)
        contentView.addSubview(apiImageView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(taxLabel)
        contentView.addSubview(favButton)
        
        NSLayoutConstraint.activate([
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            apiImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            apiImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 80),
            apiImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -80),
            apiImageView.widthAnchor.constraint(equalToConstant: 100),
            apiImageView.heightAnchor.constraint(equalToConstant: 200),
            
            priceLabel.topAnchor.constraint(equalTo: apiImageView.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            taxLabel.topAnchor.constraint(equalTo: apiImageView.bottomAnchor, constant: 5),
            taxLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            favButton.topAnchor.constraint(equalTo: apiImageView.bottomAnchor, constant: 10),
            favButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            favButton.widthAnchor.constraint(equalToConstant: 40),
            favButton.heightAnchor.constraint(equalToConstant: 40),
            
            
            
            
        ])
    }
    
    
}
