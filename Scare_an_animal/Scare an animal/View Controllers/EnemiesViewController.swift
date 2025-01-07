//
//  EnemiesViewController.swift
//  Scare an animal
//
//  Created by Никита Волков on 18.11.2024.
//

import UIKit

// MARK: EnemiesViewController
// Includes EnemyTypeViews containing a description of each of the enemies
// to select a specific type of sounds to scare away

class EnemiesViewController: UIViewController {
    
    var scrollView: UIScrollView!
    
    override func loadView() {
        
        super.loadView()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        addScrollView()
        addEnemyTypeViews()
        addTapGestureRecognizer()
        
    }
    
}


// MARK: Adding subviews and gesture recognizer
// Subviews:
// - ScrollView as the container for EnemyTypeViews
// - EnemyTypeViews
// Gesture recognizer to select the type of enemy

extension EnemiesViewController {
    
    private func addScrollView() {
        
        scrollView = UIScrollView(
            frame: CGRect(
                x: 0,
                y: 0,
                width:  view.bounds.width,
                height: view.bounds.height
            )
        )
        scrollView.contentSize = CGSize(
            width:  view.bounds.width,
            height: 5 * (view.frame.width * 1.2 / 3) + 6 * (view.frame.width / 30)
        )

        view.addSubview(scrollView)
    }
    
    
    private func addEnemyTypeViews() {
        
        let enemies = ["Man", "Dogs", "Bears", "Birds", "Hogs"]
        
        let enemyTypeViewWidth = view.bounds.width * 0.9
        let enemyTypeViewHeight = view.bounds.width * 0.4
        let enemyTypeViewFrame = CGRect(
            x: 0,
            y: 0,
            width:  enemyTypeViewWidth,
            height: enemyTypeViewHeight
        )
        
        for (index, enemyType) in enemies.enumerated() {
            
            let enemyTypeView = EnemyTypeView(with: enemyType, frame: enemyTypeViewFrame)
            scrollView.addSubview(enemyTypeView)
            
// MARK: Layout
            
            NSLayoutConstraint.activate([
                enemyTypeView.widthAnchor.constraint(equalToConstant: enemyTypeViewWidth),
                enemyTypeView.heightAnchor.constraint(equalToConstant: enemyTypeViewHeight),
                enemyTypeView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
            
            if index == 0 {
                NSLayoutConstraint.activate([
                    enemyTypeView.topAnchor.constraint(equalTo: scrollView.topAnchor)
                ])
            } else {
                let lastAddedSubview = scrollView.subviews[index - 1]
                NSLayoutConstraint.activate([
                    enemyTypeView.topAnchor.constraint(equalTo: lastAddedSubview.bottomAnchor, constant: view.frame.width / 30)
                ])
            }
    
        }
        
    }
    
    
    private func addTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(selectEnemyType)
        )
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
// MARK: Detecting a click on EnemyTypeView
    
    @objc private func selectEnemyType(_ sender: UITapGestureRecognizer) {
        
        for enemyTypeView in scrollView.subviews {
            
            if enemyTypeView.frame.contains(sender.location(ofTouch: 0, in: view)) {
                if let vc = storyboard?.instantiateViewController(withIdentifier: "SoundVC") as? SoundViewController {
                    
                    if let enemyTypeLabel = enemyTypeView.subviews[1] as? UILabel {
                        if let dangerName = enemyTypeLabel.text {
                            vc.tracksNames = tracksForEveryDanger[dangerName]!
                            navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                    
                }
            }
            
        }
        
    }
    
}
