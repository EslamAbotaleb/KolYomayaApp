//
//  ElsharawyMediaProgramIdViewController.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/26/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit
import GoogleMobileAds
class ElsharawyMediaProgramIdViewController: BaseViewController {
    var delegateElsharawyProgramId: DelegateElsharawayMediaSelect?
    @IBOutlet weak var tableView: UITableView!
    var viewModel: ElsharawyMediaProgramIdViewModel?
    var elsharawyMediaModel: ElsharawyMediaProgramIDModel?
    var coordinator: DetailMediaProgramSelectedCoordinator?
    var interstitial: GADInterstitial!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initializeNavigationBarAppearanceWithBack(viewController: ElsharawyViewController(), titleHeader: delegateElsharawyProgramId?.programName ?? "كل يوم آية")
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
        viewModel = ElsharawyMediaProgramIdViewModel()
        coordinator = DetailMediaProgramSelectedCoordinator(viewController: self)
        viewModel?.registTableViewCell(nibName: "ElsharawyMediaProgramIdTableViewCell", tableView: tableView)
     
        viewModel?.getElsharawyMediaProgram(programId: delegateElsharawyProgramId?.programId ?? 0, completionHandler: { (elsharawyMediaProgramIDModel) in
            self.elsharawyMediaModel = elsharawyMediaProgramIDModel
            self.tableView.reloadData()
        })
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-5809306835538408/9594496790")
        interstitial.delegate = self
        let request = GADRequest()
        interstitial.load(request)
        print(#function, "shouldDisplayAd", self.shouldDisplayAd, "isAdReady", self.isAdReady)
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

extension ElsharawyMediaProgramIdViewController: GADInterstitialDelegate {
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
