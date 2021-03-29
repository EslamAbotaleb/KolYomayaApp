//
//  DetailAyaViewController.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/24/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds

class DetailAyaViewController: BaseViewController {

    var interstitial: GADInterstitial!

    var player: AVPlayer? = AVPlayer()
    var isPlaying: Bool = true
    var stopped = false
    var toggleState = 1
    var appendNumberAya: String?
    static var nameAya: String?
    static var shareButton =  UIButton()
    static var playPauseButton =  UIButton()
    
    var scrollView = UIScrollView()
    static var drawSecondLineView = UIView()
    static var drawThirdLineView = UIView()
    var contentView = UIView()
    static  var tafisrAyaView = UIView()
    static var drawLineView = UIView()
    static var tafsirAya = UILabel()
    static  var ayaName = UILabel()
    static  var numberAya = UILabel()
    static var fullNameAyaText = UILabel()
    static var tafsirNameText = UILabel()
    static var tafsirDescriptionText = UILabel()
    var banner: GADBannerView!
    var viewModel: AyaObjectViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initializeNavigationBarAppearanceWithBack(viewController: PreviousAyatViewController(), titleHeader: "كل يوم آية")
        setupScrollView()
        setupTopSection()
        containerView()

    }
    
    let tafsirName: UILabel = {

        DetailAyaViewController.tafsirNameText.translatesAutoresizingMaskIntoConstraints = false
        DetailAyaViewController.tafsirNameText.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        DetailAyaViewController.tafsirNameText.numberOfLines = 0
        DetailAyaViewController.tafsirNameText.font = UIFont(name: "Kitab", size: 35.0)
        DetailAyaViewController.tafsirNameText.font =  UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        
        return DetailAyaViewController.tafsirNameText
    }()
    let lineView: UIView = {
        DetailAyaViewController.drawLineView.translatesAutoresizingMaskIntoConstraints = false
        DetailAyaViewController.drawLineView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return DetailAyaViewController.drawLineView
    }()
    let tafsirDescription: UILabel = {

        DetailAyaViewController.tafsirDescriptionText.translatesAutoresizingMaskIntoConstraints = false
        
        
        return DetailAyaViewController.tafsirDescriptionText
    }()
    
   
    
    func setupScrollView() {
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

//        self.scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: DeviceUsage.SCREEN_WIDTH, height: <#T##Int#>))
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.5215686275, blue: 0.4666666667, alpha: 1)
//        print("scrollViewHeight\(scrollView.frame.height)")
        
