//
//  HomeViewController.swift
//  KolYoumAya
//
//  Created by Islam Abotaleb on 7/22/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//
import Foundation
import UIKit
import Moya
import Reachability
import AVFoundation

class HomeViewController: BaseViewController {
    var ayaStr: String?
    var player: AVPlayer? = AVPlayer()
    var isPlaying: Bool = false
    var appendNumberAya: String?

    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var fullNameAyaText: UILabel!
    @IBOutlet weak var nameAyaText: UILabel!
    @IBOutlet weak var numberAyaText: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var fullNameDescriptionAyaText: UITextView!
    @IBOutlet weak var ayaView: UIView!
    @IBOutlet weak var tafserNameLabel: UILabel!
    var viewModel: HomeViewModel?
   

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.intialnavigationBarAppearaceWithmenu(checkflag: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // with auto layout
        viewModel = HomeViewModel()
        KeyAndValue.getSura_Name()
        KeyAndValue.getSura_Number()
        
      
        ayaView.roundCorners([.topLeft, .topRight], radius: 25.0)
        
        NetworkReachability.shared.reach.whenReachable = { _ in
            self.hideLoader()
            self.viewModel?.cordinator?.didFinish()
            
            self.viewModel?.todayAyaApi() { [weak self] todayAyaModel in
                
                self?.numberAyaText.text =  "آية:" + "\(todayAyaModel.ayaObject!.ayaNumber)"
                
                self?.nameAyaText.text = "سورة:" + (todayAyaModel.ayaObject!.suraName)
                
                self?.fullNameDescriptionAyaText.sizeToFit()
                self?.fullNameDescriptionAyaText.text = todayAyaModel.ayaObject?.tafsir
                self?.fullNameAyaText.text = todayAyaModel.ayaObject?.aya
                self?.tafserNameLabel.text =  "تفسير:" + todayAyaModel.ayaObject!.tafsirAuthor
            }
        }
        
        self.shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
        
        NetworkReachability.shared.reach.whenUnreachable = { _ in
            self.showLoader()
            self.view.endEditing(true)
            let errorServiceLocalizations = ErrorServiceLocalizations.init(httpStatus: 0, errorType: .server)
            let errorTitle = errorServiceLocalizations.errorTitle
            let errorDescription = errorServiceLocalizations.errorDescription
            self.showErrorView(errorTitle: errorTitle, errorDescription: errorDescription)
            self.view.isUserInteractionEnabled = false
        }
        NetworkReachability.isReachable { _ in
            self.hideLoader()

            self.viewModel?.cordinator?.didFinish()
            self.viewModel?.todayAyaApi() { [weak self] todayAyaModel in
                
                self?.numberAyaText.text =  "آية:" + "\(todayAyaModel.ayaObject!.ayaNumber)"
                self?.nameAyaText.text = "سورة:" + (todayAyaModel.ayaObject!.suraName)
                
                self?.fullNameDescriptionAyaText.sizeToFit()
                self?.fullNameDescriptionAyaText.text = todayAyaModel.ayaObject?.tafsir
                self?.fullNameAyaText.text = todayAyaModel.ayaObject?.aya
                self?.tafserNameLabel.text =  "تفسير:" + todayAyaModel.ayaObject!.tafsirAuthor
            }
        }
        NetworkReachability.isUnreachable { _ in
//            self.showLoader()
            self.view.endEditing(true)
            let errorServiceLocalizations = ErrorServiceLocalizations.init(httpStatus: 0, errorType: .server)
            let errorTitle = errorServiceLocalizations.errorTitle
            let errorDescription = errorServiceLocalizations.errorDescription
            self.showErrorView(errorTitle: errorTitle, errorDescription: errorDescription)
//            self.view.isUserInteractionEnabled = false

        }
    }
    
    
    func showLoader(){
        self.view.isUserInteractionEnabled = false
        InviaLoadingIndicator.show()
    }
    
