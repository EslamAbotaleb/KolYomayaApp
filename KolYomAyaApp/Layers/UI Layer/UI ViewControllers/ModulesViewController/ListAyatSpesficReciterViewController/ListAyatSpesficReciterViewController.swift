//
//  ListAyatSpesficReciterViewController.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/27/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit
import AVFoundation

class ListAyatSpesficReciterViewController: BaseViewController,DelegateStatusPlay {
    var statusPlaying: Bool?
    var player: AVPlayer?
    var reciterId: Int?
    var statusListen: String?
    
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

//     var player = AVPlayer()
     var isPlaying: Bool = false
                
//     func initPlayer(url : String) {
//         guard let url = URL.init(string: url) else { return }
//         let playerItem = AVPlayerItem.init(url: url)
//
//
//         player = AVPlayer.init(playerItem: playerItem)
//        self.playerPass = self.delegatePlayAudio?.player!
//
////        playAudioBackground()
//  play()
//
////        if isPlaying == false {
////            playAudioBackground()
////
////        } else {
////            pause()
////        }
////
//     }
  
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
    @objc func downloadAudio(audioLink: String) {
        
        let audioUrl = URL(string: audioLink)!

        do {
                   try audioUrl.download(to: .documentDirectory) { url, error in
                       guard let url = url else { return }
//                       self.player = AVPlayer(url: url)
//                       self.player.play()
                   }
               } catch {
                   print(error)
               }
    }
     
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        pause()
//
//        self.delegateAudioListProtocol = nil
//
//    }
//    
//    func pause(){
//           isPlaying = false
//           print("Audio Pause")
//        self.delegatePlayAudio?.player.pause()
//       }
//       
//       func play() {
//        
////           isPlaying = true
//           print("Audio Play")
//        self.delegatePlayAudio?.player.play()
//          
//       }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
//  @objc func downloadAndSaveAudioFile(_ audioFile: String, completion: @escaping (String) -> Void) {
//
//            //Create directory if not present
//            let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
//            let documentDirectory = paths.first! as NSString
//            let soundDirPathString = documentDirectory.appendingPathComponent("Sounds")
//
//            do {
//                try FileManager.default.createDirectory(atPath: soundDirPathString, withIntermediateDirectories: true, attributes:nil)
//                print("directory created at \(soundDirPathString)")
//            } catch let error as NSError {
//                print("error while creating dir : \(error.localizedDescription)");
//            }
//
//            if let audioUrl = URL(string: audioFile) {     //http://freetone.org/ring/stan/iPhone_5-Alarm.mp3
//                // create your document folder url
//                let documentsUrl =  FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first! as URL
//                let documentsFolderUrl = documentsUrl.appendingPathComponent("Sounds")
//                // your destination file url
//                let destinationUrl = documentsFolderUrl.appendingPathComponent(audioUrl.lastPathComponent)
//
//                print(destinationUrl)
//                // check if it exists before downloading it
//                if FileManager().fileExists(atPath: destinationUrl.path) {
//                    print("The file already exists at path")
//                } else {
//                    //  if the file doesn't exist
//                    //  just download the data from your url
//                    DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async(execute: {
//                        if let myAudioDataFromUrl = try? Data(contentsOf: audioUrl){
//                            // after downloading your data you need to save it to your destination url
//                            if (try? myAudioDataFromUrl.write(to: destinationUrl, options: [.atomic])) != nil {
//                                print("file saved")
//                                completion(destinationUrl.absoluteString)
//                            } else {
//                                print("error saving file")
//                                completion("")
//                            }
//                        }
//                    })
//                }
//            }
//        }
}
extension URL {
    func download(to directory: FileManager.SearchPathDirectory, using fileName: String? = nil, overwrite: Bool = false, completion: @escaping (URL?, Error?) -> Void) throws {
        let directory = try FileManager.default.url(for: directory, in: .userDomainMask, appropriateFor: nil, create: true)
        let destination: URL
        if let fileName = fileName {
            destination = directory
                .appendingPathComponent(fileName)
                .appendingPathExtension(self.pathExtension)
        } else {
            destination = directory
            .appendingPathComponent(lastPathComponent)
        }
        if !overwrite, FileManager.default.fileExists(atPath: destination.path) {
            completion(destination, nil)
            return
        }
        URLSession.shared.downloadTask(with: self) { location, _, error in
            guard let location = location else {
                completion(nil, error)
                return
            }
            do {
                if overwrite, FileManager.default.fileExists(atPath: destination.path) {
                    try FileManager.default.removeItem(at: destination)
                }
                try FileManager.default.moveItem(at: location, to: destination)
                completion(destination, nil)
            } catch {
                print(error)
            }
        }.resume()
    }
}
