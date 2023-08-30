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
    
    private let cityLabel = setCustomLabel(text: "Location", color: AppColor.base.color,fSize: 50)
    
    
    
    private let dateLabel = setCustomLabel(text: "Paz, Jun 30", color: AppColor.secondary.color, fSize: 20)
    
    
    private let degreeLabel = setCustomLabel(text: "32", color: AppColor.base.color,fSize: 75, weight: .medium)
    private let weatherStatusLabel = setCustomLabel(text: "Cloudy", color: AppColor.base.color,fSize: 20)
    
    private let celcLabel = setCustomLabel(text: "\u{00B0}C", color: AppColor.base.color,fSize: 20, align: .right)
    
    // card
    private let titleLabel = setCustomLabel(text: "", color: AppColor.base.color,fSize: 16, weight: .bold)
    
    private let valueLabel = setCustomLabel(text: "", color: AppColor.base.color,fSize: 14, weight: .bold)

    
    
    private let weatherImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "cloudy.png")
        // image.backgroundColor = .systemPink
        return image
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
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let lineView : UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false // Otomatik kontraintleri devre dışı bırak
        line.backgroundColor = UIColor(red: 154/255, green: 147/255, blue: 140/255, alpha: 1)
        
        return line
    }()
    
    var collectionView = setCustomCollectionView()
    
    let humidityCard = HorizontalCardView(icon: UIImage(named: "humidity.png")!, title: "Nem", value: "12%")
    
    
    let nightCard = HorizontalCardView(icon: UIImage(named: "night.png")!, title: "Gece", value: "20\u{00B0}C")
    
    let avgCard = HorizontalCardView(icon: UIImage(named: "avg-degree.png")!, title: "Ortalama", value: "10\u{00B0}C")
    
    

    
    // Weather Model
    var weatherData : [Result] = []
    
    var todayData : Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData(city: userCurrentCity)
        
        // TODO: UIColor+Extension yaz buna
        
        let startColor = AppColor.firstGradient.color
        let endColor = AppColor.secondGradient.color
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        // Görüntüleri StackView'e ekle
        
        degreeStackView.addArrangedSubview(celcLabel)
        degreeStackView.addArrangedSubview(degreeLabel)
        degreeStackView.addArrangedSubview(weatherStatusLabel)
               
        
        todayMainStackView.addArrangedSubview(weatherImage)
        todayMainStackView.addArrangedSubview(degreeStackView)
        
        
        // Info  Cards
       
        
        view.addSubview(humidityCard)
        view.addSubview(nightCard)
        view.addSubview(avgCard)
        
        // View'a ekle
        view.addSubview(cityLabel)
        view.addSubview(dateLabel)
        view.addSubview(todayMainStackView)
        view.addSubview(lineView)
        view.addSubview(collectionView)
        
        let safe = view.safeAreaLayoutGuide
        let mainAnchorW = view.widthAnchor
        // let mainAnchorH = view.heightAnchor
        
        let mainW = view.frame.width
        // let mainH = view.frame.height
        
        //TODO: ViewDidLoad içini bu kadar doldurma. Fonksiyonalara ayır. fonksiyonaları orada call et.
        
        NSLayoutConstraint.activate([
            // CityLabel
            cityLabel.topAnchor.constraint(equalTo: safe.topAnchor, constant: 0),
            cityLabel.leadingAnchor.constraint(equalTo: safe.leadingAnchor , constant: 40),
            cityLabel.trailingAnchor.constraint(equalTo: safe.trailingAnchor , constant: -40),
            //DateLabel
            dateLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 4),
            
            dateLabel.leadingAnchor.constraint(equalTo: safe.leadingAnchor , constant: 40),
            dateLabel.trailingAnchor.constraint(equalTo: safe.trailingAnchor , constant: -40),

            weatherImage.widthAnchor.constraint(equalTo: mainAnchorW, multiplier: 1/3),
            weatherImage.heightAnchor.constraint(equalTo: mainAnchorW, multiplier: 1/3),

            
            todayMainStackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor,constant: 15),
            todayMainStackView.centerXAnchor.constraint(equalTo: safe.leadingAnchor,constant: mainW / 2 - 10),
            
            degreeLabel.heightAnchor.constraint(equalTo: todayMainStackView.heightAnchor, multiplier: 1/2),
            
            weatherStatusLabel.heightAnchor.constraint(equalTo: todayMainStackView.heightAnchor, multiplier: 1/4),
            weatherStatusLabel.topAnchor.constraint(equalTo: degreeLabel.bottomAnchor, constant: 10),
            
            celcLabel.rightAnchor.constraint(equalTo: degreeLabel.rightAnchor, constant: 10),
            
            
            // Cards
            
            humidityCard.topAnchor.constraint(equalTo: todayMainStackView.bottomAnchor, constant: 20),
             //card.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            humidityCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            humidityCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            humidityCard.heightAnchor.constraint(equalTo: safe.heightAnchor, multiplier: 1/10),
            
            nightCard.topAnchor.constraint(equalTo: humidityCard.bottomAnchor, constant: 10),
            nightCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nightCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nightCard.heightAnchor.constraint(equalTo: safe.heightAnchor, multiplier: 1/10),
            
            avgCard.topAnchor.constraint(equalTo: nightCard.bottomAnchor, constant: 10),
            avgCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            avgCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            avgCard.heightAnchor.constraint(equalTo: safe.heightAnchor, multiplier: 1/10),
            
            
            // line
            lineView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 30),
            lineView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant:  -30),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.topAnchor.constraint(equalTo: avgCard.bottomAnchor, constant: 20),
            
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 125)
            
            // collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    
    //TODO: Business logic view model den gelsin.
    func getData(city : String)
    {
        
         HomeViewModel().getWeatherData(city: city) { data,error in
             if let error = error {
                 print("error: \(error.localizedDescription)")
             } else {
                 guard let data = data else {return}
                 
                 self.weatherData = data
                 self.todayData = data[0]
                 self.setDatas()
             }
         }
         
         
        
    }
    
    func setDatas()  {
        
        guard let today = self.todayData  else {
            return
        }
        
        
        print(today)
        self.degreeLabel.text = String(today.degree.prefix(2))
        self.cityLabel.text = self.userCurrentCity.capitalized
        self.weatherStatusLabel.text = today.description.capitalized
        self.dateLabel.text = convertDateFormat(inputDateString: today.date, from: "dd.MM.yyyy", to: "E, MMM d")
        self.weatherImage.image = self.getWeatherImage(status: today.status)
        
        self.humidityCard.update(title: "Nem", value: "\(today.humidity)%")
        self.nightCard.update(title: "Gece", value: "\(today.night.prefix(4)) \u{00B0}C")
        let avg = ( Float(today.max )! + Float(today.min)!) / 2
        self.avgCard.update(title: "Gece", value: "\(String(avg).prefix(4))\u{00B0}C")
        
        
        
        
        self.collectionView.cellData = self.weatherData
        self.collectionView.reloadData()
    }
    func convertDateFormat(inputDateString: String, from inputFormat: String, to outputFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        
        if let date = dateFormatter.date(from: inputDateString) {
            dateFormatter.dateFormat = outputFormat
            return dateFormatter.string(from: date)
        }
        
        return nil
    }

   
    func getWeatherImage(status: String) -> UIImage {
        let img : UIImage
        switch status {
        case "Clear":
            img = UIImage(named: "sun-min.png")!
            
            case "Clouds":
                img = UIImage(named: "cloud-min.png")!
            
            case "Rain":
                img = UIImage(named: "rain-min.png")!
            
        default:
            img = UIImage(named: "cloudy-min.png")!
        }
        return img
    }
}
    
    
    
    


