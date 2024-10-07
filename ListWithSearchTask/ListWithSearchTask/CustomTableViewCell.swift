//
//  CustomTableViewCell.swift
//  ListWithSearchTask
//
//  Created by abishek m on 07/10/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    let imageViewCell: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imageViewCell)
        contentView.addSubview(label)
        contentView.backgroundColor = UIColor.green.withAlphaComponent(0.3)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        imageViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        imageViewCell.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        imageViewCell.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageViewCell.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        label.leadingAnchor.constraint(equalTo: imageViewCell.trailingAnchor, constant: 10).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
}