//        scrollView.backgroundColor = UIColor.brown
//               scrollView.translatesAutoresizingMaskIntoConstraints = false
//               view.addSubview(scrollView)
//               scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//               scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//               scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//               scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

    }
    let stackViewTopSectionSpesficAyaNameAndNumber: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        stackView.spacing = 8.0
        ayaName.translatesAutoresizingMaskIntoConstraints = false
        ayaName.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        ayaName.font = UIFont(name: "GE SS Two", size: 35.0)
        ayaName.font =  UIFont.systemFont(ofSize: 24.0, weight: .light)
       
        
        numberAya.translatesAutoresizingMaskIntoConstraints = false
        numberAya.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        numberAya.font = UIFont(name: "GE SS Two", size: 35.0)
        numberAya.font =  UIFont.systemFont(ofSize: 24.0, weight: .light)
       

        stackView.addArrangedSubview(numberAya)

        stackView.addArrangedSubview(ayaName)
        stackView.translatesAutoresizingMaskIntoConstraints = false


        return stackView
 
    }()
    let stackViewForPlayAndShareButton: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 20.0
        DetailAyaViewController.playPauseButton.translatesAutoresizingMaskIntoConstraints = false

        
        DetailAyaViewController.playPauseButton.setImage(UIImage(named: "play_icon"), for: .normal)
        DetailAyaViewController.playPauseButton.imageView?.contentMode = .scaleAspectFit
        DetailAyaViewController.playPauseButton.imageEdgeInsets = UIEdgeInsets(top: 2.0, left: 0.0, bottom: 0, right: 104.0)
      
        
        DetailAyaViewController.playPauseButton.setTitle("تشغيل", for: .normal)
        DetailAyaViewController.shareButton.translatesAutoresizingMaskIntoConstraints = false
        DetailAyaViewController.shareButton.setImage(UIImage(named: "share"), for: .normal)
        DetailAyaViewController.shareButton.translatesAutoresizingMaskIntoConstraints = false
        DetailAyaViewController.shareButton.imageView?.contentMode = .scaleAspectFit
        DetailAyaViewController.shareButton.imageEdgeInsets = UIEdgeInsets(top: 1.0, left: 0.0, bottom: 0, right: 104.0)
        DetailAyaViewController.shareButton.setTitle("مشاركة", for: .normal)


        stackView.addArrangedSubview(shareButton)
        stackView.addArrangedSubview(playPauseButton)

        stackView.translatesAutoresizingMaskIntoConstraints = false

       return stackView
    }()
    let lineViewBetweenAyaAndButton: UIView = {
        DetailAyaViewController.drawSecondLineView.translatesAutoresizingMaskIntoConstraints = false
        DetailAyaViewController.drawSecondLineView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return DetailAyaViewController.drawSecondLineView
    }()
    let lineViewBetweenSuraNameAndFullAyaName: UIView = {
        DetailAyaViewController.drawThirdLineView.translatesAutoresizingMaskIntoConstraints = false
        DetailAyaViewController.drawThirdLineView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return DetailAyaViewController.drawThirdLineView
    }()
    func setupTopSection() {
      
        
            self.contentView.addSubview(self.stackViewTopSectionSpesficAyaNameAndNumber)


            stackViewTopSectionSpesficAyaNameAndNumber.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        stackViewTopSectionSpesficAyaNameAndNumber.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 2.0).isActive = true

            stackViewTopSectionSpesficAyaNameAndNumber.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.97).isActive = true
            stackViewTopSectionSpesficAyaNameAndNumber.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
            
           
            lineViewBetweenSuraNameAndFullAyaName.translatesAutoresizingMaskIntoConstraints = false
            
            contentView.addSubview(lineViewBetweenSuraNameAndFullAyaName)

            
            lineViewBetweenSuraNameAndFullAyaName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true

            
            lineViewBetweenSuraNameAndFullAyaName.topAnchor.constraint(equalTo: stackViewTopSectionSpesficAyaNameAndNumber.bottomAnchor, constant: 5.0).isActive = true

            lineViewBetweenSuraNameAndFullAyaName.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
            lineViewBetweenSuraNameAndFullAyaName.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
          
            self.contentView.addSubview(self.labelFullNameAya)
            labelFullNameAya.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true

            labelFullNameAya.topAnchor.constraint(equalTo: self.lineViewBetweenSuraNameAndFullAyaName.bottomAnchor, constant: 18.0).isActive = true

            labelFullNameAya.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.96).isActive = true


            lineViewBetweenAyaAndButton.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(lineViewBetweenAyaAndButton)
            lineViewBetweenAyaAndButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true

            lineViewBetweenAyaAndButton.topAnchor.constraint(equalTo: labelFullNameAya.bottomAnchor, constant: 5.0).isActive = true


            lineViewBetweenAyaAndButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.0).isActive = true
            lineViewBetweenAyaAndButton.heightAnchor.constraint(equalToConstant: 0.4).isActive = true

            self.contentView.addSubview(self.stackViewForPlayAndShareButton)

            stackViewForPlayAndShareButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 5.0).isActive = true

            stackViewForPlayAndShareButton.topAnchor.constraint(equalTo: self.lineViewBetweenAyaAndButton.bottomAnchor, constant: 10.0).isActive = true

            stackViewForPlayAndShareButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.48).isActive = true

            stackViewForPlayAndShareButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true

        

        DetailAyaViewController.playPauseButton.addTarget(self, action: #selector(playAyaBySpesficReciter(sender:)), for: .touchUpInside)
        DetailAyaViewController.shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)

    }
    @objc func playAyaBySpesficReciter(sender: UIButton) {

        print("presssed")
        if isPlaying == true {
            isPlaying = false
            
            DetailAyaViewController.playPauseButton.setImage(UIImage(named: "pause_icon"), for: .normal)
            DetailAyaViewController.playPauseButton.imageView?.contentMode = .scaleAspectFit
            DetailAyaViewController.playPauseButton.imageEdgeInsets = UIEdgeInsets(top: 2.0, left: -1.0, bottom: 0, right: 103.0)
            DetailAyaViewController.playPauseButton.setTitle("ايقاف", for: .normal)
           
//            self.viewModel?.todayAyaApi() { [weak self] todayAyaModel in

            if  self.viewModel!.ayaNumber < 10 {
                self.appendNumberAya = "00"  + "\(viewModel!.ayaNumber)"
            } else if viewModel!.ayaNumber >= 10 &&  viewModel!.ayaNumber < 100{
                    self.appendNumberAya = "0"  + "\(viewModel!.ayaNumber)"
                } else if viewModel!.ayaNumber >= 100 {
                    self.appendNumberAya =    "\(viewModel!.ayaNumber)"
                }

                if UserDefaults.standard.value(forKey: "getNameReciter") as? String != nil {
                    let nameReciter = UserDefaults.standard.value(forKey: "getNameReciter") as? String
                    for indexAyaname in 0..<KeyAndValue.SURA_NAME.count {

                        if  KeyAndValue.SURA_NAME[indexAyaname].name == viewModel?.suraName {
    //                        self!.initPlayer(url: "http://212.57.192.148/ayat/mp3/\(nameReciter!)/\(KeyAndValue.SURA_NAME[indexAyaname].id)\(self!.appendNumberAya!).mp3")
                            
                            guard let url = URL.init(string: "http://212.57.192.148/ayat/mp3/\(nameReciter!)/\(KeyAndValue.SURA_NAME[indexAyaname].id)\(self.appendNumberAya!).mp3") else { return }
                            let playerItem = AVPlayerItem.init(url: url)
                            NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying(sender:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
                            self.player = AVPlayer.init(playerItem: playerItem)
                            self.player?.play()

    //
                            break
                        }

                    }

                } else {
                    print("")
                    let reader_Names = Bundle.main.infoDictionary!["reader_values"] as! NSArray
                    let readerObject = reader_Names[0] as? String


                    for indexAyaname in 0..<KeyAndValue.SURA_NAME.count {
                   
                        guard let url = URL.init(string: "http://212.57.192.148/ayat/mp3/\(readerObject!)/\(KeyAndValue.SURA_NAME[indexAyaname].id)\(self.appendNumberAya!).mp3") else { return }
                        let playerItem = AVPlayerItem.init(url: url)
                        NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying(sender:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
                        self.player = AVPlayer.init(playerItem: playerItem)
                        self.player?.play()

                  
                        break
                    }
                
            }

        } else {
            isPlaying = true
            DetailAyaViewController.playPauseButton.setImage(UIImage(named: "play_icon"), for: .normal)
            DetailAyaViewController.playPauseButton.imageView?.contentMode = .scaleAspectFit
            DetailAyaViewController.playPauseButton.imageEdgeInsets = UIEdgeInsets(top: 2.0, left: -1.0, bottom: 0, right: 103.0)
          
            DetailAyaViewController.playPauseButton.setTitle("تشغيل", for: .normal)
            

                if viewModel!.ayaNumber < 10 {
                    self.appendNumberAya = "00"  + "\(viewModel!.ayaNumber)"
                } else if viewModel!.ayaNumber >= 10 &&  viewModel!.ayaNumber < 100{
                    self.appendNumberAya = "0"  + "\(viewModel!.ayaNumber)"
                } else if viewModel!.ayaNumber >= 100 {
                    self.appendNumberAya =  "\(viewModel!.ayaNumber)"
                }

                if UserDefaults.standard.value(forKey: "getNameReciter") as? String != nil {
                    let nameReciter = UserDefaults.standard.value(forKey: "getNameReciter") as? String
                    for indexAyaname in 0..<KeyAndValue.SURA_NAME.count {

                        if  KeyAndValue.SURA_NAME[indexAyaname].name == viewModel!.suraName {
                            guard let url = URL.init(string: "http://212.57.192.148/ayat/mp3/\(nameReciter!)/\(KeyAndValue.SURA_NAME[indexAyaname].id)\(self.appendNumberAya!).mp3") else { return }
                            let playerItem = AVPlayerItem.init(url: url)

                            self.player = AVPlayer.init(playerItem: playerItem)
                            self.player?.pause()

                        break
                        }

                    }

                } else {
                    print("")
                    let reader_Names = Bundle.main.infoDictionary!["reader_values"] as! NSArray
                    let readerObject = reader_Names[0] as? String


                    for indexAyaname in 0..<KeyAndValue.SURA_NAME.count {
                   
                        
                        guard let url = URL.init(string: "http://212.57.192.148/ayat/mp3/\(readerObject!)/\(KeyAndValue.SURA_NAME[indexAyaname].id)\(self.appendNumberAya!).mp3") else { return }
                        let playerItem = AVPlayerItem.init(url: url)

                        self.player = AVPlayer.init(playerItem: playerItem)
                        self.player?.pause()
                        break
                    }
                }
            }

        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
           if keyPath == "rate" && (change?[NSKeyValueChangeKey.newKey] as? Float) == 0 {
               print(">>> stopped")
               stopped = true
           } else if keyPath == "rate" && (change?[NSKeyValueChangeKey.newKey] as? Float) == 1 {
               print(">>> played again")
               stopped = false
           }
       }
    func containerView() {
        DetailAyaViewController.tafisrAyaView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(DetailAyaViewController.tafisrAyaView)
        
        DetailAyaViewController.tafisrAyaView.topAnchor.constraint(equalTo: self.stackViewForPlayAndShareButton.bottomAnchor, constant: 10.0).isActive = true
        
        DetailAyaViewController.tafisrAyaView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        DetailAyaViewController.tafisrAyaView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true

        DetailAyaViewController.tafisrAyaView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0).isActive = true
       
        DetailAyaViewController.tafisrAyaView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        DetailAyaViewController.tafisrAyaView.layer.cornerRadius = 50
        DetailAyaViewController.tafisrAyaView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        DetailAyaViewController.tafisrAyaView.addSubview(tafsirName)
     
        tafsirName.translatesAutoresizingMaskIntoConstraints = false
        
        tafsirName.centerXAnchor.constraint(equalTo: DetailAyaViewController.tafisrAyaView.centerXAnchor).isActive = true

        tafsirName.widthAnchor.constraint(equalTo: DetailAyaViewController.tafisrAyaView.widthAnchor, multiplier: 0.95).isActive = true
        
        tafsirName.topAnchor.constraint(equalTo: DetailAyaViewController.tafisrAyaView.topAnchor, constant: 25.0).isActive = true
 
        tafsirName.heightAnchor.constraint(equalToConstant: 25.0).isActive = true

        
        DetailAyaViewController.tafisrAyaView.addSubview(lineView)

        lineView.topAnchor.constraint(equalTo: tafsirName.bottomAnchor, constant: 10.0).isActive = true

        lineView.centerXAnchor.constraint(equalTo: DetailAyaViewController.tafisrAyaView.centerXAnchor).isActive = true

        lineView.widthAnchor.constraint(equalTo: DetailAyaViewController.tafisrAyaView.widthAnchor, multiplier: 1.0).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 0.8).isActive = true
//
        DetailAyaViewController.tafisrAyaView.addSubview(tafsirDescription)
//
        tafsirDescription.translatesAutoresizingMaskIntoConstraints = false

        tafsirDescription.centerXAnchor.constraint(equalTo: DetailAyaViewController.tafisrAyaView.centerXAnchor).isActive = true
        tafsirDescription.widthAnchor.constraint(equalTo: DetailAyaViewController.tafisrAyaView.widthAnchor, multiplier: 0.91).isActive = true

        tafsirDescription.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 5.0).isActive = true
        tafsirDescription.bottomAnchor.constraint(equalTo: DetailAyaViewController.tafisrAyaView.bottomAnchor, constant: 0.0).isActive = true
        
        
    }
