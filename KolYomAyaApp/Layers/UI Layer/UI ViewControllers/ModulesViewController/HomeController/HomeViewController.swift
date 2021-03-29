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
import GoogleMobileAds


class HomeViewController: BaseViewController, GADBannerViewDelegate {
    //    @IBOutlet weak var bottomspaceforview: NSLayoutConstraint!
    //    var ayaStr: String?
    //    @IBOutlet weak var heightBanner: NSLayoutConstraint!
    //    @IBOutlet weak var scrollView: UIScrollView!
    //    @IBOutlet weak var widthBottomBanner: NSLayoutConstraint!
    //    @IBOutlet weak var heightBottomBanner: NSLayoutConstraint!
    //    @IBOutlet weak var bannerView: GADBannerView!
    //    @IBOutlet weak var bottomBannerView: GADBannerView!
    //    @IBOutlet weak var playPauseButton: UIButton!
    //    @IBOutlet weak var fullNameAyaText: UILabel!
    //    @IBOutlet weak var nameAyaText: UILabel!
    //    @IBOutlet weak var numberAyaText: UILabel!
    //    @IBOutlet weak var shareButton: UIButton!
    //    @IBOutlet weak var playButton: UIButton!
    //    @IBOutlet weak var descriptionAyaTodayText: UILabel!
    //    @IBOutlet weak var ayaView: UIView!
    //    @IBOutlet weak var tafserNameLabel: UILabel!
    var player: AVPlayer? = AVPlayer()
    var isPlaying: Bool = true
    var stopped = false
    var toggleState = 1
    var appendNumberAya: String?
    static var nameAya: String?
    static var shareButton =  UIButton()
    static var playPauseButton =  UIButton()

    var banner: GADBannerView!
    var errorAds: String?
    var viewModel: HomeViewModel?
    
    //Programmitcally
    
//    let scrollView = UIScrollView()
   
    var scrollView = UIScrollView()

    var contentView = UIView()
    static  var tafisrAyaView = UIView()
    static var drawLineView = UIView()
    static var drawSecondLineView = UIView()
    static var drawThirdLineView = UIView()

    static var tafsirAya = UILabel()
   static  var ayaName = UILabel()
    static  var numberAya = UILabel()
    static var fullNameAyaText = UILabel()
    static var tafsirNameText = UILabel()
    static var tafsirDescriptionText = UILabel()
    var bannerAdTopView = GADBannerView()
    var bannerAdBottomView = GADBannerView()
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//
//        // Call the roundCorners() func right there.
////        ayaView.roundCorners([.topLeft, .topRight], radius: 55.0)
////        scrollView.contentSize = CGSize(width: 375, height: 1800)
//
//    }
    
    let labelFullNameAya: UILabel = {
            
        HomeViewController.fullNameAyaText.translatesAutoresizingMaskIntoConstraints = false
        HomeViewController.fullNameAyaText.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
      
        HomeViewController.fullNameAyaText.numberOfLines = 0
        HomeViewController.fullNameAyaText.sizeToFit()
        HomeViewController.fullNameAyaText.font = UIFont(name: "Kitab", size: 35.0)
        HomeViewController.fullNameAyaText.font =  UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        
        return HomeViewController.fullNameAyaText
    }()
    let tafsirName: UILabel = {

        HomeViewController.tafsirNameText.translatesAutoresizingMaskIntoConstraints = false
        HomeViewController.tafsirNameText.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        HomeViewController.tafsirNameText.numberOfLines = 0
        HomeViewController.tafsirNameText.font = UIFont(name: "Kitab", size: 35.0)
        HomeViewController.tafsirNameText.font =  UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        
        return HomeViewController.tafsirNameText
    }()
    let lineView: UIView = {
        HomeViewController.drawLineView.translatesAutoresizingMaskIntoConstraints = false
        HomeViewController.drawLineView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return HomeViewController.drawLineView
    }()
    let lineViewBetweenAyaAndButton: UIView = {
        HomeViewController.drawSecondLineView.translatesAutoresizingMaskIntoConstraints = false
        HomeViewController.drawSecondLineView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return HomeViewController.drawSecondLineView
    }()
    let lineViewBetweenSuraNameAndFullAyaName: UIView = {
        HomeViewController.drawThirdLineView.translatesAutoresizingMaskIntoConstraints = false
        HomeViewController.drawThirdLineView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return HomeViewController.drawThirdLineView
    }()
    
    
    let tafsirDescription: UILabel = {

        HomeViewController.tafsirDescriptionText.translatesAutoresizingMaskIntoConstraints = false

        
        return HomeViewController.tafsirDescriptionText
    }()
    
   
    
