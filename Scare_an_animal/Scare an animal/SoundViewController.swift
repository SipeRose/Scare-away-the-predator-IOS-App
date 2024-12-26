//
//  SoundViewController.swift
//  Scare an animal
//
//  Created by Никита Волков on 18.11.2024.
//

import UIKit

class SoundViewController: UIViewController, UIScrollViewDelegate {
    
    private var soundViewsArray = [SoundView]()
    private var soundViewsArrayCount = 0
    var tracksNames = [String]()
    var scrollView: UIScrollView!

    override func loadView() {
        super.loadView()
        
        super.viewDidLoad()
        addSwipeGestureRecognizer()
        addScrollView()
        
        for trackName in tracksNames {
            addSoundView(trackName: trackName)
        }
    }
}

extension SoundViewController {
    
    private func addSwipeGestureRecognizer() {
        let swipeFromLeftToRight = UISwipeGestureRecognizer(
            target: self,
            action: #selector(getToPreviousViewController)
        )
        swipeFromLeftToRight.direction = .right
        self.view.addGestureRecognizer(swipeFromLeftToRight)
    }
    
    @objc private func getToPreviousViewController() {
        SoundView.stopSound()
        navigationController?.popViewController(animated: true)
    }
    
    private func addScrollView() {
        scrollView = UIScrollView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.bounds.width,
                height: view.bounds.height
            )
        )
        
        let contentSizeHeight: CGFloat
        if tracksNames.count <= 8 {
            contentSizeHeight = 0
        } else {
            contentSizeHeight = (view.bounds.width * 0.425) * (CGFloat(tracksNames.count) / 2)
        }
        
        scrollView.contentSize = CGSize(
            width: view.bounds.width,
            height: contentSizeHeight
        )
        view.addSubview(scrollView)
    }
    
    private func addSoundView(trackName: String) {
        
        let soundView = SoundView()
        scrollView.addSubview(soundView)
        
        if soundViewsArrayCount == 0 {
            
            NSLayoutConstraint.activate([
                soundView.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.4),
                soundView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.35),
                soundView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                soundView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: view.bounds.width * 0.1)
            ])
            
        } else {
            
            let lastAddedSoundView = soundViewsArray.last!
            NSLayoutConstraint.activate([
                soundView.heightAnchor.constraint(equalTo: lastAddedSoundView.heightAnchor),
                soundView.widthAnchor.constraint(equalTo: lastAddedSoundView.widthAnchor)
            ])
            
            if soundViewsArrayCount % 2 == 1 {
                NSLayoutConstraint.activate([
                    soundView.leadingAnchor.constraint(equalTo: lastAddedSoundView.trailingAnchor, constant: view.bounds.width * 0.1),
                    soundView.topAnchor.constraint(equalTo: lastAddedSoundView.topAnchor)
                ])
            } else {
                NSLayoutConstraint.activate([
                    soundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width * 0.1),
                    soundView.topAnchor.constraint(equalTo: lastAddedSoundView.bottomAnchor, constant: view.bounds.width * 0.025)
                ])
            }
        }
        
        soundView.addLabel(text: trackName)
        soundViewsArray.append(soundView)
        soundViewsArrayCount += 1
        
    }
    
}