//    func containerView() {
//        DetailAyaViewController.tafisrAyaView.translatesAutoresizingMaskIntoConstraints = false
//
//        contentView.addSubview(DetailAyaViewController.tafisrAyaView)
//
//        DetailAyaViewController.tafisrAyaView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
//        DetailAyaViewController.tafisrAyaView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
//        DetailAyaViewController.tafisrAyaView.topAnchor.constraint(equalTo: self.stackViewForPlayAndShareButton.bottomAnchor, constant: 10.0).isActive = true
//
//        DetailAyaViewController.tafisrAyaView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 30.0).isActive = true
////        //DeviceUsage.SCREEN_HEIGHT
//        DetailAyaViewController.tafisrAyaView.heightAnchor.constraint(equalToConstant: DeviceUsage.SCREEN_HEIGHT).isActive = true
//
//        DetailAyaViewController.tafisrAyaView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        DetailAyaViewController.tafisrAyaView.layer.cornerRadius = 50
//        DetailAyaViewController.tafisrAyaView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
//
//        DetailAyaViewController.tafisrAyaView.addSubview(tafsirName)
//        tafsirName.translatesAutoresizingMaskIntoConstraints = false
//        tafsirName.topAnchor.constraint(equalTo: DetailAyaViewController.tafisrAyaView.topAnchor, constant: 25.0).isActive = true
//
//        tafsirName.leadingAnchor.constraint(equalTo: DetailAyaViewController.tafisrAyaView.leadingAnchor, constant: 10.0).isActive = true
//
//        tafsirName.trailingAnchor.constraint(equalTo: DetailAyaViewController.tafisrAyaView.trailingAnchor, constant: 10.0).isActive = true
//        tafsirName.heightAnchor.constraint(equalToConstant: 19.0).isActive = true
//
//        DetailAyaViewController.tafisrAyaView.addSubview(lineView)
//
//        lineView.topAnchor.constraint(equalTo: tafsirName.bottomAnchor, constant: 20.0).isActive = true
//
//
//        lineView.widthAnchor.constraint(equalTo: DetailAyaViewController.tafisrAyaView.widthAnchor, multiplier: 1.0).isActive = true
//        lineView.heightAnchor.constraint(equalToConstant: 0.8).isActive = true
//
//        DetailAyaViewController.tafisrAyaView.addSubview(tafsirDescription)
//
//        tafsirDescription.translatesAutoresizingMaskIntoConstraints = false
//
//        tafsirDescription.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 20.0).isActive = true
//        tafsirDescription.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.96).isActive = true
////        tafsirDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10.0).isActive = true
////        tafsirDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0).isActive = true
//        tafsirDescription.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10.0).isActive = true
//
//    }
  
