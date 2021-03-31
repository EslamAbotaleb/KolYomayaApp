//
//  ListAyatSpesficReciterViewController.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/27/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData
class ListAyatSpesficReciterViewController: BaseViewController,DelegateStatusPlay {
    var statusPlaying: Bool?
    var player: AVPlayer?
    var reciterId: Int?
    var statusListen: String?
    var isDownload = true
    var favoritesArray: [OfflineAudioModel]?
    var context:NSManagedObjectContext!

 var delegateAudioListProtocol: DelegateAudioListProtocol?
//    var delegatePlayAudio: DelegateStatusPlay?
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
//        self.initializeNavigationBarAppearanceWithBack(viewController: BookGetAllByPageNumberViewController(), titleHeader: "تفسير القرآن الكريم (استماع)")TafsirListen
//        self.initializeNavigationBarAppearanceWithBack(viewController: AlbumReciterViewController(), titleHeader: "القران الكريم (استماع)")
        if self.statusListen == "QuranListen" {
            self.initializeNavigationBarAppearanceWithBack(viewController: AlbumReciterViewController(), titleHeader: "القران الكريم (استماع)")
            UserDefaults.standard.setValue(statusListen, forKey: "QuranListen")
            
        } else {
            UserDefaults.standard.removeObject(forKey: "QuranListen")
            UserDefaults.standard.setValue(statusListen, forKey: "QuranTafsir")
            self.initializeNavigationBarAppearanceWithBack(viewController: AlbumReciterViewController(), titleHeader: "تفسير القرآن الكريم (استماع)")
        }

        UserDefaults.standard.synchronize()
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
        print("nameReciteerrrewr\(self.delegateAudioListProtocol?.nameReciter)")
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "ListAyatSpesficReciterTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ListAyatSpesficReciterTableViewCell.reuseIdentifier)
        
//        SavingManager.shared.saveValue((self.delgateQuarnListenProtcol?.imageReciter) ?? "" as String, key: "imageReciter")
//        SavingManager.shared.saveValue((self.delgateQuarnListenProtcol?.reciterId) ?? 0  as Int, key: "reciterId")
//        SavingManager.shared.saveValue((coordinator?.nameReciter)  ?? "" as String, key: "nameReciter")

        if self.delegateAudioListProtocol?.nameReciter == nil {
            self.headerView.titleLabel.text = SavingManager.shared.getValue("nameReciter")
            
            SavingManager.shared.saveValue(self.headerView.titleLabel.text!, key: "nameReciter")

        } else {
            self.headerView.titleLabel.text = self.delegateAudioListProtocol?.nameReciter
            SavingManager.shared.saveValue(self.headerView.titleLabel.text!, key: "nameReciter")
        }
        
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
        
        openDatabse()
    }

//     var player = AVPlayer()
     var isPlaying: Bool = false
                

  
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
    @objc func downloadAudioPressed(sender: UIButton) {
//        downloadAudio()
    }
    func openDatabse()
      {
      
       guard let appDelegate =
         UIApplication.shared.delegate as? AppDelegate else {
           return
       }
       
      context = appDelegate.persistentContainer.viewContext
          
      }
    
//    func downloadAudio() {
//        if (isDownload) {
//            //Display the alert for what happens
//            let alertController = UIAlertController(title: "Downlaod", message: "This article has been added to the favorites tab", preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
//            alertController.addAction(okAction)
//            self.present(alertController, animated: true, completion: nil)
//            
//            //save the article here when button pressed - Core Data
//            
//
//            //Prepares the button for undoing if tapped again
//            isDownload = false
//            let entity = NSEntityDescription.entity(forEntityName: "OfflineAudioModel", in: (self.context)!)
//            let articleObject = NSManagedObject(entity: entity!, insertInto: self.context)
//            
//            articleObject.setValue(self.delegateAudioListProtocol?.nameReciter, forKey: "suraName")
//            
//            self.delegateAudioListProtocol?.audioListReciter?.forEach {
//                elemnt in
//                articleObject.setValue(elemnt.audioLink, forKey: "audioLink")
//              
//            }
//           
//            
//            print("Storing Data..")
//            
//           
//           
//            do {
//                
//                try context.save()
//                
//            } catch {
//                print("Storing data Failed")
//            }
//        } else {
//            let alertController2 = UIAlertController(title: "UnDownlaod", message: "This article has been removed from the favorites tab", preferredStyle: .alert)
//            let okAction2 = UIAlertAction(title: "Ok", style: .default, handler: nil)
//            alertController2.addAction(okAction2)
//            self.present(alertController2, animated: true, completion: nil)
//            
//            isDownload = true
//        }
//    }

}
