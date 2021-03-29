//
//  QuarnListenViewController.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/27/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit
import GoogleMobileAds
protocol DelegateQuarnListenProtcol {
    var reciterId: Int? { get set }
    var imageReciter: String? {get set }
    var nameReciter: String? { get set }
}

class QuarnListenViewController: BaseViewController {
    var estimateWidth = 160.0
    var cellMarginSize = 5.0
    var isDataLoading: Bool = false
    var pageNumber: Int = 1
    var footerView:CustomFooterView?
    @IBOutlet weak var heightBanner: NSLayoutConstraint!
    let footerViewReuseIdentifier = "RefreshFooterView"
    var recitersModel: ReciterModel?
    var recitersListViewModel: RecitersPageListViewModel?
    var coordinator: AlbumReciterCoordinator?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bannerView: GADBannerView!
    var banner: GADBannerView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initializeNavigationBarAppearanceWithBack(viewController: HomeViewController(), titleHeader: "القرآن الكريم (استماع)")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        recitersListViewModel = RecitersPageListViewModel()
        coordinator = AlbumReciterCoordinator(viewController: self, statusListen: "QuranListen")
        recitersListViewModel?.registerCollectionViewCell(nibName: "QuarnListenCollectionViewCell", collectionView: collectionView!)
            self.collectionView.register(UINib(nibName: "CustomFooterView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerViewReuseIdentifier)
        recitersListViewModel?.getReciters(pageNumber: pageNumber, completionHandler: { (reciterResult) in
//            self.recitersModel = reciterResult
            if self.recitersModel?.results != nil {
                self.recitersModel?.results.append(contentsOf: reciterResult.results)
            } else {
                self.recitersModel = reciterResult
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
        heightBanner.constant = 0.0
        banner = GADBannerView(adSize: kGADAdSizeBanner)
        //Banner One
        self.bannerView.addSubview(banner)
        bannerView.adUnitID = Keys.BannerOne
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
    }
    
    func loadMoreReciters() {
        self.recitersModel?.results.removeAll()
        self.pageNumber += 1
        recitersListViewModel?.getReciters(pageNumber: pageNumber, completionHandler: { (resultReciter) in
            self.recitersModel?.results.append(contentsOf: resultReciter.results)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
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
extension QuarnListenViewController: GADBannerViewDelegate {
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
//        self.bannerView.addSubview(banner)
//        bannerView.heightAnchor.constraint(equalToConstant:  60.0).isActive = true
        heightBanner.constant = 60.0
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
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
