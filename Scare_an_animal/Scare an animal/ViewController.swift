//
//  ViewController.swift
//  Scare an animal
//
//  Created by Никита Волков on 18.11.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private let tracksForEveryDanger: [String: [String]] = [
        "Man": [
            "Angry Dog",
            "Aztec",
            "Electro",
            "Growling",
            "Police 1",
            "Police 2",
            "Screaming Lady",
            "Shot 1",
            "Shots 1",
            "Shots 2",
            "Siren",
            "Train",
            "Ultrasound",
            "Wolf"
        ],
        "Hogs": [
            "Angry dog",
            "Electro",
            "Siren",
            "Train",
            "Wolf"
        ],
        "Dogs": [
            "Electro",
            "Siren",
            "Stun gun 1",
            "Stun gun 2",
            "Train",
            "Ultrasound 1",
            "Ultrasound 2",
            "Ultrasound 3"
        ],
        "Birds": [
            "Ultrasound for bird",
            "Vulture"
        ],
        "Bears": [
            "Electro",
            "Screaming Lady",
            "Siren",
            "Train",
            "Ultrasound"
        ]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        makeItemsViews()
        makeTapGestureRecognizer()
    }
    
}

extension ViewController {
    
    private func makeItemsViews() {
        
        let bufferSize = view.frame.height / 60
        
        let peopleView = ItemView(textForLabel: "Man")
        view.addSubview(peopleView)
        makeFontAndItemViewLayer(itemView: peopleView)
        NSLayoutConstraint.activate([
            peopleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            peopleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            peopleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            peopleView.heightAnchor.constraint(equalToConstant: view.frame.height / 10)
        ])
        
        let dogsView = ItemView(textForLabel: "Dogs")
        view.addSubview(dogsView)
        makeFontAndItemViewLayer(itemView: dogsView)
        NSLayoutConstraint.activate([
            dogsView.topAnchor.constraint(equalTo: peopleView.bottomAnchor, constant: bufferSize),
            dogsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            dogsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            dogsView.heightAnchor.constraint(equalToConstant: view.frame.height / 10)
        ])
        
        let bearsView = ItemView(textForLabel: "Bears")
        view.addSubview(bearsView)
        makeFontAndItemViewLayer(itemView: bearsView)
        NSLayoutConstraint.activate([
            bearsView.topAnchor.constraint(equalTo: dogsView.bottomAnchor, constant: bufferSize),
            bearsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            bearsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            bearsView.heightAnchor.constraint(equalToConstant: view.frame.height / 10)
        ])
        
        let birdsView = ItemView(textForLabel: "Birds")
        view.addSubview(birdsView)
        makeFontAndItemViewLayer(itemView: birdsView)
        NSLayoutConstraint.activate([
            birdsView.topAnchor.constraint(equalTo: bearsView.bottomAnchor, constant: bufferSize),
            birdsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            birdsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            birdsView.heightAnchor.constraint(equalToConstant: view.frame.height / 10)
        ])
        
        let hogsView = ItemView(textForLabel: "Hogs")
        view.addSubview(hogsView)
        makeFontAndItemViewLayer(itemView: hogsView)
        NSLayoutConstraint.activate([
            hogsView.topAnchor.constraint(equalTo: birdsView.bottomAnchor, constant: bufferSize),
            hogsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            hogsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            hogsView.heightAnchor.constraint(equalToConstant: view.frame.height / 10)
        ])
    }
    
    private func makeFontAndItemViewLayer(itemView: ItemView) {
        
        let fontSize = view.bounds.width / 10
        itemView.label.font = UIFont(
            name: "Apple Symbols",
            size: fontSize
        )
        
        itemView.layer.borderWidth = 3
        itemView.layer.borderColor = UIColor.white.cgColor
        itemView.layer.cornerRadius = view.frame.height / 40
    }
    
    private func makeTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTheTap)
        )
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func handleTheTap(_ sender: UITapGestureRecognizer) {
        for subview in view.subviews {
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
