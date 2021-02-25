//
//  SupportAppViewController.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 2/15/21.
//  Copyright © 2021 Islam Abotaleb. All rights reserved.
//

import UIKit
import GoogleMobileAds
class SupportAppViewController: BaseViewController, GADRewardedAdDelegate {
   
   
    let scrollView = UIScrollView()
      let contentView = UIView()
    var rewardedAd: GADRewardedAd?
    func setupScrollView(){
          scrollView.translatesAutoresizingMaskIntoConstraints = false
          contentView.translatesAutoresizingMaskIntoConstraints = false
          
          view.addSubview(scrollView)
          scrollView.addSubview(contentView)
          
          scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
          scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
          scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
          scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
          
          contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
          contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
          contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
          contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
      }
      
 
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.initializeNavigationBarAppearanceWithBack(viewController: HomeViewController(), titleHeader: "كل يوم آية")
    }

  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        GADRewardedAd.load(GADRequest())
//        GADRewardedAd.init(adUnitID: Keys.adsRewarded)
        
//        createAndLoadRewardedAd()
        setupScrollView()
              
    }

    /// creating the rewarded ad
    func createAndLoadRewardedAd() {

        rewardedAd = GADRewardedAd(adUnitID: Keys.adsRewarded)
            rewardedAd?.load(GADRequest()) { error in
              if let error = error {
                print("Loading failed: \(error)")
              } else {
                print("Loading Succeeded")
                if self.rewardedAd?.isReady == true {
                    self.rewardedAd?.present(fromRootViewController: self, delegate:self)
                }
              }
            }
        }
    @IBAction func displayAdvertising(_ sender: Any) {
        createAndLoadRewardedAd()
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: GADRewardBasedVideoAdDelegate

     
    /// Lifecycle

    /// Tells the delegate that the user earned a reward.
        func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {

            print("Reward received with currency: \(reward.type), amount \(reward.amount).")
        }
        /// Tells the delegate that the rewarded ad was presented.
        func rewardedAdDidPresent(_ rewardedAd: GADRewardedAd) {
          print("Rewarded ad presented.")
        }
        /// Tells the delegate that the rewarded ad was dismissed.
        /// Load another ad upon dismissing the previous
        func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
          print("RewardAd did dismiss")
          createAndLoadRewardedAd()

        }
        /// Tells the delegate that the rewarded ad failed to present.
        func rewardedAd(_ rewardedAd: GADRewardedAd, didFailToPresentWithError error: Error) {
            print("Rewarded ad failed to present.")
            print("Loading failed: \(error)")

        }

        /// Used by Notification Observer to present rewardedAd
        @objc func startRewardVideoAd() {
            if rewardedAd?.isReady == true {
               rewardedAd?.present(fromRootViewController: self, delegate:self)
            } else {
                print("Reward based video not ready")
            }
        }


    
}
