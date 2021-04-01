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
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView()
//        view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 40)
//        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        view.frame.size.width = self.view.frame.size.width
//        view.frame.size.height = 60
//       // .FillEqually .FillProportionally .EqualSpacing .EqualCentering
//
//        let nameLabel = UILabel(frame: CGRect(x: self.view.frame.width - 50, y: 0, width: 40, height: 40))
//        nameLabel.text = "الاسم"
//        nameLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
//        nameLabel.textColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
//
//        view.addSubview(nameLabel)
////        view.addSubview(stackView)
//        // for horizontal stack view, you might want to add width constraint to label or whatever view you're adding.
////        view.addSubview(imageView)
//
//        return view
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 40
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListAyatSpesficReciterTableViewCell.reuseIdentifier, for: indexPath) as? ListAyatSpesficReciterTableViewCell else {
            fatalError("Not Found List Ayat Cell")
        }
//        cell.downloadAudioBtn.tag = indexPath.row
//        cell.downloadAudioBtn.addTarget(self, action: #selector(downloadAudioPressed), for: .touchUpInside)
        
        cell.configure(viewModel: (delegateAudioListProtocol?.audioListReciter?[indexPath.row])!)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegateAudioListProtocol?.audioListReciter?.count ?? 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            initPlayer(url: (self.delegateAudioListProtocol?.audioListReciter?[indexPath.row].audioLink!)!)
//            bottomViewPlayer(isHidden: false, playFunction: play, pauseFunction: pause)
        
//        NotificationCenter.default.post(name: Notification.Name("statusAppearViewIdentifier"), object: statusAppearView)
//
////        NotificationCenter.default.post(name: Notification.Name("statusAppearViewIdentifier"), object: nil)
//
//        bottomViewPlayer(isHidden: statusAppearView)

        let playerViewController =  PlayerViewController.init(nibName: "PlayerViewController", bundle: nil)
        playerViewController.position = indexPath.row
        
        if ((self.delegateAudioListProtocol?.nameReciter?.isEmpty) != nil) {
            print("wassss e,mrkewl;kjwe;")

            playerViewController.getaNameReciter = self.delegateAudioListProtocol?.nameReciter
            playerViewController.getaImageReciter = self.delegateAudioListProtocol?.imageReciter
            playerViewController.audioLinks = self.delegateAudioListProtocol?.audioListReciter
//            playerViewController.audioLinkPlay = playerViewController.audioLinks?[indexPath.row].audioLink
            playerViewController.suraName = self.delegateAudioListProtocol?.audioListReciter?[indexPath.row].name
            
        } else {
            print("delegate audio not emopttytt")

            playerViewController.getaNameReciter = SavingManager.shared.getValue("nameReciter")
            playerViewController.getaImageReciter = SavingManager.shared.getValue("imageReciter")
            playerViewController.audioLinks = self.delegateAudioListProtocol?.audioListReciter
//            playerViewController.audioLinkPlay = playerViewController.audioLinks?[indexPath.row].audioLink
            playerViewController.suraName = self.delegateAudioListProtocol?.audioListReciter?[indexPath.row].name
        }
       
//        playerViewController.delegatePlayAudio = self
        
        
       
//        if  playerViewController.delegatePlayAudio?.statusPlaying == true {
//
//            playerViewController.delegatePlayAudio?.statusPlaying = false
//            playerViewController.delegatePlayAudio?.player?.pause()
//
        if  InputDetails.details.statusPl == true {
         
            InputDetails.details.statusPl = false
            InputDetails.details.player?.pause()
            
            print("seconddddd")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                playerViewController.audioLinkPlay = playerViewController.audioLinks?[indexPath.row].audioLink

                self.present(playerViewController, animated: true, completion: nil)
            }

        } else {
            print("onnenenenene")

            InputDetails.details.statusPl = false

    //        self.delegateAudioListProtocol?.audioListReciter?.forEach {
    //            audioLinkObject in
                playerViewController.audioLinkPlay = playerViewController.audioLinks?[indexPath.row].audioLink

            present(playerViewController, animated: true, completion: nil)
        }
      

    }
    
  
   
}
