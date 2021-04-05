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
        cell.downloadAudioBtn.tag = indexPath.row
        
        cell.downloadAudioBtn.addTarget(self, action: #selector(downloadAudioPressed), for: .touchUpInside)
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
            
            playerViewController.getaNameReciter = self.delegateAudioListProtocol?.nameReciter
            playerViewController.getaImageReciter = self.delegateAudioListProtocol?.imageReciter
            playerViewController.audioLinks = self.delegateAudioListProtocol?.audioListReciter
            //            playerViewController.audioLinkPlay = playerViewController.audioLinks?[indexPath.row].audioLink
            playerViewController.suraName = self.delegateAudioListProtocol?.audioListReciter?[indexPath.row].name
           
        } else {
            
            playerViewController.getaNameReciter = SavingManager.shared.getValue("nameReciter")
            playerViewController.getaImageReciter = SavingManager.shared.getValue("imageReciter")
            playerViewController.audioLinks = self.delegateAudioListProtocol?.audioListReciter
            //            playerViewController.audioLinkPlay = playerViewController.audioLinks?[indexPath.row].audioLink
            playerViewController.suraName = self.delegateAudioListProtocol?.audioListReciter?[indexPath.row].name
        }
        
        
        if  InputDetails.details.statusPl == true {
            
            InputDetails.details.statusPl = false
            InputDetails.details.player?.pause()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                playerViewController.audioLinkPlay = playerViewController.audioLinks?[indexPath.row].audioLink
                
                self.present(playerViewController, animated: true, completion: nil)
            }
            
        } else {
            
            InputDetails.details.statusPl = false
            
            playerViewController.audioLinkPlay = playerViewController.audioLinks?[indexPath.row].audioLink
            
            present(playerViewController, animated: true, completion: nil)
        }
        
        
    }
    
    
    
}
