//
//  AlbumReciterViewController.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/27/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit
import GoogleMobileAds
protocol DelegateAudioListProtocol {
    var audioListReciter: [AudioList]? {get set}
    var nameReciter: String? {get set}
    var imageReciter: String? {get set}

}
class AlbumReciterViewController: BaseViewController {
    @IBOutlet weak var bannerView: GADBannerView!
    var statusListen: String?
    var banner: GADBannerView!
    var interstitial: GADInterstitial!
    @IBOutlet weak var tableView: UITableView!
    var folderName: String? = ""
    var audioList = [AudioList]()
    var results = [ResultAlbumReciter]()
    var delgateQuarnListenProtcol: DelegateQuarnListenProtcol?
    var viewModel: AlbumReciterViewModel?
    var albumReciterModel: AlbumReciterModel?
    var coordinator: ListAyatSpesficReciterCooridnator?
    var headerView: HeaderView = {
        let nib = UINib(nibName: "HeaderView", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! HeaderView
    }()
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.initializeNavigationBarAppearanceWithBack(viewController: QuarnListenViewController(), titleHeader: "القران الكريم (استماع)")
    }
    func initTafsirList() {
        switch self.delgateQuarnListenProtcol?.reciterId {
        case 1:
            folderName = "almuyassar"
          break
        case 2:
            folderName = "almukhtasar"
          break
        case 3:
            folderName = "alsidi"
          break
        case 4:
            folderName = "aljalalayn"
          break
        case 5:
            folderName = "alsiraaj"
          break
        case 6:
            folderName = "almuyassar-g"
          break
        case 7:
            folderName = "ibn-juzay"
          break
      
        default: break
        }
        for index in stride(from: 1, to: 114, by: +1) {
            var linkBuilder = "https://mirrors.quranicaudio.com/tafsir.one/"+folderName!+"/"
            var surahNumber = ""
            var suraName = KeyAndValue.SURA_NAME[index].name
//            if index > 0 {
           
                if index < 10 {
                    surahNumber = "00" + "\(index)"
                } else if index < 100 {
                    surahNumber = "0" + "\(index)"
                } else {
                    surahNumber = "\(index)" + ""
                }
//            }
          
//            + 1
            linkBuilder = linkBuilder + surahNumber + ".mp3"
            self.audioList.append(AudioList(id: index + 1, name: " سورة" + suraName , audioLink: linkBuilder, viewsNumber: "", audioTime: ""))
            }
               
        
        results.append(ResultAlbumReciter(id: 1, name: self.delgateQuarnListenProtcol?.nameReciter!, itemsNumber: "114", viewsNumber: "", audioList: self.audioList))
    }
    func displayContentListenQuranFromServer() {
        viewModel?.getAlbumReciter(page: 1, reciterID: delgateQuarnListenProtcol?.reciterId ?? 0, completionHandler: { (albumReciterObjectModel) in
            self.albumReciterModel = albumReciterObjectModel
            self.headerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                       self.headerView.imageView.makeRounded()
            self.headerView.imageView.imageFromURL(urlString: (self.delgateQuarnListenProtcol?.imageReciter!)!)
            
            self.headerView.titleLabel.text = self.delgateQuarnListenProtcol?.nameReciter
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
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    func displayContentListenTafisrBook() {
        self.headerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                   self.headerView.imageView.makeRounded()
        self.headerView.imageView.imageFromURL(urlString: (self.delgateQuarnListenProtcol?.imageReciter)!)
        self.headerView.titleLabel.text = self.delgateQuarnListenProtcol?.nameReciter
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
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = AlbumReciterViewModel()
        KeyAndValue.getSura_Name()
        coordinator = ListAyatSpesficReciterCooridnator(viewController: self)
        viewModel?.registTableViewCell(nibName: "AlbumReciterTableViewCell", tableView: tableView)
        if /*Mark:- In the case listen quran*/
            self.statusListen == "QuranListen" {
            displayContentListenQuranFromServer()
        } else if /*Mark:- In the case listen tafisr*/
            self.statusListen == "TafsirListen" {
            displayContentListenTafisrBook()
            initTafsirList()
        }
        
        banner = GADBannerView(adSize: kGADAdSizeBanner)
        //Banner One
        self.bannerView.addSubview(banner)
        bannerView.adUnitID = Keys.BannerTwo
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
        interstitial = GADInterstitial(adUnitID: Keys.adsInterstitial)
        interstitial.delegate = self
        let request = GADRequest()
        interstitial.load(request)
        print(#function, "shouldDisplayAd", self.shouldDisplayAd, "isAdReady", self.isAdReady)
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AlbumReciterViewController: GADInterstitialDelegate {
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
extension AlbumReciterViewController: GADBannerViewDelegate {
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
