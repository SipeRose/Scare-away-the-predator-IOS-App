//
//  ItemView.swift
//  Scare an animal
//
//  Created by Никита Волков on 18.11.2024.
//

import UIKit

class ItemView: UIView {
    
    var label: UILabel!

    
    init(textForLabel: String) {
        super.init(frame: CGRect())
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .black
        
        makeLabel(text: textForLabel)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ItemView {
    
    private func makeLabel(text: String) {
        
        label = UILabel()
        label.text = text
        label.textColor = .systemGreen
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        /*
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        */
    }
    
}
