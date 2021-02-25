//
//  ListAyatSepsficReciter + tavleVIew.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/27/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit
import AVFoundation
extension ListAyatSpesficReciterViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListAyatSpesficReciterTableViewCell.reuseIdentifier, for: indexPath) as? ListAyatSpesficReciterTableViewCell else {
            fatalError("Not Found List Ayat Cell")
        }
       
        cell.configure(viewModel: (delegateAudioListProtocol?.audioListReciter?[indexPath.row])!)
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegateAudioListProtocol?.audioListReciter?.count ?? 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            initPlayer(url: (self.delegateAudioListProtocol?.audioListReciter?[indexPath.row].audioLink!)!)
//            bottomViewPlayer(isHidden: false, playFunction: play, pauseFunction: pause)
        let playerViewController =  PlayerViewController.init(nibName: "PlayerViewController", bundle: nil)
        
        playerViewController.position = indexPath.row
        playerViewController.getaNameReciter = self.delegateAudioListProtocol?.nameReciter
        playerViewController.getaImageReciter = self.delegateAudioListProtocol?.imageReciter
        playerViewController.audioLinks = self.delegateAudioListProtocol?.audioListReciter
       
        present(playerViewController, animated: true, completion: nil)

    }
    
    @objc func playOrPauseAudio(_ sender: UIButton) {
        
    }
}
//class MusicPlayer {
//    public static var instance = MusicPlayer()
//    var player = AVPlayer()
//    var isPlaying: Bool = false
//    func initPlayer(url : String) {
//        guard let url = URL.init(string: url) else { return }
//        let playerItem = AVPlayerItem.init(url: url)
//        player = AVPlayer.init(playerItem: playerItem)
//        playAudioBackground()
//    }
//    
//    func playAudioBackground() {
//        do {
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: [.mixWithOthers, .allowAirPlay])
//            print("Playback OK")
//            try AVAudioSession.sharedInstance().setActive(true)
//            print("Session is Active")
//        } catch {
//            print(error)
//        }
//    }
//    
//   @objc func pause(_ sender: UIButton){
//        isPlaying = true
//        print("Audio Pause")
//
//        player.pause()
//    }
//    
//    @objc func play(_ sender: UIButton) {
//        isPlaying = false
//        print("Audio Play")
//        player.play()
//    }
//}