//    func textViewDidChange(_ textView: UITextView) {
//            let mutableAttrStr = NSMutableAttributedString(string: textView.text)
//            let style = NSMutableParagraphStyle()
//            style.lineSpacing = 27
//        mutableAttrStr.addAttributes([NSAttributedString.Key.paragraphStyle:style], range: NSMakeRange(0, mutableAttrStr.length))
//            textView.attributedText = mutableAttrStr
//        }
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        
//        DetailAyaViewController.playPauseButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -140, bottom: 0, right: 0)
//
//        DetailAyaViewController.shareButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -130, bottom: 0, right: 0)
//
//        DetailAyaViewController.shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
//
           
            
            DetailAyaViewController.numberAya.font = UIFont(name: "GE SS Two", size: 35.0)
            DetailAyaViewController.numberAya.font =  UIFont.systemFont(ofSize: 21.0, weight: .light)
//
            DetailAyaViewController.numberAya.text =  "آية: " + "\(viewModel!.ayaNumber)".convertToPersianNum()
            
            DetailAyaViewController.ayaName.font = UIFont(name: "GE SS Two", size: 35.0)
            DetailAyaViewController.ayaName.font =  UIFont.systemFont(ofSize: 21.0, weight: .light)
//
            DetailAyaViewController.ayaName.text =  "سورة: " + "\(viewModel!.suraName)"
        
        DetailAyaViewController.tafsirNameText.font = UIFont(name: "GE SS Two", size: 35.0)
        DetailAyaViewController.tafsirNameText.font =  UIFont.systemFont(ofSize: 18.0, weight: .bold)
