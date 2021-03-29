//
//  AlbumReciterViewModel.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/27/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import Foundation
import Moya
final class AlbumReciterViewModel {
    let albumReciterService = MoyaProvider<ApiService>()
    var albumReciterModel: AlbumReciterModel?
    func getAlbumReciter(page: Int, reciterID: Int, completionHandler: @escaping(AlbumReciterModel) -> ()) {
        
        albumReciterService.request(.albumReciterPage(page: page, reciterId: reciterID)) { (result) in
            switch result {
            case .success(let response):
                print("responseresponse")
                DispatchQueue.main.async {
                    let albumReciterObject = try! JSONDecoder().decode(AlbumReciterModel.self, from: response.data)
                    self.albumReciterModel = albumReciterObject
                    completionHandler(self.albumReciterModel!)
                }
                
            case .failure(let error):
                print("errororororororo")
                print(error)
                break
            }
        }
    }
    func numberOfRows() -> Int {
        return self.albumReciterModel?.results?.count ?? 0
    }
    
    func registTableViewCell(nibName: String, tableView: UITableView) {
            let nib = UINib(nibName: nibName, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: AlbumReciterTableViewCell.reuseIdentifier)
        }
}
