//
//  ListAyatSpesficReciterTableViewCell.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/27/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit
import CoreData

class ListAyatSpesficReciterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var downloadAudioBtn: UIButton!
    @IBOutlet weak var suraNameLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    var viewModel: AudioList?
    var audioLinks: [String]?
    var offlineAudios : [NSManagedObject]?

    let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance
    var context:NSManagedObjectContext!
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    // MARK: Methods to Open, Store and Fetch data
   
    
  

//    @objc func downloadAudio() {
//
//
//        let entity = NSEntityDescription.entity(forEntityName: "OfflineAudioModel", in: (self.context)!)
//        let articleObject = NSManagedObject(entity: entity!, insertInto: self.context)
//        articleObject.setValue(self.viewModel?.name, forKey: "suraName")
//        articleObject.setValue(self.viewModel?.audioLink, forKey: "audioLink")
//
//
//        print("Storing Data..")
//        articleObject.setValue(true, forKey: "is_downloaded")
//
//        if articleObject.value(forKey: "is_downloaded") != nil  {
//            self.downloadAudioBtn.isEnabled = false
//            self.downloadAudioBtn.isSelected = false
//        } else {
//            self.downloadAudioBtn.isEnabled = true
//            self.downloadAudioBtn.isSelected = true
//
//        }
//
//        do {
//
//            try context.save()
//
//        } catch {
//            print("Storing data Failed")
//        }
//
//        //        let offlineAudioObject = NSManagedObject(entity: entity!, insertInto: "suraName")
//        //        let offlineAudioObject = NSManagedObject(entity: entity!, insertInto: "audioLink")
//
//        //                    let articleObject = NSManagedObject(entity: entity!, insertInto: self?.context)
//        //                    articleObject.setValue(self?.allArticles![indexPath.row].title, forKey: "title")
//        //                    articleObject.setValue(self?.allArticles![indexPath.row].urlToImage, forKey: "article_image")
//
//        //        checkAudioFileExists(withLink: (self.viewModel?.audioLink)!) {
//        //            [weak self]
//        //            downloadUrl in
//        //            guard let self = self else{
//        //                return
//        //            }
//        ////            self.audioLinks?.append(downloadUrl.path)
//        //
//        //        }
//
//    }
    ////    func play(url: URL) {
    ////       print("playing \(url)")
    ////
    //////       do {
    //////
    //////           audioPlayer = try AVAudioPlayer(contentsOf: url)
    //////           audioPlayer?.prepareToPlay()
    //////           audioPlayer?.delegate = self
    //////           audioPlayer?.play()
    //////           let percentage = (audioPlayer?.currentTime ?? 0)/(audioPlayer?.duration ?? 0)
    //////           DispatchQueue.main.async {
    //////               // do what ever you want with that "percentage"
    //////           }
    //////
    //////       } catch let error {
    //////           audioPlayer = nil
    //////       }
    ////
    ////   }
    //    func downloadFile(withUrl url: URL, andFilePath filePath: URL, completion: @escaping ((_ filePath: URL)->Void)){
    //        DispatchQueue.global(qos: .background).async {
    //            do {
    //                let data = try Data.init(contentsOf: url)
    //                try data.write(to: filePath, options: .atomic)
    //                print("saved at \(filePath.absoluteString)")
    //                DispatchQueue.main.async {
    //                    completion(filePath)
    //                }
    //            } catch {
    //                print("an error happened while downloading or saving the file")
    //            }
    //        }
    //    }
    //    // check audio exits
    //    func checkAudioFileExists(withLink link: String, completion: @escaping ((_ filePath: URL)->Void)){
    //        let urlString = link.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
    //        if let url  = URL.init(string: urlString ?? ""){
    //            let fileManager = FileManager.default
    //            if let documentDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create: false){
    //
    //                let filePath = documentDirectory.appendingPathComponent(url.lastPathComponent, isDirectory: false)
    //
    //                do {
    //                    if try filePath.checkResourceIsReachable() {
    //                        print("file exist")
    //                        completion(filePath)
    //
    //                    } else {
    //                        print("file doesnt exist")
    //                        downloadFile(withUrl: url, andFilePath: filePath, completion: completion)
    //                    }
    //                } catch {
    //                    print("file doesnt exist")
    //                    downloadFile(withUrl: url, andFilePath: filePath, completion: completion)
    //                }
    //            }else{
    //                print("file doesnt exist")
    //            }
    //        }else{
    //            print("file doesnt exist")
    //        }
    //    }
    func configure(viewModel: AudioList) {
        self.viewModel = viewModel
        self.suraNameLabel.text = viewModel.name
        
       
//            downloadAudioBtn.addTarget(self, action: #selector(downloadAudio), for: .touchUpInside)
     
    }
    
    
}
