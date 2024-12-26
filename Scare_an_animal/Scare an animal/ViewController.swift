//
//  ViewController.swift
//  Scare an animal
//
//  Created by Никита Волков on 18.11.2024.
//

import UIKit

class ViewController: UIViewController {
    
    var scrollView: UIScrollView!
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .black
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        addScrollView()
        makeItemsViews()
        makeTapGestureRecognizer()
    }
    
}

extension ViewController {
    
    private func addScrollView() {
        scrollView = UIScrollView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.bounds.width,
                height: view.bounds.height
            )
        )
        scrollView.contentSize = CGSize(
            width: view.bounds.width,
            height: 5 * (view.frame.width * 1.2 / 3) + 6 * (view.frame.width / 30)
        )
        scrollView.backgroundColor = .white
        view.addSubview(scrollView)
    }
    
    private func makeItemsViews() {
        
        let enemies = ["Man", "Dogs", "Bears", "Birds", "Hogs"]
        
        for (index, enemy) in enemies.enumerated() {
            
            let itemView = ItemView(textForLabel: enemy)
            scrollView.addSubview(itemView)
            makeFontAndItemViewLayer(itemView: itemView)
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width / 20),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width / 20),
                itemView.heightAnchor.constraint(equalToConstant: view.frame.width * 1.2 / 3),
            ])
            if index == 0 {
                NSLayoutConstraint.activate([
                    itemView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: view.frame.width / 30)
                ])
            } else {
                let lastSubview = scrollView.subviews[index - 1]
                NSLayoutConstraint.activate([
                    itemView.topAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: view.frame.width / 30)
                ])
                
            }
            let imageView = UIImageView()
            itemView.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: itemView.topAnchor, constant: view.frame.width / 20),
                imageView.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: view.frame.width / 20),
                imageView.bottomAnchor.constraint(equalTo: itemView.bottomAnchor, constant: -view.frame.width / 20),
                imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
            ])
            imageView.image = UIImage(named: "Logo")
            
            NSLayoutConstraint.activate([
                itemView.label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: view.frame.width / 5),
                itemView.label.topAnchor.constraint(equalTo: imageView.topAnchor)
            ])
            
            let descriptionLabel = UILabel()
            itemView.addSubview(descriptionLabel)
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                descriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: view.frame.width / 20),
                descriptionLabel.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -view.frame.width / 20),
                descriptionLabel.topAnchor.constraint(equalTo: itemView.label.bottomAnchor),
                descriptionLabel.bottomAnchor.constraint(equalTo: itemView.bottomAnchor, constant: -view.frame.width / 20)
            ])
            descriptionLabel.text = "Hello\nHello\nHello\nHello\n"
            descriptionLabel.textColor = .green
            descriptionLabel.numberOfLines = 0
        }
        
    }
    
    private func makeFontAndItemViewLayer(itemView: ItemView) {
        
        let fontSize = view.bounds.width / 10
        itemView.label.font = UIFont(
            name: "Apple Symbols",
            size: fontSize
        )
        
        itemView.layer.borderWidth = 5
        itemView.layer.borderColor = UIColor.green.cgColor
        itemView.layer.cornerRadius = view.frame.height / 30
    }
    
    private func makeTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTheTap)
        )
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func handleTheTap(_ sender: UITapGestureRecognizer) {
        for subview in scrollView.subviews {
            if subview.frame.contains(sender.location(ofTouch: 0, in: view)) {
                if let vc = storyboard?.instantiateViewController(withIdentifier: "SoundVC") as? SoundViewController {
                    
                    let label = subview.subviews.first as! UILabel
                    let dangerName = label.text!
                    vc.tracksNames = tracksForEveryDanger[dangerName]!
                    navigationController?.pushViewController(vc, animated: true)
                    
                }
            }
        }
    }
    
}
