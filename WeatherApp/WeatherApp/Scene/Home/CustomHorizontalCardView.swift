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
        label.textColor = UIColor(red: 49/255, green: 51/255, blue: 65/255, alpha: 1)
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = UIColor(red: 49/255, green: 51/255, blue: 65/255, alpha: 1)
        return label
    }()
    
    init(icon: UIImage, title: String, value: String) {
        super.init(frame: .zero)
        
        backgroundColor = .init(white: 1, alpha: 0.5)
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor =  UIColor.white.cgColor
        
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
            iconImageView.widthAnchor.constraint(equalToConstant: 50),
            iconImageView.heightAnchor.constraint(equalToConstant: 50),
            
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            
            
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
