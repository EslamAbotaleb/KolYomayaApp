//
//  AllSurahModel.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 2/24/21.
//  Copyright © 2021 Islam Abotaleb. All rights reserved.
//

import Foundation
// MARK: - AllSurahModel
struct AllSurahModel: BaseModel {
    let status: Int
    let message: String
    let results: [SurahList]
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case results = "results"
    }
}