    func setupScrollView() {
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
     
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.5215686275, blue: 0.4666666667, alpha: 1)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

    }
    func setupTopBanner() {
    
//        bannerAdTopView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0.0).isActive = true
//        bannerAdTopView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0.0).isActive = true
//        bannerAdTopView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0).isActive = true
       
        banner = GADBannerView(adSize: kGADAdSizeBanner)
        bannerAdTopView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bannerAdTopView)

        bannerAdTopView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        bannerAdTopView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        bannerAdTopView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        
//        bannerAdTopView.heightAnchor.constraint(equalToConstant: 0.0).isActive = true

        
        //Banner One
        self.bannerAdTopView.addSubview(banner)
        bannerAdTopView.adUnitID = Keys.BannerOne
        bannerAdTopView.rootViewController = self
        bannerAdTopView.load(GADRequest())
        bannerAdTopView.delegate = self
        

    }
 
    func setupTopSection() {
        
    
        self.contentView.addSubview(self.stackViewTopSectionSpesficAyaNameAndNumber)


        stackViewTopSectionSpesficAyaNameAndNumber.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        stackViewTopSectionSpesficAyaNameAndNumber.topAnchor.constraint(equalTo: self.bannerAdTopView.bottomAnchor, constant: 5.0).isActive = true

        stackViewTopSectionSpesficAyaNameAndNumber.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.91).isActive = true
        stackViewTopSectionSpesficAyaNameAndNumber.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
        
       
        lineViewBetweenSuraNameAndFullAyaName.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(lineViewBetweenSuraNameAndFullAyaName)

        
        lineViewBetweenSuraNameAndFullAyaName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true

        
        lineViewBetweenSuraNameAndFullAyaName.topAnchor.constraint(equalTo: stackViewTopSectionSpesficAyaNameAndNumber.bottomAnchor, constant: 5.0).isActive = true

        lineViewBetweenSuraNameAndFullAyaName.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        lineViewBetweenSuraNameAndFullAyaName.heightAnchor.constraint(equalToConstant: 0.6).isActive = true
        lineViewBetweenSuraNameAndFullAyaName.layer.opacity = 0.1
        self.contentView.addSubview(self.labelFullNameAya)
        labelFullNameAya.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true

        labelFullNameAya.topAnchor.constraint(equalTo: self.lineViewBetweenSuraNameAndFullAyaName.bottomAnchor, constant: 18.0).isActive = true

        labelFullNameAya.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.96).isActive = true


        lineViewBetweenAyaAndButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(lineViewBetweenAyaAndButton)
        lineViewBetweenAyaAndButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true

        lineViewBetweenAyaAndButton.topAnchor.constraint(equalTo: labelFullNameAya.bottomAnchor, constant: 20.0).isActive = true


        lineViewBetweenAyaAndButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.0).isActive = true
        
        lineViewBetweenAyaAndButton.heightAnchor.constraint(equalToConstant: 0.6).isActive = true
            
        lineViewBetweenAyaAndButton.layer.opacity = 0.1
        self.contentView.addSubview(self.stackViewForPlayAndShareButton)

        stackViewForPlayAndShareButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 5.0).isActive = true

        stackViewForPlayAndShareButton.topAnchor.constraint(equalTo: self.lineViewBetweenAyaAndButton.bottomAnchor, constant: 5.0).isActive = true

        stackViewForPlayAndShareButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.48).isActive = true

        stackViewForPlayAndShareButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true

        HomeViewController.playPauseButton.addTarget(self, action: #selector(playAyaBySpesficReciter), for: .touchUpInside)
        HomeViewController.shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
     
    }
    
    func containerView() {
        HomeViewController.tafisrAyaView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(HomeViewController.tafisrAyaView)
        
        HomeViewController.tafisrAyaView.topAnchor.constraint(equalTo: self.stackViewForPlayAndShareButton.bottomAnchor, constant: 10.0).isActive = true
        
        HomeViewController.tafisrAyaView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        HomeViewController.tafisrAyaView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
       
        HomeViewController.tafisrAyaView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0).isActive = true
       
        HomeViewController.tafisrAyaView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        HomeViewController.tafisrAyaView.layer.cornerRadius = 50
        HomeViewController.tafisrAyaView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        HomeViewController.tafisrAyaView.addSubview(tafsirName)
     
        tafsirName.translatesAutoresizingMaskIntoConstraints = false
        
        tafsirName.centerXAnchor.constraint(equalTo: HomeViewController.tafisrAyaView.centerXAnchor).isActive = true

        tafsirName.widthAnchor.constraint(equalTo: HomeViewController.tafisrAyaView.widthAnchor, multiplier: 0.95).isActive = true
        
        tafsirName.topAnchor.constraint(equalTo: HomeViewController.tafisrAyaView.topAnchor, constant: 25.0).isActive = true
 
        tafsirName.heightAnchor.constraint(equalToConstant: 25.0).isActive = true

        
        HomeViewController.tafisrAyaView.addSubview(lineView)

        lineView.topAnchor.constraint(equalTo: tafsirName.bottomAnchor, constant: 10.0).isActive = true

        lineView.centerXAnchor.constraint(equalTo: HomeViewController.tafisrAyaView.centerXAnchor).isActive = true

        lineView.widthAnchor.constraint(equalTo: HomeViewController.tafisrAyaView.widthAnchor, multiplier: 1.0).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 0.7).isActive = true
        lineView.layer.opacity = 0.3
