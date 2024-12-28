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
    
    var nameOfSoundLabel = UILabel()
    private var imageView = UIImageView()
    private var playingLabel = UILabel()
    private var soundDescriptionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        addImageView()
        addPlayingLabel()
        addTapGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SoundView {
    
    private func addImageView() {
        
        let constant = frame.width * 0.05
        
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -constant),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: constant),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])

        let image = UIImage(named: "SoundImage")
        imageView.image = image
        
    }
    
    func addLabel(text: String = "") {
        
        let constant = frame.width * 0.05
        
        self.addSubview(nameOfSoundLabel)
        nameOfSoundLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameOfSoundLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: constant),
            nameOfSoundLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constant)
        ])
        
        let fontSize = (text.count > 18) ? (frame.width / 17) : (frame.width / 14)

        nameOfSoundLabel.font = UIFont(
            name: "BigCaslon",
            size: fontSize
        )
        nameOfSoundLabel.text = text
        nameOfSoundLabel.textColor = .blue
        
    }
    
    private func addPlayingLabel() {
        
        let constant = frame.width * 0.01
        
        self.addSubview(playingLabel)
        playingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playingLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: constant),
            playingLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
        ])
        
        playingLabel.text = ""
        playingLabel.textColor = .systemRed
        playingLabel.font = UIFont(
            name: "SystemFont",
            size: frame.width / 23
        )
    }
    
    func addSoundDescriptionLabel() {
        
        let constant = frame.width * 0.01
        
        self.addSubview(soundDescriptionLabel)
        soundDescriptionLabel.numberOfLines = 0
        soundDescriptionLabel.font = UIFont(
            name: "SystemFont",
            size: frame.width / 20
        )
        soundDescriptionLabel.text = soundsDescription[nameOfSoundLabel.text!]
        soundDescriptionLabel.textColor = .black
        soundDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            soundDescriptionLabel.leadingAnchor.constraint(equalTo: nameOfSoundLabel.leadingAnchor),
            soundDescriptionLabel.topAnchor.constraint(equalTo: nameOfSoundLabel.bottomAnchor, constant: constant)
        ])
    }
    
    private func addTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pressTheSoundButton))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func pressTheSoundButton() {
        
        guard let tappedSV = SoundView.tappedSoundView else {
            addTapAnimation(isPlaying: true)
            playSound()
            return
        }
        
        if tappedSV != self {
            addTapAnimation(isPlaying: true)
            SoundView.stopSound()
            playSound()
        } else {
            addTapAnimation(isPlaying: false)
            SoundView.stopSound()
        }
        
    }
    
    private func addTapAnimation(isPlaying: Bool) {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(
                scaleX: 0.9,
                y: 0.9
            )
        }
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform.identity
            if isPlaying {
                self.playingLabel.text = "Playing"
            } else {
                self.playingLabel.text = ""
            }
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
        
        SoundView.tappedSoundView?.playingLabel.text = ""
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
