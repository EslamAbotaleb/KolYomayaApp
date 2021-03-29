//
//  PreviousAyatViewController.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/24/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit
import GoogleMobileAds
class PreviousAyatViewController: BaseViewController {
    var isDataLoading:Bool=false
    var previousAyaListModel: PreviousAyatListViewModel?
    var pageNumber: Int = 1
    @IBOutlet weak var heightBanner: NSLayoutConstraint!
    var banner: GADBannerView!
    var previousAyaModel: PreviousAyatModel?
    var coordinator: DetailAyaCoordiantor?
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initializeNavigationBarAppearanceWithBack(viewController: HomeViewController(), titleHeader: "كل يوم آية")
        heightBanner.constant = 0.0
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        coordinator = DetailAyaCoordiantor(viewController: self)
        
        previousAyaListModel = PreviousAyatListViewModel()
        
        previousAyaListModel?.registTableViewCell(nibName: "PreviousAyatTableViewCell", tableView: tableView)
        previousAyaListModel?.getPreviousAyaApi(pageNumber: pageNumber, completionHandler: { (previousAya) in
            //            self.previousAyaModel = previousAya
            if self.previousAyaModel?.ayaObject != nil {
                self.previousAyaModel?.ayaObject.append(contentsOf: previousAya.ayaObject)
                
            } else {
                self.previousAyaModel = previousAya
                
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
        banner = GADBannerView(adSize: kGADAdSizeBanner)
        //Banner One
        self.bannerView.addSubview(banner)
        bannerView.adUnitID = Keys.BannerOne
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    func loadMoreAya() {
        self.pageNumber += 1
        previousAyaListModel?.getPreviousAyaApi(pageNumber: pageNumber, completionHandler: { (previousAya) in
            self.previousAyaModel?.ayaObject.append(contentsOf: previousAya.ayaObject)
            
            //            self.previousAyaModel = previousAya
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
}
extension PreviousAyatViewController: GADBannerViewDelegate {
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
        heightBanner.constant = 60.0
        self.bannerView.addSubview(banner)
        
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        heightBanner.constant = 0.0
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
}
