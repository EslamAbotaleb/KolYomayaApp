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
    
    
    func deletDuplicates(_ contexto: NSManagedObjectContext){
        
        let fetchDuplicates = NSFetchRequest<NSFetchRequestResult>(entityName: "OfflineAudioModel")
       //
                   do {
                    self.offlineAudios = try! (contexto.fetch(fetchDuplicates) as! [OfflineAudioModel])
                  } catch let error as NSError {
                  print("Tenemos este error en los duplicados\(error.code)")
                   }
        
        let rediciendArray = self.offlineAudios!.reduce(into: [:], { $0[$1,default:0] += 1})
        print("reduce \(rediciendArray)")
        let sorteandolos = rediciendArray.sorted(by: {$0.value > $1.value })
        print("sorted \(sorteandolos)")
        let map = sorteandolos.map({$0.key})
        
        print(" map : \(map)")
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
    ////                        downloadFile(withUrl: url, andFilePath: filePath, completion: completion)
    //                    }
    //                } catch {
    //                    print("file doesnt exist")
    ////                    downloadFile(withUrl: url, andFilePath: filePath, completion: completion)
    //                }
    //            }else{
    //                print("file doesnt exist")
    //            }
    //        }else{
    //            print("file doesnt exist")
    //        }
    //    }
    //    func playSound(soundName: String) {
    //
    //        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
    //
    //        do {
    //            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
    //            try AVAudioSession.sharedInstance().setActive(true)
    //
    //            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
    //            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
    //
    //            /* iOS 10 and earlier require the following line:
    //            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
    //
    //            guard let player = player else { return }
    //
    //            player.play()
    //
    //        } catch let error {
    //            print(error.localizedDescription)
    //        }
    //    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
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

//        let index = tableView.indexPathForSelectedRow?.row
//        self.offlineAudios?.forEach({ (audioFile) in
//            context.delete((audioFile) as NSManagedObject)
//
//            offlineAudios?.remove(at: sender.tag)
//
//                 let _ : NSError! = nil
//                 do {
//                     try context.save()
//                     self.tableView.reloadData()
//                 } catch {
//                     print("error : \(error)")
//                 }
//        })
       
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

        
        let playerViewController =  PlayerViewController.init(nibName: "PlayerViewController", bundle: nil)
        playerViewController.position = indexPath.row
        playerViewController.getaNameReciter = self.offlineAudios?[indexPath.row].value(forKey: "suraName") as? String
        
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
