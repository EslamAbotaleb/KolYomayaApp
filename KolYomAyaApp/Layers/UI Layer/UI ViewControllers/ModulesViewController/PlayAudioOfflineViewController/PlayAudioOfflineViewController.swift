//
//  PlayAudioOfflineViewController.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 3/29/21.
//  Copyright © 2021 Islam Abotaleb. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class PlayAudioOfflineViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    var player: AVAudioPlayer?
    //    var mp3FileNames: [String]?
    var context:NSManagedObjectContext!
    var offlineAudios : [NSManagedObject]?

    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
        self.initializeNavigationBarAppearanceWithBack(viewController: HomeViewController(), titleHeader: "كل يوم آية")

           openDatabse()
           
       }
 
    func openDatabse()
      {
      
       guard let appDelegate =
         UIApplication.shared.delegate as? AppDelegate else {
           return
       }
       
      context = appDelegate.persistentContainer.viewContext
          
          fetchData()
      }
    func fetchData()
      {
       
          let request = NSFetchRequest<NSFetchRequestResult>(entityName: "OfflineAudioModel")
          request.returnsObjectsAsFaults = false
          do {
              let result = try context.fetch(request)
            self.offlineAudios = result as? [NSManagedObject]
            
          } catch {
              print("Fetching data Failed")
          }
      }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "PlayAudioTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: PlayAudioTableViewCell.reuseIdentifier)
        //        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        //
        //        do {
        //            // Get the directory contents urls (including subfolders urls)
        //            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil)
        //            print(directoryContents)
        //
        //            // if you want to filter the directory contents you can do like this:
        //            let mp3Files = directoryContents.filter{ $0.pathExtension == "mp3" }
        //            print("mp3 urls:",mp3Files)
        //            mp3FileNames  = mp3Files.map{ $0.deletingPathExtension().lastPathComponent }
        //            print("mp3 list:", mp3FileNames)
        //
        //        } catch {
        //            print(error)
        //        }
    }

}
extension PlayAudioOfflineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.offlineAudios?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlayAudioTableViewCell.reuseIdentifier) as? PlayAudioTableViewCell else {
            fatalError()
        }
//        cell.audioName.text = self.mp3FileNames?[indexPath.row]
        
        cell.removeAudio.tag = indexPath.row
        cell.audioName.text = self.offlineAudios?[indexPath.row].value(forKey: "suraName") as? String

        cell.removeAudio.addTarget(self, action: #selector(removeAudio), for: .touchUpInside)
        return cell
    }
    @objc func removeAudio(sender: UIButton) {
//        print(sender.tag)
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext


        let index = sender.tag

        context.delete((self.offlineAudios?[index])! as NSManagedObject)
        offlineAudios?.remove(at: index)

             let _ : NSError! = nil
             do {
                 try context.save()
                 self.tableView.reloadData()
             } catch {
                 print("error : \(error)")
             }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        self.offlineAudios = []
        let playerViewController =  PlayerViewController.init(nibName: "PlayerViewController", bundle: nil)
        playerViewController.position = indexPath.row
        playerViewController.getaNameReciter = self.offlineAudios?[indexPath.row].value(forKey: "suraName") as? String
        
        
        playerViewController.getaImageReciter =  self.offlineAudios?[indexPath.row].value(forKey: "image_reciter") as? String
        playerViewController.audioLinkPlay =
            self.offlineAudios?[indexPath.row].value(forKey: "audioLink") as? String
//        playerViewController.getaNameReciter = self.delegateAudioListProtocol?.nameReciter
//        playerViewController.getaImageReciter = self.delegateAudioListProtocol?.imageReciter
//        playerViewController.audioLinks = self.delegateAudioListProtocol?.audioListReciter
//        playerViewController.suraName = self.delegateAudioListProtocol?.audioListReciter?[indexPath.row].name
//        playerViewController.delegatePlayAudio = self
        
        
       
//        if  playerViewController.delegatePlayAudio?.statusPlaying == true {
//
//            playerViewController.delegatePlayAudio?.statusPlaying = false
//            playerViewController.delegatePlayAudio?.player?.pause()
//
        if  InputDetails.details.statusPl == true {
         
            InputDetails.details.statusPl = false
            InputDetails.details.player?.pause()
            
            print("seconddddd")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                playerViewController.audioLinkPlay = playerViewController.audioLinks?[indexPath.row].audioLink
                playerViewController.audioLinkPlay =
                    self.offlineAudios?[indexPath.row].value(forKey: "audioLink") as? String
                self.present(playerViewController, animated: true, completion: nil)
            }

        } else {
            print("onnenenenene")

            InputDetails.details.statusPl = false

    //        self.delegateAudioListProtocol?.audioListReciter?.forEach {
    //            audioLinkObject in
//                playerViewController.audioLinkPlay = playerViewController.audioLinks?[indexPath.row].audioLink
            playerViewController.audioLinkPlay =
                self.offlineAudios?[indexPath.row].value(forKey: "audioLink") as? String
            
            present(playerViewController, animated: true, completion: nil)
        }
      
        
        
    }
//     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
//            let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
//
//            let index = indexPath.row
//
//            context.delete((self.offlineAudios?[index])! as NSManagedObject)
//            offlineAudios?.remove(at: index)
//
//                 let _ : NSError! = nil
//                 do {
//                     try context.save()
//                     self.tableView.reloadData()
//                 } catch {
//                     print("error : \(error)")
//                 }
//        }
//    }
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
//
//        let index = indexPath.row
//
//        context.delete((self.offlineAudios?[index])! as NSManagedObject)
//        offlineAudios?.remove(at: index)
//
//             let _ : NSError! = nil
//             do {
//                 try context.save()
//                 self.tableView.reloadData()
//             } catch {
//                 print("error : \(error)")
//             }
//    }
    
}
