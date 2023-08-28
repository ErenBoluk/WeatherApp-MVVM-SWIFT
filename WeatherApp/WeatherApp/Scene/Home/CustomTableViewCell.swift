//
//  CustomTableViewCell.swift
//  WeatherApp
//
//  Created by midDeveloper on 28.08.2023.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    // Özel hücre öğeleri burada tanımlanabilir
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         
         // Hücre öğelerinin yerleşimi ve özellikleri burada ayarlanabilir
         // Örneğin, titleLabel ve subtitleLabel'ın yerleşimi, renkleri, yazı tipleri, vs.
         
         // Örnek yerleşim ve özellikler
         titleLabel.translatesAutoresizingMaskIntoConstraints = false
         subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
         contentView.addSubview(titleLabel)
         contentView.addSubview(subtitleLabel)
         
         titleLabel.textColor = .black
         subtitleLabel.textColor = .gray
         titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
         subtitleLabel.font = UIFont.systemFont(ofSize: 14)
         
         NSLayoutConstraint.activate([
             titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
             titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
             subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
             subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
         ])
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
