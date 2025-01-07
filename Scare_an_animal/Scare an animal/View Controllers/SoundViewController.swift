//
//  SoundViewController.swift
//  Scare an animal
//
//  Created by Никита Волков on 18.11.2024.
//

import UIKit

// MARK: SoundViewController
// Includes SoundViews containing a description of each audio and activating the sounds

class SoundViewController: UIViewController, UIScrollViewDelegate {
    
    private var soundViewsArray = [SoundView]()
    private var soundViewsArrayCount = 0
    var tracksNames = [String]()
    var scrollView: UIScrollView!

    override func loadView() {
        super.loadView()

        addSwipeGestureRecognizer()
        addScrollView()
        addSoundViews()
    }
}


// MARK: Adding subviews and swipe gesture recognizer
// Subviews:
// - ScrollView as the container for SoundViews
// - SoundViews

extension SoundViewController {
    
    private func addSoundViews() {
        for track in tracksNames {
            makeSoundView(with: track)
        }
    }
    
// MARK: Swipe Gesture Recognizer
// For a swipe to return to EnemiesViewController
    
    private func addSwipeGestureRecognizer() {
        let swipeFromLeftToTheRightGestureRecognizer = UISwipeGestureRecognizer(
            target: self,
            action: #selector(getToEnemiesViewController)
        )
        swipeFromLeftToTheRightGestureRecognizer.direction = .right
        self.view.addGestureRecognizer(swipeFromLeftToTheRightGestureRecognizer)
    }
    
    @objc private func getToEnemiesViewController() {
        SoundView.stopSound()
        navigationController?.popViewController(animated: true)
    }
    
    private func addScrollView() {
        scrollView = UIScrollView(
            frame: CGRect(
                x: 0,
                y: 0,
                width:  view.bounds.width,
                height: view.bounds.height
            )
        )
        
        let contentSizeHeight: CGFloat = (view.bounds.width * 0.425)  * CGFloat(tracksNames.count)
        
        scrollView.contentSize = CGSize(
            width:  view.bounds.width,
            height: contentSizeHeight
        )
        view.addSubview(scrollView)
    }
    
    private func makeSoundView(with trackName: String) {
        
        let soundViewWidth  = view.bounds.width * 0.9
        let soundViewHeight = view.bounds.width * 0.4
        let soundViewFrame = CGRect(
            x: 0,
            y: 0,
            width:  soundViewWidth,
            height: soundViewHeight
        )
        
        let soundView = SoundView(frame: soundViewFrame)
        scrollView.addSubview(soundView)
        
// MARK: Layout
        
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
        
        
        soundView.addTrackNameLabel(with: trackName)
        soundView.addSoundDescriptionLabel()
        
        soundViewsArray.append(soundView)
        soundViewsArrayCount += 1
        
    }
    
}