//
        HomeViewController.tafisrAyaView.addSubview(tafsirDescription)
//
        tafsirDescription.translatesAutoresizingMaskIntoConstraints = false

        tafsirDescription.centerXAnchor.constraint(equalTo: HomeViewController.tafisrAyaView.centerXAnchor).isActive = true
        tafsirDescription.widthAnchor.constraint(equalTo: HomeViewController.tafisrAyaView.widthAnchor, multiplier: 0.95).isActive = true

        tafsirDescription.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 20.0).isActive = true

        bottomBanner()
        
        
    }
    func bottomBanner() {
        HomeViewController.tafisrAyaView.addSubview(bannerAdBottomView)

        bannerAdBottomView.translatesAutoresizingMaskIntoConstraints = false
        bannerAdBottomView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        bannerAdBottomView.topAnchor.constraint(equalTo: tafsirDescription.bottomAnchor, constant: 6.0).isActive = true
        bannerAdBottomView.widthAnchor.constraint(equalTo: HomeViewController.tafisrAyaView.widthAnchor, multiplier: 1.0).isActive = true
        bannerAdBottomView.bottomAnchor.constraint(equalTo: HomeViewController.tafisrAyaView.bottomAnchor).isActive = true
        bannerAdBottomView.heightAnchor.constraint(equalToConstant: 60.0).isActive = true


        banner = GADBannerView(adSize: kGADAdSizeBanner)
        //Banner One
        self.bannerAdBottomView.addSubview(banner)
        bannerAdBottomView.adUnitID = Keys.BannerTwo
        bannerAdBottomView.rootViewController = self
        bannerAdBottomView.load(GADRequest())
        bannerAdBottomView.delegate = self
    }
    @objc func printPrssed(_ sender: UIButton) {
        print("sharedAction")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        .constant = 0.0heightBanner
//        heightBanner.constant = 0.0
//        heightBottomBanner.constant = 0.0
        self.intialnavigationBarAppearaceWithmenu(checkflag: false)
      
    }
    lazy var v1:UIView = {
            let v = UIView()
        v.backgroundColor = .blue
            return v
    }()
        
    lazy var v2:UIView = {
            let v = UIView()
        v.backgroundColor = .blue
            return v
    }()
        

    
    let stackViewForPlayAndShareButton: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 17.0

