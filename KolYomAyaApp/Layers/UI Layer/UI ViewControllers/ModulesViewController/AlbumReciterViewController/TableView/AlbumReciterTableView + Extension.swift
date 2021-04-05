//
//  AlbumReciterTableView + Extension.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/27/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit
extension AlbumReciterViewController: UITableViewDelegate, UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
////        self.tableView.isScrollEnabled = false
//        return "Section \(section)"
//    }

//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 40
//    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
          if statusListen == "TafsirListen" {
            return 1
          }else {
            return self.viewModel?.numberOfRows() ?? 0
          }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumReciterTableViewCell.reuseIdentifier, for: indexPath) as? AlbumReciterTableViewCell else {
            fatalError("AlbumReciter cell not found")
        }
        if statusListen == "QuranListen" {
            
            cell.configure(viewModel: (self.albumReciterModel?.results?[indexPath.row])!)
            
            
        } else if statusListen == "TafsirListen" {
            print("TafsirListenTafsirListen")
            cell.numberOfEpisodesLbl.text = "114".convertToPersianNum()
            if self.delgateQuarnListenProtcol?.nameReciter == nil {
            cell.nameProgamText.text = nameReciter
                self.headerView.imageView.imageFromURL(urlString: self.imageReciter ?? "")

            } else {
                cell.nameProgamText.text = self.delgateQuarnListenProtcol?.nameReciter

            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let playerViewController =  PlayerViewController.init(nibName: "PlayerViewController", bundle: nil)
//        
//        playerViewController.position = indexPath.row
//        playerViewController.getaNameReciter = self.delegateAudioListProtocol?.nameReciter
//        playerViewController.getaImageReciter = self.delegateAudioListProtocol?.imageReciter
//        playerViewController.audioLinks = self.delegateAudioListProtocol?.audioListReciter
//        playerViewController.delegatePlayAudio = self
//        
        
        if statusListen == "QuranListen" {
            //MARK:- will pass audioList spesfic reciter
            coordinator?.audioListReciter = []

            if ((self.delgateQuarnListenProtcol?.nameReciter?.isEmpty) != nil) {
                coordinator?.reciterId = delgateQuarnListenProtcol?.reciterId
                
                coordinator?.audioListReciter = self.albumReciterModel?.results?[indexPath.row].audioList
                
                coordinator?.nameReciter =  self.delgateQuarnListenProtcol?.nameReciter
    //          coordinator?.nameReciter =  self.albumReciterModel?.results?[indexPath.row].name
                coordinator?.imageReciter = self.delgateQuarnListenProtcol?.imageReciter
                SavingManager.shared.saveValue((self.delgateQuarnListenProtcol?.imageReciter) ?? "" as String, key: "imageReciter")
                SavingManager.shared.saveValue((self.delgateQuarnListenProtcol?.reciterId) ?? 0  as Int, key: "reciterId")
                SavingManager.shared.saveValue((coordinator?.nameReciter)  ?? "" as String, key: "nameReciter")
            } else {
                coordinator?.audioListReciter = []
                coordinator?.reciterId = SavingManager.shared.getIntgerValue("reciterId")
                coordinator?.audioListReciter = self.albumReciterModel?.results?[indexPath.row].audioList
                coordinator?.nameReciter =  SavingManager.shared.getValue("nameReciter")
    //          coordinator?.nameReciter =  self.albumReciterModel?.results?[indexPath.row].name
                coordinator?.imageReciter = SavingManager.shared.getValue("imageReciter")
               
            }
      
            //MARK:- start to audiolist coordinator
        } else if statusListen == "TafsirListen" {
            coordinator?.nameReciter = self.delgateQuarnListenProtcol?.nameReciter
            coordinator?.imageReciter = self.delgateQuarnListenProtcol?.imageReciter
            coordinator?.audioListReciter = self.audioList
            SavingManager.shared.saveValue((self.delgateQuarnListenProtcol?.imageReciter) ?? "" as String, key: "imageReciter")
            SavingManager.shared.saveValue((self.delgateQuarnListenProtcol?.reciterId) ?? 0 as Int, key: "reciterId")
            SavingManager.shared.saveValue((coordinator?.nameReciter) ?? "" as String, key: "nameReciter")

        }
//        playerViewController.delegatePlayAudio?.statusPlaying = true
//        coordinator?.statusPlayingAudio = playerViewController.delegatePlayAudio?.statusPlaying
        coordinator?.statusListen = statusListen
      
        coordinator?.start()

    }
}
