//
//  ServiceTableViewCell.swift
//  ServicesApp
//
//  Created by Евгений Беляков on 29.03.2024.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {
    static let cellIdentifier = "ServiceTableViewCell"

    private let serviceTitle: UILabel = UILabel(fontSize: 18, fontWeight: .bold, textColor: .label)
    
    private let serviceDescription: UILabel = UILabel(fontSize: 13, fontWeight: .regular, textColor: .label)
    
    private let serviceImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 24
        imageView.image = UIImage(named: "service.placeholder.image")
        
        return imageView
    }()
    
    private let arrowIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "arrow")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .systemGray
        imageView.transform = CGAffineTransform(rotationAngle: 3 * CGFloat.pi / 2)
        
        return imageView
    }()
    
    //    MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        serviceTitle.text = nil
        serviceDescription.text = nil
        serviceImage.image = nil
    }
    
    func configureConstraints() {
        [serviceTitle, serviceDescription, arrowIcon, serviceImage].forEach{
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            serviceImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            serviceImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            serviceImage.heightAnchor.constraint(equalToConstant: 64),
            serviceImage.widthAnchor.constraint(equalToConstant: 64),
            
            serviceTitle.leadingAnchor.constraint(equalTo: serviceImage.trailingAnchor, constant: 10),
            serviceTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            serviceTitle.trailingAnchor.constraint(lessThanOrEqualTo: arrowIcon.leadingAnchor, constant: -10),
            
            
            serviceDescription.topAnchor.constraint(equalTo: serviceTitle.bottomAnchor, constant: 5),
            serviceDescription.leadingAnchor.constraint(equalTo: serviceImage.trailingAnchor, constant: 10),
            serviceDescription.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20),
            serviceDescription.trailingAnchor.constraint(lessThanOrEqualTo: arrowIcon.leadingAnchor, constant: -10),
            
            arrowIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            arrowIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowIcon.widthAnchor.constraint(equalToConstant: 24),
            arrowIcon.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configureCell(cellData: Service){
        serviceTitle.text = cellData.name
        
        serviceDescription.text = cellData.description

    }
    
    func uploadServiceImage(img: UIImage){
        serviceImage.image = img
    }
    
}