//        var expandHittableAreaAmt: CGFloat = 10
//            var buttonWidth: CGFloat = 20
//        var button = UIButton(type: UIButton.ButtonType.Custom) as UIButton
//            button.frame = CGRectMake(0, 0,
//                buttonWidth + expandHittableAreaAmt*2,
//                buttonWidth + expandHittableAreaAmt*2)
//        button.imageEdgeInsets = UIEdgeInsets(top: expandHittableAreaAmt,
//                                              left: expandHittableAreaAmt, bottom: expandHittableAreaAmt, right: expandHittableAreaAmt)
//            button.setImage(UIImage(named: "buttonImage"), forState: .Normal) //20x20 image
//            button.addTarget(self, action: "didTouchButton:", forControlEvents: .TouchUpInside)
//

        HomeViewController.playPauseButton.translatesAutoresizingMaskIntoConstraints = false

        HomeViewController.playPauseButton.setImage(UIImage(named: "play_icon"), for: .normal)
        HomeViewController.playPauseButton.imageView?.contentMode = .scaleAspectFit
        HomeViewController.playPauseButton.imageEdgeInsets = UIEdgeInsets(top: 2.0, left: -5.0, bottom: 0, right: 110.0)
//        HomeViewController.playPauseButton.imageEdgeInsets = UIEdgeInsets(top: 2.0, left: -2.0, bottom: 0, right: 105.0)
//        let textLabel = UILabel()
//        textLabel.backgroundColor = UIColor.green
//        textLabel.widthAnchor.constraint(equalToConstant: 190.0).isActive = true
//        textLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true

//        textLabel.textAlignment = .center
        HomeViewController.playPauseButton.setTitle("تشغيل" + "", for: .normal)
        HomeViewController.shareButton.translatesAutoresizingMaskIntoConstraints = false
        HomeViewController.shareButton.setImage(UIImage(named: "share"), for: .normal)
        HomeViewController.shareButton.imageView?.contentMode = .scaleAspectFit

        HomeViewController.shareButton.imageEdgeInsets = UIEdgeInsets(top: 2.0, left: -5.0, bottom: 0, right: 110.0)
//        HomeViewController.shareButton.imageEdgeInsets = UIEdgeInsets(top: 1.0, left: -3.0, bottom: 0, right: 105.0)
        HomeViewController.shareButton.setTitle(  "مشاركة" + "", for: .normal)


        stackView.addArrangedSubview(shareButton)
