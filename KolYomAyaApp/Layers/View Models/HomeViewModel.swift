//
//  TodayAyaViewModel.swift
//  KolYoumAya
//
//  Created by Islam Abotaleb on 7/22/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import Foundation
import Moya

final class HomeViewModel {
    
    let todayAyaService = MoyaProvider<ApiService>()
    
    var cordinator: HomeCoordinator?
    
    func todayAyaApi(completionHandler: @escaping (TodayAyaViewModel) -> ()) {
        todayAyaService.request(.todayAya) { (result) in
            switch (result) {
            case .success(let response):
                DispatchQueue.main.async {  [weak self] in
                    do {
                        let todayAyaModel = try JSONDecoder().decode(TodayAyaViewModel.self, from: response.data)
                        completionHandler(todayAyaModel)
                    } catch {
                        
                    }
                    
                }
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    
}
