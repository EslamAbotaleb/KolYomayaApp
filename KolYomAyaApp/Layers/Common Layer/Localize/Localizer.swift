//
//  Localizer.swift
//  KolYoumAya
//
//  Created by Islam Abotaleb on 7/21/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//


import UIKit

class Localizer: NSObject {
    
    class func DoTheSwizzling() {
        MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)),overrideSelector:
            #selector(Bundle.specialLocalizedString(key:value:table:)))
    }
    
    class func setDefaultLanguage() {
        let savedLanguage = SavingManager.shared.getValue(Keys.language)
        if savedLanguage != "" {
            if savedLanguage == "ar" {
                setArabic()
            } else {
                setEnglish()
            }
        } else {
            //            let language = Locale.current.languageCode
            //            if language == "ar" {
            //                setArabic()
            //            } else {
            //                setEnglish()
            //            }
            setArabic()
        }
    }
    
    class func isArabic() -> Bool {
        let savedLanguage = SavingManager.shared.getValue(Keys.language)
        if savedLanguage == "ar" {
            return true
        }
        return false
    }
    
    class func setArabicLanguage() {
        setArabic()
//        reloadApp()
    }
    
    class func setEnglishLanguage() {
        setEnglish()
//        reloadApp()
    }
    
    class private func setArabic() {
        SavingManager.shared.saveValue("ar", key: Keys.language)
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
    }
    
    class private func setEnglish() {
        SavingManager.shared.saveValue("en", key: Keys.language)
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
    }
    
//    class func reloadApp() {
//        appDelegate.loadHomeView()
//    }
}

extension Bundle {
    @objc func specialLocalizedString(key: String, value: String?, table tableName: String?) -> String {
        
        if let currentLanguage = UserDefaults.standard.value(forKey: Keys.language) as? String {
            var bundle = Bundle()
            if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
                bundle = Bundle(path: _path)!
            } else {
                let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
                bundle = Bundle(path: _path)!
            }
            return (bundle.specialLocalizedString(key: key, value: value, table: tableName))
        }
        return ""
    }
}

func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector){
    
    let origMethod: Method = class_getInstanceMethod(cls, originalSelector)!
    let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector)!
    if (class_addMethod(cls, originalSelector,
                        method_getImplementation(overrideMethod),
                        method_getTypeEncoding(overrideMethod))) {
        print("DisplayAddMethod")
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod))
    } else {
        print("DisplayexchanageImplement")
        method_exchangeImplementations(origMethod, overrideMethod)
    }
}
