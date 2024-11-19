//
//  SoundView.swift
//  Scare an animal
//
//  Created by Никита Волков on 18.11.2024.
//

import UIKit
import AVFoundation

class SoundView: UIView {
    
    static private var audioPlayer: AVAudioPlayer?

    init() {
        super.init(frame: CGRect())
        self.translatesAutoresizingMaskIntoConstraints = false
        addImageView()
        addTapGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SoundView {
    
    private func addImageView() {
        
        let imageView = UIImageView()
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            imageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
        ])

        let image = UIImage(named: "SoundImage")
        imageView.image = image
        
    }
    
    func addLabel(text: String = "Label") {
        
        let nameOfSoundLabel = UILabel()
        self.addSubview(nameOfSoundLabel)
        nameOfSoundLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameOfSoundLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            nameOfSoundLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])

        let fontSize = superview!.bounds.width / 15
        nameOfSoundLabel.font = UIFont(
            name: "Apple Symbols",
            size: fontSize
        )
        nameOfSoundLabel.text = text
        nameOfSoundLabel.textColor = .white
        
    }
    
    private func addTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pressTheSoundButton))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func pressTheSoundButton() {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform.identity
        }
        
        playSound()
    }
    
    private func playSound() {
        
        SoundView.stopSound()
        
        if let label = subviews[1] as? UILabel {
            let soundName = label.text!
            if let path = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
                if let sound = try? AVAudioPlayer(contentsOf: path) {
                    SoundView.audioPlayer = sound
                    sound.play()
                }
            }
        }
    }
    
    static func stopSound() {
        guard let _ = SoundView.audioPlayer else { return }
        if SoundView.audioPlayer!.isPlaying {
            SoundView.audioPlayer!.stop()
        }
    }
    
}
