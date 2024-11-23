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
    static private var soundName = ""
    static private var tappedSoundView: SoundView?
    private var nameOfSoundLabel: UILabel!

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
    
    func addLabel(text: String = "") {
        
        nameOfSoundLabel = UILabel()
        self.addSubview(nameOfSoundLabel)
        nameOfSoundLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameOfSoundLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            nameOfSoundLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])

        nameOfSoundLabel.font = UIFont(
            name: "Apple Symbols",
            size: superview!.bounds.width / 15
        )
        nameOfSoundLabel.text = text
        nameOfSoundLabel.textColor = .black
        
    }
    
    private func addTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pressTheSoundButton))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func pressTheSoundButton() {
        
        guard let tappedSV = SoundView.tappedSoundView else {
            addTapAnimation(newLabelColor: .systemRed)
            playSound()
            return
        }
        
        if tappedSV != self {
            addTapAnimation(newLabelColor: .systemRed)
            SoundView.stopSound()
            playSound()
        } else {
            addTapAnimation(newLabelColor: .black)
            SoundView.stopSound()
        }
        
    }
    
    private func addTapAnimation(newLabelColor: UIColor) {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(
                scaleX: 0.9,
                y: 0.9
            )
        }
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform.identity
            self.nameOfSoundLabel.textColor = newLabelColor
        }
    }
    
    private func playSound() {
        
        SoundView.tappedSoundView = self
        SoundView.soundName = SoundView.tappedSoundView!.nameOfSoundLabel.text!
        
        if let path = Bundle.main.url(forResource: SoundView.soundName, withExtension: "mp3") {
            if let sound = try? AVAudioPlayer(contentsOf: path) {
                SoundView.audioPlayer = sound
                SoundView.audioPlayer!.delegate = self
                sound.play()
            }
        }
        
    }
    
    static func stopSound() {
        
        SoundView.tappedSoundView?.nameOfSoundLabel.textColor = .black
        SoundView.tappedSoundView = nil
        
        guard let _ = SoundView.audioPlayer else { return }
        if SoundView.audioPlayer!.isPlaying {
            SoundView.audioPlayer!.stop()
            SoundView.soundName = ""
        }
        
    }
}

extension SoundView: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            SoundView.stopSound()
        }
    }
    
}
