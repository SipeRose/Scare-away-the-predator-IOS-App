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
        
        let contentSizeHeight: CGFloat = (view.bounds.width * 0.425)  * CGFloat(tracksNames.count)
        
        scrollView.contentSize = CGSize(
            width: view.bounds.width,
            height: contentSizeHeight
        )
        view.addSubview(scrollView)
    }
    
    private func addSoundView(trackName: String) {
        
        let soundViewWidth = view.bounds.width * 0.9
        let soundViewHeight = view.bounds.width * 0.4
        let soundViewFrame = CGRect(
            x: 0,
            y: 0,
            width: soundViewWidth,
            height: soundViewHeight
        )
        
        let soundView = SoundView(frame: soundViewFrame)
        scrollView.addSubview(soundView)
        soundView.layer.borderWidth = 5
        soundView.layer.borderColor = UIColor.systemBlue.cgColor
        soundView.layer.cornerRadius = view.frame.height / 30
        
        
        if soundViewsArrayCount == 0 {
            
            NSLayoutConstraint.activate([
                soundView.heightAnchor.constraint(equalToConstant: soundView.frame.height),
                soundView.widthAnchor.constraint(equalToConstant: soundView.frame.width),
                soundView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                soundView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
            ])
            
        } else {
            
            let lastAddedSoundView = soundViewsArray.last!
            NSLayoutConstraint.activate([
                soundView.heightAnchor.constraint(equalToConstant: soundView.frame.height),
                soundView.widthAnchor.constraint(equalToConstant: soundView.frame.width),
                soundView.topAnchor.constraint(equalTo: lastAddedSoundView.bottomAnchor, constant: view.bounds.width * 0.025),
                soundView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
            ])
        }
        
        
        soundView.addLabel(text: trackName)
        soundView.addSoundDescriptionLabel()
        
        soundViewsArray.append(soundView)
        soundViewsArrayCount += 1
        
    }
    
}
