//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by midDeveloper on 28.08.2023.
//

import Foundation
import UIKit
import CoreLocation


class HomeViewController: UIViewController{
  
    
    
    // CoreLocation Vars
    var locationManager = CLLocationManager()
    var usersCurrentLatitude: Double?
    var usersCurrentLongitude: Double?
    var didPerformGeocode = false
    var usersLocation = ""
    var userCurrentCity = ""
    
    
    private let cityLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Location"
        label.font = .systemFont(ofSize: 50,weight: .regular)
        label.textColor = UIColor(red: 49/255, green: 51/255, blue: 65/255, alpha: 1)
        return label
    }()
    private let dateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Paz, Jun 30"
        label.font = .systemFont(ofSize: 20 ,weight: .regular)
        label.textColor = UIColor(red: 154/255, green: 147/255, blue: 140/255, alpha: 1)
        return label
    }()
    
    private let weatherImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "cloudy.png")
        // image.backgroundColor = .systemPink
        return image
    }()
    private let degreeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "30"
        label.font = .systemFont(ofSize: 75 ,weight: .medium)
        label.textAlignment = .center
        // label.backgroundColor = .systemGray
        label.textColor = UIColor(red: 49/255, green: 51/255, blue: 65/255, alpha: 1)
        
        return label
    }()
    private let weatherStatusLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        label.text = "Cloudy"
        label.font = .systemFont(ofSize: 20 ,weight: .regular)
        label.textColor = UIColor(red: 49/255, green: 51/255, blue: 65/255, alpha: 1)
        return label
    }()
    
    private let celcLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.text = "\u{00B0}C"
        label.font = .systemFont(ofSize: 20 ,weight: .regular)
        label.textColor = UIColor(red: 49/255, green: 51/255, blue: 65/255, alpha: 1)
        return label
    }()
    
    private let todayMainStackView : UIStackView = {
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.distribution = .equalCentering
        // stackView.backgroundColor = .systemIndigo
        
        
        return stackView
        
    }()
    
    private let degreeStackView : UIStackView = {
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
            
        stackView.distribution = .fillProportionally
        // stackView.backgroundColor = .systemYellow
        
        
        return stackView
        
    }()
    
    
    
    // card
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()

    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    
    // Weather Model
    let weather : [Weather] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Gradient renkleri
       let startColor = UIColor(red: 254/255, green: 226/255, blue: 198/255, alpha: 1).cgColor
       let endColor = UIColor(red: 254/255, green: 189/255, blue: 139/255, alpha: 1).cgColor
       
       // Gradient katmanını oluştur
       let gradientLayer = CAGradientLayer()
       gradientLayer.colors = [startColor, endColor]
       
    
        // Gradient'in başlangıç ve bitiş noktalarını belirle (135 derece)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
       
       // Gradient katmanının boyutunu ayarla (örneğin, tüm ekranı kaplamak için)
       gradientLayer.frame = view.bounds
       
       // Gradient katmanını arka plana ekle
       view.layer.insertSublayer(gradientLayer, at: 0)

        
        
        // Görüntüleri StackView'e ekle
        
        degreeStackView.addArrangedSubview(celcLabel)
        degreeStackView.addArrangedSubview(degreeLabel)
        degreeStackView.addArrangedSubview(weatherStatusLabel)
               
        
        todayMainStackView.addArrangedSubview(weatherImage)
        todayMainStackView.addArrangedSubview(degreeStackView)
        
        
        // Info  Cards
        
        let card = HorizontalCardView(icon: UIImage(named: "humidity.png")!, title: "Nem", value: "12%")
        card.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(card)
        
        // View'a ekle
        view.addSubview(cityLabel)
        view.addSubview(dateLabel)
        view.addSubview(todayMainStackView)
        let safe = view.safeAreaLayoutGuide
        let mainAnchorW = view.widthAnchor
        let mainAnchorH = view.heightAnchor
        
        let mainW = view.frame.width
        let mainH = view.frame.height
        
        NSLayoutConstraint.activate([
            // CityLabel
            cityLabel.topAnchor.constraint(equalTo: safe.topAnchor, constant: 10),
            cityLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: safe.leadingAnchor, multiplier: 5),
            //DateLabel
            dateLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: safe.leadingAnchor, multiplier: 5),

            weatherImage.widthAnchor.constraint(equalTo: mainAnchorW, multiplier: 1/2.1),
            weatherImage.heightAnchor.constraint(equalTo: mainAnchorW, multiplier: 1/2.1),

            
            todayMainStackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor,constant: 15),
            todayMainStackView.centerXAnchor.constraint(equalTo: safe.leadingAnchor,constant: mainW / 2 - 10),
            
            degreeLabel.heightAnchor.constraint(equalTo: todayMainStackView.heightAnchor, multiplier: 1/3.2),
            
            weatherStatusLabel.heightAnchor.constraint(equalTo: todayMainStackView.heightAnchor, multiplier: 1/4),
            weatherStatusLabel.topAnchor.constraint(equalTo: degreeLabel.bottomAnchor, constant: 10),
            
            celcLabel.rightAnchor.constraint(equalTo: degreeLabel.rightAnchor, constant: 10),
            
            
            // Cards
            
            card.topAnchor.constraint(equalTo: todayMainStackView.bottomAnchor, constant: 20),
             //card.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            card.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            card.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            card.heightAnchor.constraint(equalToConstant: 75)
        ])
        
        
    }
    func getData(city : String)
    {
        /*
         WeatherViewModel().getWeatherData(city: city) { data,error in
             if let error = error {
                 print("error: \(error.localizedDescription)")
             } else {
                 guard var data = data else {return}
                 
                 // data
                 print(data)
                 
             }
         }
         e
         */
        
    }
    
}
    
    
    
    


