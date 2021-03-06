//
//  ViewController.swift
//  sound board
//
//  Created by Jose  Santiago on 11/26/18.
//  Copyright © 2018 Jose  Santiago. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var soundCollectionView: UICollectionView!
    
    var audioPlayer = AVAudioPlayer()
    var playbackFlag = false
    var lastPressedIndex: Int = 0
    var sounds = [(sound: "elevator-bossa", image:"buttonOff"), (sound: "elevator-loft", image:"buttonOff"), (sound: "finish-him", image:"buttonOff"), (sound: "headshot", image:"buttonOff"), (sound: "item-zelda", image:"buttonOff"), (sound: "leeroy-jenkins", image:"buttonOff"), (sound: "pokemon-critical-hp", image:"buttonOff"), (sound: "radio-beep", image:"buttonOff"), (sound: "shop-zelda", image:"buttonOff"), (sound: "spongebob-eternity", image:"buttonOff"), (sound: "spongebob-eventually", image:"buttonOff"), (sound: "spongebob-new-narrator", image:"buttonOff"), (sound: "spongebob-twothousandyears", image:"buttonOff")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        audioPlayer = AVAudioPlayer()
        
    }
    
    
    //LOGIC
    
    func prepareForPlay(indexOfSound: Int) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: sounds[indexOfSound].sound, ofType: "mp3")!))
            audioPlayer.prepareToPlay()
            
            let audioSession = AVAudioSession.sharedInstance()
            
            do {
                try audioSession.setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
            } catch {
                
            }
            
            
        } catch {
            print(error)
        }
    }
    
    //TODO: when other button is pressed stop currently playing and play the new one
    func buttonPressed(index: Int) {
        if playbackFlag {
            playbackFlag = !playbackFlag
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            sounds[lastPressedIndex].image = "buttonOff"
            soundCollectionView.reloadData()
            print(index)
        } else {
            playbackFlag = !playbackFlag
            prepareForPlay(indexOfSound: index)
            sounds[index].image = "buttonOn"
            lastPressedIndex = index
            soundCollectionView.reloadData()
            audioPlayer.play()
        }
    }
    
    // SETUP COLLECTION VIEW
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sounds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "boardCell", for: indexPath) as! BoardCell
        cell.nameLabel.text = sounds[indexPath.item].sound
        cell.buttonAppearance.image = UIImage(named: sounds[indexPath.item].image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        buttonPressed(index: indexPath.row)
    }
    
}