//
        DetailAyaViewController.tafsirNameText.text =  "تفسير: " + "\(viewModel!.tafsirAuthor)"
        
//
        
//            DetailAyaViewController.labelFullNameAya.text = viewModel?.aya
//            self?.tafsirName.text = "  تفسير:  " + todayAyaModel.ayaObject!.tafsirAuthor
        self.tafsirDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
          
            self.tafsirDescription.numberOfLines = 0
            self.tafsirDescription.font = UIFont(name: "GE SS Two", size: 35.0)
            self.tafsirDescription.font =  UIFont.systemFont(ofSize: 14.0, weight: .semibold)
//            self?.tafsirDescription.text = todayAyaModel.ayaObject!.tafsir
        
        
        
        let paragraphStyleullNameAya = NSMutableParagraphStyle()
        //line height size
        paragraphStyleullNameAya.lineSpacing = 10.0
        let attrStringullNameAya = NSMutableAttributedString(string: viewModel!.aya)
            
        attrStringullNameAya.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleullNameAya,
        range:NSMakeRange(0, attrStringullNameAya.length))
        self.labelFullNameAya.attributedText = attrStringullNameAya
        self.labelFullNameAya.textAlignment = NSTextAlignment.right
        
        
        
//        labelFullNameAya.text = viewModel?.aya
        
            let paragraphStyle = NSMutableParagraphStyle()
            //line height size
            paragraphStyle.lineSpacing = 10.0
            let attrString = NSMutableAttributedString(string: viewModel!.tafsir)
                
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle,
            range:NSMakeRange(0, attrString.length))
            self.tafsirDescription.attributedText = attrString
            self.tafsirDescription.textAlignment = NSTextAlignment.right


        
       
    }
    let labelFullNameAya: UILabel = {
            
        DetailAyaViewController.fullNameAyaText.translatesAutoresizingMaskIntoConstraints = false
        DetailAyaViewController.fullNameAyaText.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
      
        DetailAyaViewController.fullNameAyaText.numberOfLines = 0
        DetailAyaViewController.fullNameAyaText.sizeToFit()
        DetailAyaViewController.fullNameAyaText.font = UIFont(name: "Kitab", size: 35.0)
        DetailAyaViewController.fullNameAyaText.font =  UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        
        return DetailAyaViewController.fullNameAyaText
    }()

