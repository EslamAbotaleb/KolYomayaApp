//
//  QuarnReadViewController.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/28/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit
import Toast_Swift
class QuarnReadViewController: BaseViewController {

    @IBOutlet weak var suraImage: UIImageView!
    @IBOutlet weak var viewPickerView: UIView!
    var viewModel: QuraanReadViewModel?
    var quraanReadModel: QuraanPageModel?
    var surahIdNumber: Int?
    var ayahNumber: Int?
    var pageNumber: Int = 1
    var numberAyat: [Int] = [Int]()
    var CounterPageNumber:[Int] = []
    var numberRowAya: Int = 0
    var contentpageNumber: Int = 0
    var counter = 1
    var itemISSelect: Bool = false
    var ayaNumberSelected: Bool = false
    var pageNumberSelected: Bool = false
    var viewIsSelected: Bool = false
    
    @IBOutlet weak var ayaNameTextField: UITextField!
    @IBOutlet weak var pageNumberTextField: UITextField!
    @IBOutlet weak var numberAyatTextField: UITextField!
    @IBOutlet weak var heightView: NSLayoutConstraint!
    var numberOfAyaList = ToolbarPickerView()
    var ayaNameList = ToolbarPickerView()
    var pageNumberContent = ToolbarPickerView()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initializeNavigationBarAppearanceWithBack(viewController: HomeViewController(), titleHeader: "القرآن الكريم (قراءة)", buttonIsHidden: false)
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = QuraanReadViewModel()
        KeyAndValue.getSura_Name()
        KeyAndValue.getSura_Number()
        
        
        self.ayaNameTextField.inputView = self.ayaNameList
        self.ayaNameTextField.inputAccessoryView = self.ayaNameList.toolbar
        self.numberAyatTextField.inputView = self.numberOfAyaList
        self.numberAyatTextField.inputAccessoryView = self.numberOfAyaList.toolbar
        self.pageNumberTextField.inputView = self.pageNumberContent
        self.pageNumberTextField.inputAccessoryView = self.pageNumberContent.toolbar
        ayaNameList.delegate = self
        ayaNameList.dataSource = self
        ayaNameList.toolbarDelegate = self
        numberOfAyaList.delegate = self
        numberOfAyaList.dataSource = self
        numberOfAyaList.toolbarDelegate = self
        pageNumberContent.delegate = self
        pageNumberContent.dataSource = self
        pageNumberContent.toolbarDelegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
        viewModel?.surahAyaByPageNumberApi(pageNumber: pageNumber, completionHandler: { (resultQuraanPageModel) in
            self.quraanReadModel = resultQuraanPageModel
            
            self.suraImage.imageFromURL(urlString: (self.quraanReadModel?.quraanPage?.image)!)
            self.quraanReadModel?.quraanPage?.surahList?.forEach { surahObject in
                self.surahIdNumber = surahObject.id
                //                            self?.numberAyat.uniques.app
                self.numberAyat.append(contentsOf: (surahObject.ayat)!)
                
                surahObject.ayat?.forEach { ayatObjects in
                    self.ayahNumber = ayatObjects
                }
                
            }
            
            DispatchQueue.main.async {
                self.ayaNameList.reloadAllComponents()
                self.pageNumberContent.reloadAllComponents()
                self.numberOfAyaList.reloadAllComponents()

            }
        })
        for indexPageNumber in 1..<665 {
                   CounterPageNumber.append(indexPageNumber)
               }
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRightGesture.direction = UISwipeGestureRecognizer.Direction.right
        swipeLeftGesture.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeRightGesture)
        self.view.addGestureRecognizer(swipeLeftGesture)

    }
  
    @objc func handleTap(_ gesture: UISwipeGestureRecognizer) {
        
       
        if viewIsSelected == false {
            viewIsSelected = true
            self.viewPickerView.isHidden = true
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            self.heightView.constant = 0.0
        } else {
            viewIsSelected = false
            self.viewPickerView.isHidden = false
            self.navigationController?.navigationBar.isHidden = false
//            self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
            self.heightView.constant = 100.0


        }
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {

        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            //MARK:- will increase pageNumber by 1
            if pageNumberSelected == false {
                            self.pageNumber = Int(self.pageNumberTextField.text!)! + 1
                print("vmrlijvriljhrihvierr\(Int(self.pageNumberTextField.text!)!)")
                           self.pageNumberTextField.text = "\(self.pageNumber)"
                       } else {
                           self.pageNumber += self.CounterPageNumber[self.counter ]  - self.counter
                           self.pageNumberTextField.text = "\(self.pageNumber)"
                       }
                       self.counter += 1
            viewModel?.surahAyaByPageNumberApi(pageNumber: self.pageNumber, completionHandler: { (resultQuraanPageModel) in
                self.quraanReadModel = resultQuraanPageModel
                
                if resultQuraanPageModel.previousPage == nil {
                    self.suraImage.imageFromURL(urlString: (resultQuraanPageModel.quraanPage?.image)!)
                    
                } else {
                    self.suraImage.imageFromURL(urlString: (resultQuraanPageModel.quraanPage?.image)!)
                }
                for index in 0..<(self.quraanReadModel?.quraanPage?.surahList!.count)! {
                    KeyAndValue.SURA_NAME[0].name = self.quraanReadModel!.quraanPage!.surahList![index].name!
                    
                    self.ayaNameTextField.text = self.quraanReadModel!.quraanPage!.surahList![index].name!
                    print("femwngwhekuhekughewgrweg\(self.quraanReadModel!.quraanPage!.surahList![index])")
                    self.numberAyatTextField.text = "\(self.quraanReadModel!.quraanPage!.surahList![index].ayat![0])"
                }
                DispatchQueue.main.async {
                    self.ayaNameList.reloadAllComponents()
                    self.pageNumberContent.reloadAllComponents()
                    self.numberOfAyaList.reloadAllComponents()

                          }
            })
        } else if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            //MARK:- will decrease pageNumber by 1
            if pageNumberSelected == false {
                        self.pageNumber = Int(self.pageNumberTextField.text!)! - 1
                       self.pageNumberTextField.text = "\(self.pageNumber)"

                   } else {
                       self.pageNumber -= self.CounterPageNumber[self.counter]  + self.counter
                       self.pageNumberTextField.text = "\(self.pageNumber)"

                   }
              self.counter -= 1
            viewModel?.surahAyaByPageNumberApi(pageNumber: self.pageNumber, completionHandler: { (resultQuraanPageModel) in
                self.quraanReadModel = resultQuraanPageModel
                if resultQuraanPageModel.previousPage == nil {
                    if resultQuraanPageModel.quraanPage?.image == nil {
                        print("Not there image swipe as right")
                    }
                    self.suraImage.imageFromURL(urlString: (resultQuraanPageModel.quraanPage?.image)!)
                    
                } else {
                    self.suraImage.imageFromURL(urlString: (resultQuraanPageModel.quraanPage?.image)!)
                    
                }
                for index in 0..<(self.quraanReadModel?.quraanPage?.surahList!.count)! {
                               KeyAndValue.SURA_NAME[0].name = self.quraanReadModel!.quraanPage!.surahList![index].name!
                    
                    self.ayaNameTextField.text = self.quraanReadModel!.quraanPage!.surahList![index].name!
                    self.numberAyatTextField.text = "\(self.quraanReadModel!.quraanPage!.surahList![index].ayat![0])"

                           }
                DispatchQueue.main.async {
                              self.ayaNameList.reloadAllComponents()
                              self.pageNumberContent.reloadAllComponents()
                              self.numberOfAyaList.reloadAllComponents()

                          }
            })
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

}
