//
//  getAllSurahViewModel.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 2/24/21.
//  Copyright © 2021 Islam Abotaleb. All rights reserved.
//

import Foundation
import Moya

final class GetAllSurahAyatViewModel {
    let getAllSurahService = MoyaProvider<ApiService>()
    var allSurahModel: AllSurahModel?
    var resultModel: [SurahList] = []
    
    func getAllSurahApi(completionHandler: @escaping (AllSurahModel) -> ()) {
        getAllSurahService.request(.getAllSurah) { (result) in
            switch (result) {
            case .success(let response):
                DispatchQueue.main.async {
                    let getAllSurahModel = try! JSONDecoder().decode(AllSurahModel.self, from: response.data)
                    self.resultModel = getAllSurahModel.results
                    completionHandler(getAllSurahModel)
                    
                }
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func numberOfRows() -> Int {
        return self.resultModel.count
    }
    
}