//    func initPlayer(url : String) {
//          guard let url = URL.init(string: url) else { return }
//          let playerItem = AVPlayerItem.init(url: url)
//          NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying(sender:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
//
//          player = AVPlayer.init(playerItem: playerItem)
//
//          isPlaying = true
//          player?.play()
//
//        DetailAyaViewController.playPauseButton.setImage(UIImage(named: "pause_btn"), for: .normal)
//        DetailAyaViewController.playPauseButton.setTitle("تشغيل", for: .normal)
//
//      }
//
    @objc func playerDidFinishPlaying(sender: Notification) {
           // Your code here
//        DetailAyaViewController.playPauseButton.setImage(UIImage(named: "play_btn"), for: .normal)
//        DetailAyaViewController.playPauseButton.imageView?.contentMode = .scaleAspectFit
//        DetailAyaViewController.playPauseButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        DetailAyaViewController.playPauseButton.setImage(UIImage(named: "play_icon"), for: .normal)
        DetailAyaViewController.playPauseButton.imageView?.contentMode = .scaleAspectFit
        DetailAyaViewController.playPauseButton.imageEdgeInsets = UIEdgeInsets(top: 2.0, left: -1.0, bottom: 0, right: 103.0)
        DetailAyaViewController.playPauseButton.setTitle("تشغيل", for: .normal)
       }
    @objc func share(sender:UIView){
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        
        let textToShare = viewModel?.aya
        
        if let myWebsite = URL(string: "http://bit.ly/2OF1tyg") {//Enter link to your app here
            let objectsToShare = [textToShare, myWebsite, image ?? #imageLiteral(resourceName: "app-logo")] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            //Excluded Activities
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.mail, UIActivity.ActivityType.postToFacebook]
            //
            
            activityVC.popoverPresentationController?.sourceView = sender
            self.present(activityVC, animated: true, completion: nil)
        }
        
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    private var shouldDisplayAd = true
    
    private var isAdReady:Bool = false {
        didSet {
            if isAdReady && shouldDisplayAd {
//                displayAd()
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
}

extension DetailAyaViewController: GADInterstitialDelegate {
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
extension DetailAyaViewController: GADBannerViewDelegate {
    
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
//        heightBanner.constant = 60.0
//        self.bannerView.addSubview(banner)
    }
    
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