//        stackView.addArrangedSubview(textLabel)

        stackView.addArrangedSubview(playPauseButton)

        stackView.translatesAutoresizingMaskIntoConstraints = false

       return stackView
    }()
    let stackViewTopSectionSpesficAyaNameAndNumber: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill // .Leading .FirstBaseline .Center .Trailing .LastBaseline
        stackView.distribution = .fillEqually // .FillEqually .FillProportionally .EqualSpacing .EqualCentering
        
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
 
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // with auto layout
//        fatalError()
        
        viewModel = HomeViewModel()
        KeyAndValue.getSura_Name()
        KeyAndValue.getSura_Number()
        
    // ayaView.roundCorners([.topLeft, .topRight], radius: 25.0)
        
        NetworkReachability.shared.reach.whenReachable = { _ in
            self.hideLoader()
            self.viewModel?.cordinator?.didFinish()
            self.handleApiFromServer()
            
        }
     
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
            self.handleApiFromServer()
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
        setupScrollView()
        setupTopBanner()
        setupTopSection()
        containerView()
        
        
    }
    
    func showLoader(){
        self.view.isUserInteractionEnabled = false
        InviaLoadingIndicator.show()
    }
    
    func hideLoader(){
        self.view.isUserInteractionEnabled = true
        InviaLoadingIndicator.hide()
    }
    
    func handleApiFromServer() {
        self.viewModel?.todayAyaApi() { [weak self] todayAyaModel in
            
            
            
            HomeViewController.numberAya.font = UIFont(name: "GE SS Two", size: 35.0)
            HomeViewController.numberAya.font =  UIFont.systemFont(ofSize: 21.0, weight: .light)
//
            HomeViewController.numberAya.text =  "آية: " + "\(todayAyaModel.ayaObject!.ayaNumber)".convertToPersianNum()
            
            HomeViewController.ayaName.font = UIFont(name: "GE SS Two", size: 35.0)
            HomeViewController.ayaName.font =  UIFont.systemFont(ofSize: 21.0, weight: .light)
//
            HomeViewController.ayaName.text =  "سورة: " + "\(todayAyaModel.ayaObject!.suraName)"
            
            let paragraphStyleFullNameAya = NSMutableParagraphStyle()
            //line height size
            paragraphStyleFullNameAya.lineSpacing = 10.0
            let attrStringFullNameAya = NSMutableAttributedString(string: todayAyaModel.ayaObject!.aya)

            attrStringFullNameAya.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleFullNameAya,
            range:NSMakeRange(0, attrStringFullNameAya.length))
            self?.labelFullNameAya.attributedText = attrStringFullNameAya
            self?.labelFullNameAya.textAlignment = NSTextAlignment.right
            
            
//            self?.labelFullNameAya.text = todayAyaModel.ayaObject?.aya
            self?.tafsirName.text = "  تفسير:  " + todayAyaModel.ayaObject!.tafsirAuthor
            self?.tafsirDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
          
//            self?.tafsirDescription.textAlignment = .center
//            self?.tafsirDescription.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            self?.tafsirDescription.numberOfLines = 0
            self?.tafsirDescription.font = UIFont(name: "GE SS Two", size: 35.0)
            self?.tafsirDescription.font =  UIFont.systemFont(ofSize: 14.0, weight: .semibold)
//            self?.tafsirDescription.text = todayAyaModel.ayaObject!.tafsir
            let paragraphStyle = NSMutableParagraphStyle()
            //line height size
            paragraphStyle.lineSpacing = 10.0
            let attrString = NSMutableAttributedString(string: todayAyaModel.ayaObject!.tafsir)

            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle,
            range:NSMakeRange(0, attrString.length))
            self?.tafsirDescription.attributedText = attrString
            self?.tafsirDescription.textAlignment = NSTextAlignment.right

        }
    }
    @objc func share(sender:UIView){
        print("sharepressed")
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
    

    @objc func playerDidFinishPlaying(sender: Notification) {
        // Your code here

        HomeViewController.playPauseButton.setImage(UIImage(named: "play_icon"), for: .normal)
        HomeViewController.playPauseButton.imageView?.contentMode = .scaleAspectFit
        HomeViewController.playPauseButton.imageEdgeInsets = UIEdgeInsets(top: 2.0, left: -1.0, bottom: 0, right: 103.0)
      
        HomeViewController.playPauseButton.setTitle("تشغيل", for: .normal)
    }
    
   
        
        
    @objc func playAyaBySpesficReciter(_ sender: Any) {
        
        if isPlaying == true {
            isPlaying = false
            UIApplication.shared.beginReceivingRemoteControlEvents()

            HomeViewController.playPauseButton.setImage(UIImage(named: "pause_icon"), for: .normal)
            HomeViewController.playPauseButton.imageView?.contentMode = .scaleAspectFit
            HomeViewController.playPauseButton.imageEdgeInsets = UIEdgeInsets(top: 2.0, left: -1.0, bottom: 0, right: 103.0)
            HomeViewController.playPauseButton.setTitle("ايقاف", for: .normal)
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
   
                            
                            guard let url = URL.init(string: "http://212.57.192.148/ayat/mp3/\(nameReciter!)/\(KeyAndValue.SURA_NAME[indexAyaname].id)\(self!.appendNumberAya!).mp3") else { return }
                            let playerItem = AVPlayerItem.init(url: url)
                            
                            NotificationCenter.default.addObserver(self!, selector: #selector(self?.playerDidFinishPlaying(sender:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
                            self?.player = AVPlayer.init(playerItem: playerItem)
                            self?.player?.play()

                            break
                        }

                    }

                } else {
                    let reader_Names = Bundle.main.infoDictionary!["reader_values"] as! NSArray
                    let readerObject = reader_Names[0] as? String


                    for indexAyaname in 0..<KeyAndValue.SURA_NAME.count {
                   
                        guard let url = URL.init(string: "http://212.57.192.148/ayat/mp3/\(readerObject!)/\(KeyAndValue.SURA_NAME[indexAyaname].id)\(self!.appendNumberAya!).mp3") else { return }
                        
                        let playerItem = AVPlayerItem.init(url: url)
                        NotificationCenter.default.addObserver(self!, selector: #selector(self?.playerDidFinishPlaying(sender:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
                        self?.player = AVPlayer.init(playerItem: playerItem)
                        self?.player?.play()

                  
                        break
                    }
                }
            }


        } else {
            
           
            isPlaying = true
            HomeViewController.playPauseButton.setImage(UIImage(named: "play_icon"), for: .normal)
            HomeViewController.playPauseButton.imageView?.contentMode = .scaleAspectFit
            HomeViewController.playPauseButton.imageEdgeInsets = UIEdgeInsets(top: 2.0, left: -1.0, bottom: 0, right: 103.0)
            HomeViewController.playPauseButton.setTitle("تشغيل", for: .normal)
            
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
                            guard let url = URL.init(string: "http://212.57.192.148/ayat/mp3/\(nameReciter!)/\(KeyAndValue.SURA_NAME[indexAyaname].id)\(self!.appendNumberAya!).mp3") else { return }
                            let playerItem = AVPlayerItem.init(url: url)

                            self?.player = AVPlayer.init(playerItem: playerItem)
                            self?.player?.pause()

                            
 
                            break
                        }

                    }

                } else {
                    let reader_Names = Bundle.main.infoDictionary!["reader_values"] as! NSArray
                    let readerObject = reader_Names[0] as? String


                    for indexAyaname in 0..<KeyAndValue.SURA_NAME.count {
                   
//                    self!.initPlayer(url: "http://212.57.192.148/ayat/mp3/\(readerObject!)/\(KeyAndValue.SURA_NAME[indexAyaname].id)\(self!.appendNumberAya!).mp3")
                        
                        guard let url = URL.init(string: "http://212.57.192.148/ayat/mp3/\(readerObject!)/\(KeyAndValue.SURA_NAME[indexAyaname].id)\(self!.appendNumberAya!).mp3") else { return }
                        let playerItem = AVPlayerItem.init(url: url)

                        self?.player = AVPlayer.init(playerItem: playerItem)
                        self?.player?.pause()
                        break
                    }
                }
            }


        }
    }
   
    
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
//        heightBanner.constant = 60.0
//        heightBottomBanner.constant = 60.0
//        widthTopBanner.constant = 150.0
//        widthBottomBanner.constant = 150.0
//        self.bannerAdTopView.addSubview(banner)
        bannerAdTopView.heightAnchor.constraint(equalToConstant:  60.0).isActive = true

    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        errorAds = error.localizedDescription
//        heightBanner.constant = 0.0
//        bottomspaceforview.constant = -60.0
//        print("displayhgewlkjhfgekwhkw\(bottomspaceforview.constant)")
//        widthTopBanner.constant = 0.0
//        heightBottomBanner.constant = heightBanner.constant
//        widthBottomBanner.constant = 100.0

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
