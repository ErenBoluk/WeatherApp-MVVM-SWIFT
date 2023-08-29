import UIKit

class CustomCell: UICollectionViewCell {
    
    private let imageView : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "cloudy-min.png")
        return image
        
    }()
    
    let degreeLabel =  setCustomLabel(text: "", color: .black, fSize: 14, weight: .medium, align: .center)
    let  dayLabel =  setCustomLabel(text: "Cmt", color: AppColor.secondary.color, fSize: 14, weight: .regular, align: .center)
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    private func setupUI() {
        backgroundColor = UIColor(white: 1, alpha: 0.5)
        layer.cornerRadius = frame.width/2 // Köşe yuvarlama ekleniyor
        layer.borderColor = CGColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
        layer.borderWidth =  1
        
        addSubview(degreeLabel)
        addSubview(imageView)
        addSubview(dayLabel)
        NSLayoutConstraint.activate([
            degreeLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            degreeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            degreeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            degreeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            
            dayLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -5),
            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dayLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/2.8),
            imageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 1/2.8)
            
            
        ])
        
    }
    
    
    
   
    
    func configure(with title: String) {
        degreeLabel.text = title
    }
}
