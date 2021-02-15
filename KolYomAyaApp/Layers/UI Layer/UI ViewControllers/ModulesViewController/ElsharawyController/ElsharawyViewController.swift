//
//  ElsharawyViewController.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/26/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit
import GoogleMobileAds
protocol DelegateElsharawayMediaSelect {
    var programId: Int? { get set }
    var programName: String? { get set }

}

class ElsharawyViewController: BaseViewController, UIScrollViewDelegate,GADBannerViewDelegate  {
    var banner: GADBannerView!
    var coordinator: ElsharawyMediaProgramIdCoordinator?
    var viewModel: ElsharawySectionProgramViewModel?
    var elsharawyProgramModel: ElsharawyProgramModel?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bannerView: GADBannerView!
    
    var headerView: HeaderView = {
           let nib = UINib(nibName: "HeaderView", bundle: nil)
           return nib.instantiate(withOwner: self, options: nil).first as! HeaderView
       }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initializeNavigationBarAppearanceWithBack(viewController: HomeViewController(), titleHeader: "كل يوم آية")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        viewModel = ElsharawySectionProgramViewModel()
        coordinator = ElsharawyMediaProgramIdCoordinator(viewController: self)
           viewModel?.registTableViewCell(nibName: "ElsharawyTableViewCell", tableView: tableView)
        
        viewModel?.getProgramsElsharawySection(completionHandler: { (elsharawyProgramModel) in
            self.elsharawyProgramModel = elsharawyProgramModel
            self.headerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.headerView.imageView.makeRounded()
            self.headerView.imageView.imageFromURL(urlString: self.elsharawyProgramModel!.sectionImage)
            self.headerView.titleLabel.text = self.elsharawyProgramModel?.longName
                  self.headerView.scrollView = self.tableView
                  self.headerView.frame = CGRect(
                      x: 0,
                      y: self.tableView.safeAreaInsets.top,
                      width: self.view.frame.width,
                      height: 250)

                  self.tableView.backgroundView = UIView()
                  self.tableView.backgroundView?.addSubview(self.headerView)
                  self.tableView.contentInset = UIEdgeInsets(
                      top: 200,
                      left: 0,
                      bottom: 0,
                      right: 0)
            
//            self.sectionImage.imageFromURL(urlString: self.elsharawyProgramModel!.sectionImage)
//            self.titleElsharayLabel.text = self.elsharawyProgramModel?.longName
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
    override func viewSafeAreaInsetsDidChange() {
           super.viewSafeAreaInsetsDidChange()

           tableView.contentInset = UIEdgeInsets(top: 250 + tableView.safeAreaInsets.top,
                                                 left: 0,
                                                 bottom: 0,
                                                 right: 0)
           headerView.updatePosition()
       }
       
       override func viewWillLayoutSubviews() {
           super.viewWillLayoutSubviews()
           
           headerView.updatePosition()
       }
       
       // MARK: - UIScrollViewDelegate methods

        func scrollViewDidScroll(_ scrollView: UIScrollView) {
           headerView.updatePosition()
       }

    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
        self.bannerView.addSubview(banner)
        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
