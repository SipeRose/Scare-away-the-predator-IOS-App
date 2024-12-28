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
        
        let itemViewFrameWidth = view.bounds.width * 0.9
        let itemViewFrameHeight = view.bounds.width * 0.4
        let itemViewFrame = CGRect(
            x: 0,
            y: 0,
            width: itemViewFrameWidth,
            height: itemViewFrameHeight
        )
        
        for (index, enemy) in enemies.enumerated() {
            
            let itemView = ItemView(textForLabel: enemy, frame: itemViewFrame)
            scrollView.addSubview(itemView)
            
            itemView.layer.borderWidth = 5
            itemView.layer.borderColor = UIColor.systemBlue.cgColor
            itemView.layer.cornerRadius = view.frame.height / 30
            
            NSLayoutConstraint.activate([
                itemView.widthAnchor.constraint(equalToConstant: itemViewFrameWidth),
                itemView.heightAnchor.constraint(equalToConstant: itemViewFrameHeight),
                itemView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
            
            if index == 0 {
                NSLayoutConstraint.activate([
                    itemView.topAnchor.constraint(equalTo: scrollView.topAnchor)
                ])
            } else {
                let lastSubview = scrollView.subviews[index - 1]
                NSLayoutConstraint.activate([
                    itemView.topAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: view.frame.width / 30)
                ])
            }
    
        }
        
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
                    
                    let label = subview.subviews[1] as! UILabel
                    let dangerName = label.text!
                    vc.tracksNames = tracksForEveryDanger[dangerName]!
                    navigationController?.pushViewController(vc, animated: true)
                    
                }
            }
        }
    }
    
}
