//
//  BookGetAllByPageNumberViewController.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/28/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit
import GoogleMobileAds
class BookGetAllByPageNumberViewController: BaseViewController {
    var estimateWidth = 160.0
    var PageNumber: Int = 1
    var cellMarginSize = 5.0
    @IBOutlet weak var heightBanner: NSLayoutConstraint!
    var banner: GADBannerView!
    var interstitial: GADInterstitial!
    var viewModel: GetAllBooksByPageNumberViewModel?
    var results = [ResultReciter]()
    var coordinator: AlbumReciterCoordinator?
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initializeNavigationBarAppearanceWithBack(viewController: HomeViewController(), titleHeader: "كتب التفسير")
        heightBanner.constant = 0.0
    }
    
    func intialTafsirObject() {
     
        let almuyassar = ResultReciter(id: 1, name: "التفسير الميسر", image: "https://read.tafsir.one/assets/images/almuyassar.jpg", cardColor: "", bio: "", viewsNumber: 0)
        
        let almukhtasar = ResultReciter(id: 2, name: "المختصر في التفسير", image: "https://read.tafsir.one/assets/images/almukhtasar.jpg", cardColor: "", bio: "", viewsNumber: 0)
        
        let alsidi = ResultReciter(id: 3, name: "تفسير السعدي", image: "https://read.tafsir.one/assets/images/alsidi.jpg", cardColor: "", bio: "", viewsNumber: 0)
        
        let aljalalayn = ResultReciter(id: 4, name: "تفسير الجلالين", image: "https://read.tafsir.one/assets/images/aljalalayn.jpg", cardColor: "", bio: "", viewsNumber: 0)
        
       let alsiraaj = ResultReciter(id: 4, name: "السراج في غريب القرآن", image: "https://read.tafsir.one/assets/images/alsiraaj.jpg", cardColor: "", bio: "", viewsNumber: 0)
        
        let almuyassarg = ResultReciter(id: 4, name: "الميسر في غريب القرآن", image: "https://read.tafsir.one/assets/images/almuyassar-g.jpg", cardColor: "", bio: "", viewsNumber: 0)
        
        let ibnjuzay = ResultReciter(id: 4, name: "تفسير ابن جزي", image: "https://read.tafsir.one/assets/images/ibn-juzay.jpg", cardColor: "", bio: "", viewsNumber: 0)
        results.append(almuyassar)
        results.append(almukhtasar)
        results.append(alsidi)
        results.append(aljalalayn)
        results.append(alsiraaj)
        results.append(almuyassarg)
        results.append(ibnjuzay)
    }
    private var shouldDisplayAd = true
    
    private var isAdReady:Bool = false {
        didSet {
            if isAdReady && shouldDisplayAd {
                displayAd()
            }
        }
    }
 
    private func displayAd() {
        print(#function, "ad ready", interstitial.isReady)
        if (interstitial.isReady) {
            shouldDisplayAd = false
            interstitial.present(fromRootViewController: self)
        }
    }
    func createAndLoadInterstitial() -> GADInterstitial {
        interstitial = GADInterstitial(adUnitID: Keys.adsInterstitial)
        interstitial.delegate = self
        interstitial.load(GADRequest())
        shouldDisplayAd = false
        return interstitial
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = GetAllBooksByPageNumberViewModel()
        viewModel?.registCollectionViewCell(nibName: "BookGetAllByPageNumberCollectionViewCell", collectionView: collectionView)
        intialTafsirObject()
        collectionView.delegate = self
        collectionView.dataSource = self
//        viewModel?.getAllBooksByPageNumberApi(pageNumber: PageNumber, completionHandler: { (resultBookGetAllbyPageNumber) in
//            self.viewModel?.getAllBooksModel = resultBookGetAllbyPageNumber
        coordinator = AlbumReciterCoordinator(viewController: self, statusListen: "TafsirListen")
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        banner = GADBannerView(adSize: kGADAdSizeBanner)
        //Banner One
        self.bannerView.addSubview(banner)
        bannerView.adUnitID = Keys.BannerOne
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-5809306835538408/9594496790")
        interstitial.delegate = self
        let request = GADRequest()
        interstitial.load(request)
        print(#function, "shouldDisplayAd", self.shouldDisplayAd, "isAdReady", self.isAdReady)
//        })
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension BookGetAllByPageNumberViewController: GADBannerViewDelegate {
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

extension BookGetAllByPageNumberViewController: GADInterstitialDelegate {
    /// Tells the delegate an ad request failed.
    func interstitialDidFail(toPresentScreen ad: GADInterstitial) {
        print(#function, "ad ready", interstitial.isReady)
    }
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print(#function, "ad ready", interstitial.isReady)
        isAdReady = true
    }
    
    //Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("interstitialWillDismissScreen")
    }
    
    //Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        print("interstitialDidDismissScreen")
        //        present(self, animated: true)
        dismiss(animated: true, completion: nil)
        interstitial = createAndLoadInterstitial()
        print(#function, "shouldDisplayAd", shouldDisplayAd, "isAdReady", isAdReady)
    }
}