    func hideLoader(){
        self.view.isUserInteractionEnabled = true
        InviaLoadingIndicator.hide()
    }
    @objc func share(sender:UIView){
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.viewModel?.todayAyaApi() { [weak self] todayAyaModel in
            
            
            let textToShare = todayAyaModel.ayaObject!.suraName
            
            if let url = URL(string: "http://bit.ly/2OF1tyg") {//Enter link to your app here
                let objectsToShare = [textToShare, url, image ?? #imageLiteral(resourceName: "app-logo")] as [Any]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                
                //Excluded Activities
                activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.mail, UIActivity.ActivityType.postToFacebook]
                //
                
                activityVC.popoverPresentationController?.sourceView = sender
                self?.present(activityVC, animated: true, completion: nil)
            }
        }
        
    }
    func initPlayer(url : String) {
        guard let url = URL.init(string: url) else { return }
        let playerItem = AVPlayerItem.init(url: url)
        NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying(sender:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)

        player = AVPlayer.init(playerItem: playerItem)
      
        isPlaying = true
        player?.play()
        
      playPauseButton.setImage(UIImage(named: "pause_btn"), for: .normal)
        playPauseButton.setTitle("تشغيل", for: .normal)

    }
    @objc func playerDidFinishPlaying(sender: Notification) {
        // Your code here
        playPauseButton.setImage(UIImage(named: "play_btn"), for: .normal)
        playPauseButton.imageView?.contentMode = .scaleAspectFit
        playPauseButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        playPauseButton.setTitle("تشغيل", for: .normal)
    }
    @IBAction func playAyaBySpesficReciter(_ sender: Any) {
        
        if isPlaying {
                 isPlaying = false
                   //pause
                 player?.pause()

//                 playPauseButton.setImage(UIImage(named: "play_btn"), for: .normal)
            playPauseButton.setImage(UIImage(named: "play_btn"), for: .normal)
               playPauseButton.imageView?.contentMode = .scaleAspectFit
               playPauseButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            playPauseButton.setTitle("تشغيل", for: .normal)

             } else {
                 isPlaying = true
                 // play
                 player?.play()
//                 playPauseButton.setImage(UIImage(named: "pause_btn"), for: .normal)
            playPauseButton.setImage(UIImage(named: "pause_btn"), for: .normal)
               playPauseButton.imageView?.contentMode = .scaleAspectFit
               playPauseButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            playPauseButton.setTitle("إيقاف", for: .normal)

            self.viewModel?.todayAyaApi() { [weak self] todayAyaModel in

                          if todayAyaModel.ayaObject!.ayaNumber < 10 {
                              self?.appendNumberAya = "00"  + "\(todayAyaModel.ayaObject!.ayaNumber)"
                          } else if todayAyaModel.ayaObject!.ayaNumber >= 10 &&  todayAyaModel.ayaObject!.ayaNumber < 100{
                              self?.appendNumberAya = "0"  + "\(todayAyaModel.ayaObject!.ayaNumber)"
                          } else if todayAyaModel.ayaObject!.ayaNumber >= 100 {
                              self?.appendNumberAya =    "\(todayAyaModel.ayaObject!.ayaNumber)"
                          }
                          
                if UserDefaults.standard.value(forKey: "getNameReciter") as? String != nil {
                    let nameReciter = UserDefaults.standard.value(forKey: "getNameReciter") as? String
                    for indexAyaname in 0..<KeyAndValue.SURA_NAME.count {
                                                   
                        if  KeyAndValue.SURA_NAME[indexAyaname].name == todayAyaModel.ayaObject?.suraName {
                            self!.initPlayer(url: "http://212.57.192.148/ayat/mp3/\(nameReciter!)/\(KeyAndValue.SURA_NAME[indexAyaname].id)\(self!.appendNumberAya!).mp3")
                            break
                        }
                        
                    }
                    
                } else {
                    print("fjwefklewfewf")
                }
                
                
                
            }
             }
        
  
    }
}
