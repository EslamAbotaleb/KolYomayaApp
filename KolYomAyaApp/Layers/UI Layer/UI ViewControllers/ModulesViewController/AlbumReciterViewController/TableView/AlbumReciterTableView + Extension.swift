//
//  AlbumReciterTableView + Extension.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/27/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit
extension AlbumReciterViewController: UITableViewDelegate, UITableViewDataSource {
    
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
            cell.numberOfEpisodesLbl.text = "114"
            cell.nameProgamText.text = self.delgateQuarnListenProtcol?.nameReciter
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if statusListen == "QuranListen" {
            //MARK:- will pass audioList spesfic reciter
            coordinator?.audioListReciter = self.albumReciterModel?.results?[indexPath.row].audioList
            coordinator?.nameReciter = self.albumReciterModel?.results?[indexPath.row].name
            coordinator?.imageReciter = self.delgateQuarnListenProtcol?.imageReciter
            //MARK:- start to audiolist coordinator
        } else if statusListen == "TafsirListen" {
            coordinator?.nameReciter = self.delgateQuarnListenProtcol?.nameReciter
            coordinator?.audioListReciter = self.audioList
        }
        coordinator?.start()

    }
}
