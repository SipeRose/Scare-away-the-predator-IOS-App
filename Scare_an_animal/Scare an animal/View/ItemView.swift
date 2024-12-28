//
//  ItemView.swift
//  Scare an animal
//
//  Created by Никита Волков on 18.11.2024.
//

import UIKit

class ItemView: UIView {
    
    var label: UILabel!
    var dangerName = ""
    var imageView: UIImageView!

    
    init(textForLabel: String, frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        dangerName = textForLabel
        addImageView()
        addLabel(text: textForLabel)
        addDescriptionLabel()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



extension ItemView {
    
    private func addImageView() {
        
        imageView = UIImageView()
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: frame.width / 20),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: frame.width / 20),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -frame.width / 20),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
        
        imageView.image = UIImage(named: dangerName)
        
    }
    
    private func addLabel(text: String) {
        
        label = UILabel()
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: frame.width / 5),
            self.label.topAnchor.constraint(equalTo: imageView.topAnchor)
        ])
        
        label.text = text
        label.textColor = .blue
        label.font = UIFont(
            name: "BigCaslon",
            size: frame.width / 10
        )

    }
    
    private func addDescriptionLabel() {
        
        let descriptionLabel = UILabel()
        self.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: frame.width / 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -frame.width / 20),
            descriptionLabel.topAnchor.constraint(equalTo: self.label.bottomAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -frame.width / 20)
        ])
        
        descriptionLabel.text = dangersDescription[dangerName]
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont(
            name: "SystemFont",
            size: frame.width / 23
        )
        
    }
    
}
