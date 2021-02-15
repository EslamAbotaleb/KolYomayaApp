//
//  SideMenuListViewModel.swift
//  KolYoumAya
//
//  Created by Islam Abotaleb on 7/21/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit

protocol SideMenuItemPresentable {
    var name: String? { get }
    var imagename: UIImage? { get }
}
struct SideMenuViewModel: SideMenuItemPresentable {
    var name: String?
    var imagename: UIImage?
    
}
final class SideMenuListViewModel {
    var onUpdate = {}
    
    var items: [SideMenuItemPresentable] = []
    var coordinator: AppCoordinator?
    init() {
        let itemtafserBook = SideMenuViewModel(name: NSLocalizedString(LocalizationKeys.SideMenu.tafserBook, comment: ""), imagename: UIImage(named:"books"))
        
        let itemquaranread = SideMenuViewModel(name: NSLocalizedString(LocalizationKeys.SideMenu.quaranread, comment: ""), imagename: UIImage(named: "quran"))
        
        let itemsupportApp = SideMenuViewModel(name: NSLocalizedString(LocalizationKeys.SideMenu.supportApp, comment: ""), imagename:  UIImage(named: "payment"))
        
        let itemtafserQuarn = SideMenuViewModel(name: NSLocalizedString(LocalizationKeys.SideMenu.tafserQuarn, comment: ""), imagename: UIImage(named: "allah"))
        
        let itempreviousAyat = SideMenuViewModel(name: NSLocalizedString(LocalizationKeys.SideMenu.previousAyat, comment: ""), imagename: UIImage(named: "history"))
        
        let itemprivacypolice = SideMenuViewModel(name: NSLocalizedString(LocalizationKeys.SideMenu.privacypolice, comment: ""), imagename: UIImage(named: "privacy_policy"))
        
        let itemquaranlisten = SideMenuViewModel(name: NSLocalizedString(LocalizationKeys.SideMenu.quaranlisten, comment: ""), imagename: UIImage(named: "music_icon"))
        
        let itemdiractionElqbla = SideMenuViewModel(name: NSLocalizedString(LocalizationKeys.SideMenu.diractionElqbla, comment: ""), imagename: UIImage(named: "kaaba"))
        
        let itemTermsAndCondition = SideMenuViewModel(name: NSLocalizedString(LocalizationKeys.SideMenu.TermsAndCondition, comment: ""), imagename: UIImage(named: "terms_conditions"))
        
        let itemkhwatarelsharawy = SideMenuViewModel(name: NSLocalizedString(LocalizationKeys.SideMenu.khwatarelsharawy, comment: ""), imagename: UIImage(named: "videos_icon"))
        
        let itemsettings = SideMenuViewModel(name: NSLocalizedString(LocalizationKeys.SideMenu.settings, comment: ""), imagename:  UIImage(named: "settings_icon"))
        
        items.append(contentsOf: [itemtafserBook,itemtafserQuarn,itemquaranread,itemquaranlisten,itemkhwatarelsharawy,
                                  itempreviousAyat,itemdiractionElqbla,itemsupportApp,itemsettings,itemTermsAndCondition,itemprivacypolice])
        
    }
    func numberOfRows(_ section: Int) -> Int {
        return items.count
    }
    
    
    func registtableViewCell(nibName name: String, tableView: UITableView) {
        let nib = UINib(nibName: name, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SideMenuCell.reuseIdentifier)
    }
    
    func selectRow(indexPath row: Int) {
        switch row {
        case 0:
            let tafserBookCoordinator = TafserBookCoordinator(viewController: TafserBookViewController())
            tafserBookCoordinator.start()
            
        case 1:
            let getAllBooksCoordinator = GetAllBooksPageCoordinator(viewController: BookGetAllByPageNumberViewController())
            getAllBooksCoordinator.start()
        case 2:
            let quraanReadCoordinator = QuraanReadCoordinator(viewController: QuarnReadViewController())
            quraanReadCoordinator.start()
        case 3:
            let quaranListenCoordinator = QuarnListenCoordinator(viewController: QuarnListenViewController())
            quaranListenCoordinator.start()
        case 4:
            let elsharawyProgramsCoordiantor = ElsharawyCoordinator(viewController: ElsharawyViewController())
            elsharawyProgramsCoordiantor.start()
        case 5:
            let previousAyaCoordinator = PreviousAyatCoordinator(viewController: PreviousAyatViewController())
            previousAyaCoordinator.start()
        case 6:
            let qiblaLocationCoordinator = QiblaLocationCoordinator(viewController: QiblaLocationViewController())
            qiblaLocationCoordinator.start()
        case 7:
            let supportAppCoordinator = SupportAppCoordinator(viewController: SupportAppViewController())
            supportAppCoordinator.start()
        case 8:
            let settingsCoordinator = SettingsCoordinator(viewController: SettingsViewController())
            settingsCoordinator.start()
        case 9:
            let settingsCoordinator = TermsAndConditionsCoordinator(viewController: TermsAndConidtionViewController())
            settingsCoordinator.start()
        case 10:
            let settingsCoordinator = PrivacyPoliceCoordinator(viewController: PrivacyPoliceViewController())
            settingsCoordinator.start()
        default:
            print("")
        }
    }
}
