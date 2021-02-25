//
//  KolYoumAyaService.swift
//  KolYoumAya
//
//  Created by Islam Abotaleb on 7/22/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import Foundation
import Moya

enum ApiService {
    case todayAya
    case tafserBooks(page: Int)
    case previousAya(page: Int)
    case tafserBookPageNumber(page: Int, bookId: Int)
    case tafserBookBySurahAndAyah(bookId: Int, surahId: Int, ayah: Int)
    case elsharawySection(id: Int)
    case mediaProgramElsharawy(program_id: Int)
    case recitersPage(page: Int)
    case albumReciterPage(page: Int, reciterId: Int)
    case readQuraanPage(page: Int)
    case readQuraanBySurahAndAya(ayaNumber: Int, surahId: Int)
    case getAllBooksPage(page: Int)
    case getAllSurah
}

extension ApiService: TargetType {
    
    var baseURL: URL {
        return  URL(string: "http://160.153.235.227:8082/")!
    }
    
    var path: String {
        switch self {
        case .todayAya:
            return "get/today/aya"
        case .getAllSurah:
            return "quraan/surah/get/all"
        case .tafserBooks(let page):
            return "books/get/list/\(page)"
        case .previousAya(page: let page):
            return "get/previous/ayat/\(page)"
        case .tafserBookPageNumber(page: let page, bookId: let bookId):
            return "books/page/get/by-page-number/\(bookId)/\(page)"
        case .tafserBookBySurahAndAyah(bookId: let bookId, surahId: let surahId, ayah: let ayah):
            return "books/page/get/by-surah-and-ayah/\(bookId)/\(surahId)/\(ayah)"
        case .elsharawySection(let id):
            return "get/section/\(id)"
        case .mediaProgramElsharawy(let program_id):
            return "get/media/\(program_id)"
        case .recitersPage(let page):
            return "get/reciters/\(page)"
        case .albumReciterPage(let page,let reciterId):
            return "get/albums/\(reciterId)/\(page)"
        case .readQuraanPage(let page):
            return "quraan/page/get/by-page-number/\(page)"
        case .readQuraanBySurahAndAya:
            return "quraan/page/get/by-surah-and-ayah"
        case .getAllBooksPage(let page):
            return "books/get/all/\(page)"
        
        }
    }
    var method: Moya.Method {
        switch self {
        case .todayAya:
            return .get
        case .tafserBooks:
            return .get
        case .previousAya:
            return .get
        case .tafserBookPageNumber:
            return .get
        case .tafserBookBySurahAndAyah:
            return .get
        case .elsharawySection:
            return .get
        case .mediaProgramElsharawy:
            return .get
        case .recitersPage:
            return .get
        case .albumReciterPage:
            return .get
        case .readQuraanPage:
            return .get
        case .readQuraanBySurahAndAya:
            return .post
        case .getAllBooksPage:
            return .get
        case .getAllSurah:
            return .get
       
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getAllSurah:
            return Data()
        case .todayAya:
            return Data()
        case .tafserBooks:
            return Data()
        case .previousAya:
            return Data()
        case .tafserBookPageNumber:
            return Data()
        case .tafserBookBySurahAndAyah:
            return Data()
        case .elsharawySection:
            return Data()
        case .mediaProgramElsharawy:
            return Data()
        case .recitersPage:
            return Data()
        case .albumReciterPage:
            return Data()
        case .readQuraanPage:
            return Data()
        case .readQuraanBySurahAndAya:
            return Data()
        case .getAllBooksPage:
            return Data()
      
        }
    }
    var task: Task {
        switch self {
        case .getAllSurah:
            return .requestPlain
        case .todayAya:
            return .requestPlain
        case .tafserBooks(let page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.default)
        case .previousAya(let page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.default)
        case .tafserBookPageNumber(let page,let bookId):
            return .requestParameters(parameters: ["page-number": page, "bookId": bookId], encoding: URLEncoding.default)
        case .tafserBookBySurahAndAyah(let bookId,let surahId,let ayah):
            return .requestParameters(parameters: ["bookId" : bookId,"surahId" : surahId, "ayah" : ayah], encoding: URLEncoding.default)
        case .elsharawySection(let id):
            return .requestParameters(parameters: ["id" : id], encoding: URLEncoding.default)
        case .mediaProgramElsharawy(let program_id):
            return .requestParameters(parameters: ["program_id" : program_id], encoding: URLEncoding.default)
        case .recitersPage(let page):
            return .requestParameters(parameters: ["page" : page], encoding: URLEncoding.default)
        case .albumReciterPage(let page,let reciterId):
            return .requestParameters(parameters: ["page" : page, "reciterId": reciterId], encoding: URLEncoding.default)
        case .readQuraanPage(let page):
            return .requestParameters(parameters: ["page" : page], encoding: URLEncoding.default)
        case .readQuraanBySurahAndAya(let ayaNumber,let surahId):
            return .requestParameters(parameters: ["surahId" : surahId,
                                        "ayahNumber": ayaNumber], encoding: JSONEncoding.default)
        case .getAllBooksPage(let page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.default)
    
        }
    }
    var headers: [String : String]? {
        return  ["api_key": Keys.apiKey]
    }
}
