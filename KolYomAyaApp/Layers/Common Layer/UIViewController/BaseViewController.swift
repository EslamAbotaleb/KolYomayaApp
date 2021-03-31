//
//  BaseViewController.swift
//  KolYoumAya
//
//  Created by Islam Abotaleb on 7/21/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit
import AVFoundation
import Toast_Swift
protocol DelegateStatusPlay {
    var statusPlaying: Bool? {get set}
    var  player: AVPlayer? {get set}

}
class BaseViewController: UIViewController {
//    var delegatePlayAudio: DelegateStatusPlay?

    var playerPass = AVPlayer()
    var isPlayingPass: Bool = false
    var statusAppearView: Bool = true
    var viewController = UIViewController()

    func bottomViewPlayer(isHidden: Bool = true, playFunction:  (() -> Void)? = nil , pauseFunction:  (() -> Void)? = nil) {
        let footer = UIView()
               footer.isHidden = isHidden
//        UIColor(red: 19, green: 19, blue: 19, alpha: 1.0)
        footer.backgroundColor = UIColor(red: 19/255.0, green: 19/255.0, blue: 19/255.0, alpha: 1.0)
                        footer.translatesAutoresizingMaskIntoConstraints = false
                        view.addSubview(footer)
        
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.alignment = .fill
        horizontalStackView.backgroundColor = UIColor.green
        horizontalStackView.spacing = 10
        horizontalStackView.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        horizontalStackView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        let playButton = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
//        playButton.setTitle("Play", for: .normal)
        playButton.setImage(UIImage(named: "play_btn"), for: UIControl.State.normal)
        playButton.addTarget(self, action: #selector(playFuncn), for: .touchUpInside)
        let pauseButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        pauseButton.setImage(UIImage(named: "pause_btn"), for: UIControl.State.normal)
//        pauseButton.setTitle("Pause", for: .normal)
        pauseButton.addTarget(self, action: #selector(pauseFuncn), for: .touchUpInside)

        horizontalStackView.addArrangedSubview(playButton)
        horizontalStackView.addArrangedSubview(pauseButton)
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Testing"
//        label.textColor = UIColor.black
//        label.backgroundColor = UIColor.yellow
        footer.addSubview(horizontalStackView)
//        label.leftAnchor.constraint(equalTo: footer.leftAnchor).isActive = true
//        label.topAnchor.constraint(equalTo: footer.topAnchor).isActive = true
        horizontalStackView.centerXAnchor.constraint(equalTo: footer.centerXAnchor).isActive = true
        horizontalStackView.centerYAnchor.constraint(equalTo: footer.centerYAnchor ).isActive = true

                      NSLayoutConstraint(item: footer, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 90).isActive = true
                      NSLayoutConstraint(item: footer, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
                      NSLayoutConstraint(item: footer, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
                      NSLayoutConstraint(item: footer, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    @objc func playFuncn(_ sender: UIButton) {
//        isPlaying = false
        playerPass.play()

    }
    @objc func pauseFuncn(_ sender: UIButton) {
    //        isPlaying = false
            playerPass.pause()

        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        print("gwemlighew;ighewil;hgieowhgew\(animated)")
//        if animated == false {
        

            bottomViewPlayer(isHidden: statusAppearView)
//
//        } else {
//            bottomViewPlayer(isHidden: animated)

//        }
//       bottomViewPlayer(isHidden: false)
    }

    //MARK:- Show Error Appear
    func showErrorView(errorTitle: String, errorDescription: String) {
        self.view.endEditing(true)
        var style = ToastStyle()
        style.backgroundColor = AppColors.greenColor
        style.messageColor = UIColor.white
        style.messageAlignment = .right
        self.view.makeToast(errorDescription, duration: 4.0,position: .bottom, style: style)
    }
    
    //MARK:- NavgationBar In The Case menu Button
    func intialnavigationBarAppearaceWithmenu(checkflag: Bool = true) {

        self.navigationController?.navigationBar.isHidden = false
        UINavigationBar.appearance().isTranslucent = false
        let iconMenu = UIButton(type: .custom)
        iconMenu.setImage(UIImage(named: "icons8-menu-24"), for: .normal)
        iconMenu.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        iconMenu.addTarget(self, action: #selector(toggleMenu), for: .touchUpInside)
        
        let titleMenuKolYoumAya = UILabel()
        titleMenuKolYoumAya.frame = CGRect(x: 0, y: 0, width: 15, height: 15)

        //titleMenuKolYoumAya.font = UIFont(name: "Monadi", size: 20)
//        titleMenuKolYoumAya.font = UIFont.systemFont(ofSize: 20.0)
//        titleMenuKolYoumAya.font = UIFont.boldSystemFont(ofSize: 20.0)
       //GE SS Two
        titleMenuKolYoumAya.font = UIFont(name:"Monadi", size: 20.0)//S
        titleMenuKolYoumAya.font = UIFont.boldSystemFont(ofSize: 20.0)

        titleMenuKolYoumAya.text = "   كل يوم آية"

        titleMenuKolYoumAya.textColor = UIColor.white

//             anothericonMenu.addTarget(self, action: #selector(toggleMenu), for: .touchUpInside)
        
        let buttonBar = UIBarButtonItem(customView: iconMenu)
        let anotherbuttonBar = UIBarButtonItem(customView: titleMenuKolYoumAya)

        if Localizer.isArabic() {
            self.navigationItem.setLeftBarButtonItems([buttonBar, anotherbuttonBar], animated: true)

        } else {
            self.navigationItem.setRightBarButton(buttonBar, animated: true)
        }
        navigationController?.navigationBar.barTintColor = AppColors.greenColor
    }
    
    //MARK:- Appear View Controler Without Menu Button
    func intialNavigationBarWithoutUsemenu() {
        self.navigationController?.navigationBar.isHidden = false
        UINavigationBar.appearance().isTranslucent = false
        let backButton = UIButton(type: .custom)
        
        backButton.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)
        if Localizer.isArabic() {
            backButton.setImage(UIImage(named: "icons8-chevron-right-30"), for: .normal)
        } else {
            backButton.setImage(UIImage(named: "icons8-chevron-right-30"), for: .normal)
        }
        navigationController?.navigationBar.barTintColor = AppColors.greenColor

    }
    
//       func initializeNavigationBarAppearanceWithBack() {
//            self.navigationController?.navigationBar.isHidden = false
//            UINavigationBar.appearance().isTranslucent = false
//
//
//            let button = UIButton(type: .custom)
//
//            button.setImage(UIImage(named: "icons8-chevron-right-30"), for: .normal)
//
//            if Localizer.isArabic() {
////                button.transform = CGAffineTransform(rotationAngle: -CGFloat.pi)
//
//                button.setImage(UIImage(named: "icons8-chevron-right-30"), for: .normal)
//
//            }
//
//             button.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)
//             let buttonBar = UIBarButtonItem(customView: button)
//
//        self.navigationController?.navigationBar.barTintColor = AppColors.greenColor
//            if Localizer.isArabic() {
//                self.navigationItem.setLeftBarButtonItems([buttonBar], animated: true)
//            } else {
//                self.navigationItem.setRightBarButtonItems([buttonBar], animated: true)
//            }
//    //        if checkflag {
//    //            checkStatus()
//    //        }
//        }
    func initializeNavigationBarAppearanceWithBack(viewController: UIViewController, titleHeader: String, buttonIsHidden: Bool = true) {
        
                self.navigationController?.navigationBar.isHidden = false
                UINavigationBar.appearance().isTranslucent = false
                
                
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "icons8-chevron-right-30"), for: .normal)
        let downloadButton:UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 50, height: 50))

//        downloadButton.frame = CGRect(x: -70, y: 0, width: 0, height: 0)
        downloadButton.isHidden = buttonIsHidden
        downloadButton.setTitle("تحميل", for: .normal)
        downloadButton.tintColor = UIColor.white
        downloadButton.addTarget(self, action: #selector(BaseViewController.saveQuraanIntoJsonFile), for: .touchUpInside)
//        downloadButton.setImage(UIImage(named: "download"), for: .normal)
//        downloadButton.imageView?.contentMode = .topLeft
//
        let titleMenuKolYoumAya = UILabel(frame: CGRect(x: 100, y: 400, width: 550, height: 50))
        titleMenuKolYoumAya.text = titleHeader
        titleMenuKolYoumAya.textColor = UIColor.white
        titleMenuKolYoumAya.font = UIFont(name:"Monadi", size: 20.0)//S
        titleMenuKolYoumAya.font = UIFont.boldSystemFont(ofSize: 20.0)
//        titleMenuKolYoumAya.font = titleMenuKolYoumAya.font.withSize(20)
        //             anothericonMenu.setImage(UIImage(named: "icons8-menu-24"), for: .normal)
//        titleMenuKolYoumAya.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        
        let anotherbuttonBar = UIBarButtonItem(customView: titleMenuKolYoumAya)

                if Localizer.isArabic() {
    //                button.transform = CGAffineTransform(rotationAngle: -CGFloat.pi)
                    
                    button.setImage(UIImage(named: "icons8-chevron-right-30"), for: .normal)
                    
                }
            self.viewController = viewController
    //        navigateBack(viewController: viewController)
            if viewController is HomeViewController {
                button.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)
            }  else if viewController is PreviousAyatViewController {
                button.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)
            } else if viewController is ElsharawyViewController {
                button.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)
            } else if viewController is ElsharawyMediaProgramIdViewController {
                button.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)
            } else if viewController is DetailMediaProgramSelectedController {
                button.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)
            } else if viewController is PreviousAyatViewController {
                button.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)
            } else if viewController is DetailAyaViewController {
                button.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)
            } else if viewController is AlbumReciterViewController {
                button.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)
            } else if viewController is ListAyatSpesficReciterViewController {
                button.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)
            } else if viewController is TafserBookViewController {
                button.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)
            } else if viewController is QuarnListenViewController {
                button.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)
            } else if viewController is BookGetAllByPageNumberViewController {
                button.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)
            }
        let buttonBar = UIBarButtonItem(customView: button)
        
        let buttonBarDownload = UIBarButtonItem(customView: downloadButton)
        
            self.navigationController?.navigationBar.barTintColor = AppColors.greenColor
                if Localizer.isArabic() {
                    self.navigationItem.setLeftBarButtonItems([buttonBar,anotherbuttonBar, buttonBarDownload], animated: true)
                } else {
                    self.navigationItem.setRightBarButtonItems([buttonBar], animated: true)
                }
        //        if checkflag {
        //            checkStatus()
        //        }
            }
    @objc func toggleMenu() {
           if let sideMenuController: PGSideMenu =  appDelegate.window?.rootViewController as? PGSideMenu {
               if Localizer.isArabic() {
                   sideMenuController.toggleRightMenu()
               } else {
                   sideMenuController.toggleLeftMenu()
               }
           } else {
            print("")

        }
       }
    
        @objc func dismissKeyboard() {
            
            view.endEditing(true)
    //        self.navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)

    //        NotificationCenter.default.post(name: Notification.Name(Keys.hideKeyboard), object: nil)
        }
        func hideKeyboardWhenTappedAround() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
