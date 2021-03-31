//
//  SavingManager.swift
//  Orange Sports
//
//  Created by Islam Abotaleb on 8/13/19.
//  Copyright © 2019 Islam Abotaleb. All rights reserved.
//


import Foundation

class SavingManager{
    
    static var shared: SavingManager = SavingManager()
    
    private init(){}
    
    func saveObject <T : Codable>(_ object: T, key: String) {
        let data = try! JSONEncoder().encode(object)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func getObject <T: Codable>(_ key: String, baseModel: T.Type) -> Codable {
        if let data = UserDefaults.standard.data(forKey: key){
            if let object = try? JSONDecoder().decode(baseModel.self, from: data) {
                return object
            }
        }
        return BaseModel.self as! Codable
    }
    
    //Local Storage
    func saveValue (_ value: Any, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getValue(_ key: String) -> String {
        if let value =  UserDefaults.standard.value(forKey: key) {
            return value as! String
        }
        return ""
    }
    func getBoolValue(_ key: String) -> Bool {
        if let value =  UserDefaults.standard.value(forKey: key) {
            return value as! Bool
        }
        return false
    }
    func getIntgerValue(_ key: String) -> Int {
        if let value =  UserDefaults.standard.value(forKey: key) {
            return value as! Int
        }
        return 0
    }
    
    func getStringArrayValue(_ key: String) -> [String] {
        if let value = UserDefaults.standard.stringArray(forKey: key) {
            return value 
        }
        return []
    }
    func getObject(_ key: String) -> [String : Any] {
        if let value =  UserDefaults.standard.value(forKey: key) {
            return value as! [String : Any]
        }
        return [:]
    }
    
}
