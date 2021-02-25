//
//  ListAyatSpesficReciterViewController.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/27/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit
import AVFoundation

class ListAyatSpesficReciterViewController: BaseViewController {
 var delegateAudioListProtocol: DelegateAudioListProtocol?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var viewPlayer: UIView!
    var isSelectOnAya: Bool = false
    
    var headerView: HeaderViewReciter = {
        
        let nib = UINib(nibName: "HeaderViewReciter", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! HeaderViewReciter
    }()
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
//          self.initializeNavigationBarAppearanceWithBack(viewController: AlbumReciterViewController())
        
        self.initializeNavigationBarAppearanceWithBack(viewController: HomeViewController(), titleHeader: "القران الكريم (استماع)")

      }
    override func viewSafeAreaInsetsDidChange() {
           super.viewSafeAreaInsetsDidChange()

           tableView.contentInset = UIEdgeInsets(top: 250 + tableView.safeAreaInsets.top,
left: 0, bottom: 0, right: 0)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.delegateAudioListProtocol?.audioListReciter)
        
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "ListAyatSpesficReciterTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ListAyatSpesficReciterTableViewCell.reuseIdentifier)
        self.headerView.titleLabel.text = self.delegateAudioListProtocol?.nameReciter
                          self.headerView.scrollView = self.tableView
                          self.headerView.frame = CGRect(
                              x: 0,
                              y: self.tableView.safeAreaInsets.top,
                              width: self.view.frame.width,
                              height: 100)

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
    }

     var player = AVPlayer()
     var isPlaying: Bool = false
                
     func initPlayer(url : String) {
         guard let url = URL.init(string: url) else { return }
         let playerItem = AVPlayerItem.init(url: url)
        
        
         player = AVPlayer.init(playerItem: playerItem)
        self.playerPass = player

        playAudioBackground()
  play()

//        if isPlaying == false {
//            playAudioBackground()
//
//        } else {
//            pause()
//        }
//
     }
  
     func playAudioBackground() {
         do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: [.mixWithOthers, .allowAirPlay])
             print("Playback OK")
             try AVAudioSession.sharedInstance().setActive(true)
             print("Session is Active")
         } catch {
             print(error)
         }
     }
     
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pause()

        
    }
    
    func pause(){
           isPlaying = false
           print("Audio Pause")
           player.pause()
       }
       
       func play() {
        
//           isPlaying = true
           print("Audio Play")
           player.play()
          
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
