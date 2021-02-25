//
//  QuraanReadViewModel.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/28/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import Foundation
import Moya
final class QuraanReadViewModel {
    let quraanReadService = MoyaProvider<ApiService>()
    var quraanReadPageByPageNumber: QuraanPageModel?
    func surahAyaByPageNumberApi(pageNumber: Int, completionHandler: @escaping(QuraanPageModel) -> ()) {
        quraanReadService.request(.readQuraanPage(page: pageNumber)) { (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    let quraanReadByPageNumberModel = try! JSONDecoder().decode(QuraanPageModel.self, from: response.data)
                    self.quraanReadPageByPageNumber = quraanReadByPageNumberModel
                    completionHandler(self.quraanReadPageByPageNumber!)
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func quraanReadBySurahAndAyah( surahId: Int,ayah: Int? = 0, completionHandler: @escaping(QuraanPageModel) -> ()) {
           quraanReadService.request(.readQuraanBySurahAndAya(ayaNumber: ayah ?? 1, surahId: surahId)) { (result) in
               switch result {
               case .success(let response):
                   DispatchQueue.main.async {
                       let readQuraanViewModel = try!
                           JSONDecoder().decode(QuraanPageModel.self, from: response.data)
                       self.quraanReadPageByPageNumber = readQuraanViewModel
                       completionHandler(self.quraanReadPageByPageNumber!)
                   }
               case .failure(let error):
                   print(error)
                   break
               }
           }
       }
    
    
    
    
}