//        var coordinator: HomeCoordinator?

        @objc func navigateBack() {
            
            
                 if self.viewController is HomeViewController {
                     let coordinator = HomeCoordinator(viewController: HomeViewController())
                   
                     coordinator.start()
                 } else if self.viewController is ElsharawyViewController {
                     let coordinator = ElsharawyCoordinator(viewController: ElsharawyViewController())
                     coordinator.start()
                 } else if self.viewController is ElsharawyMediaProgramIdViewController {
                     let coordinator = ElsharawyMediaProgramIdCoordinator(viewController: ElsharawyMediaProgramIdViewController())
                     coordinator.start()
                 } else if self.viewController is DetailMediaProgramSelectedController {
                     let coordinator = DetailMediaProgramSelectedCoordinator(viewController: DetailMediaProgramSelectedController())
                     coordinator.start()
                 } else if viewController is PreviousAyatViewController {
                     let coordinator = PreviousAyatCoordinator(viewController: PreviousAyatViewController())
                     coordinator.start()
                 } else if viewController is DetailAyaViewController {
                     let coordinator = DetailAyaCoordiantor(viewController: DetailAyaViewController())
                     coordinator.start()
                 } else if viewController is AlbumReciterViewController {
                    //QuranListen
                    
//                    QuranTafsir
//                    UserDefaults.standard.setValue(statusListen, forKey: "QuranListen")
//
                    if UserDefaults.standard.value(forKey: "QuranListen") != nil {
                        let coordinator = AlbumReciterCoordinator(viewController: AlbumReciterViewController(), statusListen: "QuranListen")
                        
                        print("QuranListenQuranListen")
                        coordinator.start()
                    } else {
                        let coordinator = AlbumReciterCoordinator(viewController: AlbumReciterViewController(), statusListen: "TafsirListen")
                        print("TafsirListenTafsirListen")
                        coordinator.start()

                    }
                   
                    
                 } else if viewController is ListAyatSpesficReciterViewController {
                     let coordinator = ListAyatSpesficReciterCooridnator(viewController: ListAyatSpesficReciterViewController())
                     coordinator.start()
                 } else if self.viewController is TafserBookViewController {
                     let coordinator = TafserBookCoordinator(viewController: TafserBookViewController())
                     coordinator.start()
                     
                 } else if viewController is QuarnListenViewController {
                     let coordinator =  QuarnListenCoordinator(viewController: QuarnListenViewController())
                              coordinator.start()
                     
                 } else if viewController is BookGetAllByPageNumberViewController {
                    let coordinator =  GetAllBooksPageCoordinator(viewController: BookGetAllByPageNumberViewController())
                             coordinator.start()
                 }
//
//
//             //self.coordinator?.start()
//         let coordinator = HomeCoordinator(viewController: HomeViewController())
//            coordinator.start()
        }
  @objc func saveQuraanIntoJsonFile() {
    
        var style = ToastStyle()
               style.messageColor = .white
               self.view.makeToast("برجاء الإنتظار لتحميل المصحف كامل", duration: 0.5, position: .center, style: style)

    
                  if let path = Bundle.main.path(forResource: "quraanReadAllJson", ofType: "json") {
                           do {
                               let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                               do {
                                   let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                                   if let people : [NSDictionary] = jsonResult["results"] as? [NSDictionary] {
                                       
                                       
                                       OperationQueue.main.addOperation({
                                             people.forEach { resultsObj in
                                               let name = resultsObj.value(forKey: "image") as! String
                                               
                                               let id = resultsObj.value(forKey: "id") as! Int
                                               //                                    self.view.makeToast("\(id)")
                                               print(id)
                                               let ur = URL(string: name)
                                               let imageData = try? Data(contentsOf: ur!)
                                               let compresedImage = UIImage(data: imageData!)
                                               UIImageWriteToSavedPhotosAlbum(compresedImage!, nil, nil, nil)
                                               
                                               
                                           }
                                           

                                      })

                                       let alert = UIAlertController(title: "Saved", message: "Your image has been saved", preferredStyle: .alert)
                                       let okAction = UIAlertAction(title: "Ok", style: .default)
                                       alert.addAction(okAction)
                                       self.present(alert, animated: true)
                                   }
                               } catch {}
                           } catch {}
                       }
    }
    
    
}
