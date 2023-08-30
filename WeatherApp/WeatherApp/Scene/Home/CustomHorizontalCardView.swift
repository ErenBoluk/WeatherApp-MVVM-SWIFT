//
//  CustomTableViewCell.swift
//  WeatherApp
//
//  Created by midDeveloper on 28.08.2023.
//

import Foundation
import UIKit

class HorizontalCardView: UIView {
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = AppColor.base.color
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = AppColor.base.color
        return label
    }()
    
    init(icon: UIImage, title: String, value: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .init(white: 1, alpha: 0.5)
        layer.cornerRadius = 15 
        layer.borderWidth = 1
        layer.borderColor =  CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.7)
        
        iconImageView.image = icon
        titleLabel.text = title
        valueLabel.text = value
        
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(valueLabel)
        
        // Konumlandırma Kodları
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/7),
            iconImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1/7),
            
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            
            
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    // change title and value
    func update(title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
