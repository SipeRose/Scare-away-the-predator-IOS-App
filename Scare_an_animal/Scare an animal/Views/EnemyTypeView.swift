//
//  EnemyTypeView.swift
//  Scare an animal
//
//  Created by Никита Волков on 18.11.2024.
//

import UIKit

// MARK: EnemyTypeView
// Contains a description of every type of enemy

class EnemyTypeView: UIView {
    
    var enemyTypeLabel: UILabel!
    var enemyType: String!
    var imageView: UIImageView!

    
    init(with enemyType: String, frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.enemyType = enemyType
        makeViewLayer()
        addImageView()
        addEnemyTypeLabel(for: enemyType)
        addEnemyDescriptionLabel()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: Adding subviews and layer
extension EnemyTypeView {
    
    private func makeViewLayer() {
        layer.borderWidth  = 5
        layer.borderColor  = UIColor.systemBlue.cgColor
        layer.cornerRadius = frame.width / 15
    }
    
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
        
        imageView.image = UIImage(named: enemyType)
        
    }
    
    private func addEnemyTypeLabel(for enemyType: String) {
        
        enemyTypeLabel = UILabel()
        self.addSubview(enemyTypeLabel)
        enemyTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.enemyTypeLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: frame.width / 5),
            self.enemyTypeLabel.topAnchor.constraint(equalTo: imageView.topAnchor)
        ])
        
        enemyTypeLabel.text = enemyType
        enemyTypeLabel.textColor = .blue
        enemyTypeLabel.font = UIFont(
            name: "BigCaslon",
            size: frame.width / 10
        )

    }
    
    private func addEnemyDescriptionLabel() {
        
        let enemyDescriptionLabel = UILabel()
        self.addSubview(enemyDescriptionLabel)
        enemyDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            enemyDescriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: frame.width / 20),
            enemyDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -frame.width / 20),
            enemyDescriptionLabel.topAnchor.constraint(equalTo: self.enemyTypeLabel.bottomAnchor),
            enemyDescriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -frame.width / 20)
        ])
        
        enemyDescriptionLabel.text = dangersDescription[enemyType]
        enemyDescriptionLabel.textAlignment = .left
        enemyDescriptionLabel.textColor = .black
        enemyDescriptionLabel.numberOfLines = 0
        enemyDescriptionLabel.font = UIFont(
            name: "SystemFont",
            size: frame.width / 23
        )
        
    }
    
}
