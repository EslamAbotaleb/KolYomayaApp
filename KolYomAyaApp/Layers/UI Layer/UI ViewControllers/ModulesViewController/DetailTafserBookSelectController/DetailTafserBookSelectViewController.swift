//
//  DetailTafserBookSelectViewController.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/24/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit

class DetailTafserBookSelectViewController: BaseViewController {
    var numberAyat: [Int] = [Int]()
    var numberRowAya: Int = 0
    var contentpageNumber: Int = 0
    var dataIsChanged: Bool = false
    var counter = 1
    var itemISSelect: Bool = false
    var pageNum: Int = 0
    var pageNumberSelected: Bool = false
    @IBOutlet weak var ayaView: UIView!
    @IBOutlet weak var numberAyatTextField: UITextField!
    var delgateBook: DelegateDetailTafserBookSelect?
    //    @IBOutlet weak var tafsirContentLbl: UITextView!
    @IBOutlet weak var tafsirContentLbl: UILabel!
    //    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageContentLbl: UILabel!
    @IBOutlet weak var previousPageBtn: UIButton!
    @IBOutlet weak var nextPageBtn: UIButton!
    var numberOfAyaList = ToolbarPickerView()
    var ayaNameList = ToolbarPickerView()
    var pageNumberContent = ToolbarPickerView()
    @IBOutlet weak var ayaNameTextField: UITextField!
    
    @IBOutlet weak var pageNumberTextField: UITextField!
    var pageNumber: Int = 1
    var surahIdNumber: Int?
    var ayahNumber: Int?
    var viewModel: DetialTafserBookSelectViewModel?
    var bookByPageNumberModel: TafsirBookPageByPageNumber?
    var suraNumberValue: Int?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initializeNavigationBarAppearanceWithBack(viewController: TafserBookViewController(), titleHeader: (self.delgateBook?.bookName!)!)
    }
    override func viewDidAppear(_ animated: Bool) {
        
        //        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height )
        //        UIScreen.main.bounds.height- 140s
        //        +300
        
    }
    var CounterPageNumber:[Int] = []
    var addNumbersAyatSpesficSuraName:[Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        KeyAndValue.getSura_Name()
        KeyAndValue.getSura_Number()
        ayaView.roundCorners([.topLeft, .bottomRight], radius: 20.0)
        viewModel = DetialTafserBookSelectViewModel()
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
        
        
        viewModel?.detailtafserBookSelectApi(pageNumber: pageNumber, bookId: (delgateBook?.bookId)!, completionHandler: {
            [weak self ] (bookTafisrBookResult)  in
            
            print("pageNumberpageNumberpageNumberpageNumber\(self!.pageNumber)")
            self?.bookByPageNumberModel = bookTafisrBookResult
            if self?.bookByPageNumberModel?.previousPage == nil {
                self?.previousPageBtn.isHidden = true
            } else {
                self?.previousPageBtn.isHidden = false
            }
            self?.pageContentLbl.text = self?.bookByPageNumberModel?.page?.pageContent
            self?.tafsirContentLbl.text = self?.bookByPageNumberModel?.page?.tafsir
            self?.surahIdNumber =  self?.bookByPageNumberModel?.page?.id
            
            self?.bookByPageNumberModel?.page?.surahList?.forEach { surahObject in
                self?.surahIdNumber = surahObject.id
                //                            self?.numberAyat.uniques.app
                self?.numberAyat.append(contentsOf: (surahObject.ayat)!)
                
                surahObject.ayat?.forEach { ayatObjects in
                    self?.ayahNumber = ayatObjects
                }
                
            }
            self?.nextPageBtn.addTarget(self, action: #selector(DetailTafserBookSelectViewController.getNextPagePressed(sender:)), for: .touchUpInside)
            self?.previousPageBtn.addTarget(self, action: #selector(DetailTafserBookSelectViewController.getPreviousPagePressed(sender:)), for: .touchUpInside)
            self?.viewModel?.detailTafserBookBySurahAndAyah(bookId: (self?.delgateBook?.bookId)!, surahId: (self?.surahIdNumber)!, ayah: (self?.ayahNumber)!, completionHandler: { [weak self] (bookTafsirBySurahAndAyah) in
                self?.bookByPageNumberModel = bookTafsirBySurahAndAyah
                for indexAya in 0..<(self?.bookByPageNumberModel?.page?.surahList!.count)! {
                    
                    for index in 0..<(self?.bookByPageNumberModel?.page?.surahList?[indexAya].ayat!.count)! {
                        
                        
                    }
                }
            })
            self?.ayaNameList.reloadAllComponents()
            self?.numberOfAyaList.reloadAllComponents()
            self?.pageNumberContent.reloadAllComponents()
            
        })
        let numPages: Int! = delgateBook?.numberOfPages!
        for indexPageNumber in 1..<numPages {
            CounterPageNumber.append(indexPageNumber)
        }
        
        
    }
    @objc func getNextPagePressed(sender: UIButton) {
        if pageNumberSelected == false {
            self.pageNumber = Int(self.pageNumberTextField.text!)! + 1
            self.pageNumberTextField.text = "\(self.pageNumber)"
            
        } else {
            self.pageNumber += self.CounterPageNumber[self.counter]  - self.counter
            self.pageNumberTextField.text = "\(self.pageNumber)"
            
        }
        self.counter += 1
        self.addNumbersAyatSpesficSuraName.removeAll()
        viewModel?.detailtafserBookSelectApi(pageNumber: self.pageNumber , bookId: (delgateBook?.bookId)!, completionHandler: { [weak self ] (bookTafisrBookResult)  in
            self?.bookByPageNumberModel = bookTafisrBookResult
            if self?.bookByPageNumberModel?.previousPage == nil {
                self?.previousPageBtn.isHidden = true
            } else {
                self?.previousPageBtn.isHidden = false
            }
            
            
            if self?.bookByPageNumberModel?.page?.pageNumber == nil {
                
            } else {
                for index in 0..<(self?.bookByPageNumberModel?.page?.surahList!.count)! {
                    
                    KeyAndValue.SURA_NAME[0].name = self!.bookByPageNumberModel!.page!.surahList![index].name!
                    
                    self?.ayaNameTextField.text = self!.bookByPageNumberModel!.page!.surahList![index].name!
                    
                    for indexAya in 0..<KeyAndValue.SURA_NAME.count {
                        self?.suraNumberValue =  Int(KeyAndValue.SURA_NUMBER[indexAya].id)!
                        self?.suraNumberValue = self?.bookByPageNumberModel!.page!.surahList![index].id
                        if self?.suraNumberValue == self?.bookByPageNumberModel!.page!.surahList![index].id {
                            print("Id Sura Is Identical")
                            
                            self?.ayahNumber = self?.bookByPageNumberModel!.page!.surahList![index].id
                            self?.surahIdNumber = self?.bookByPageNumberModel?.page?.id
                        } else {
                            print(KeyAndValue.SURA_NUMBER[indexAya].id)
                            print("Not Identical")
                            self?.ayahNumber = 1
                            self?.surahIdNumber = 1
                        }
                        
                    }
                    
                }
            }
            
            
            self?.pageContentLbl.text = self?.bookByPageNumberModel?.nextPage?.pageContent
            self?.tafsirContentLbl.text = self?.bookByPageNumberModel?.nextPage?.tafsir
            self?.viewModel?.detailTafserBookBySurahAndAyah(bookId: (self?.delgateBook?.bookId)!, surahId: (self?.surahIdNumber)!, ayah: (self?.ayahNumber)!, completionHandler: { [weak self] (bookTafsirBySurahAndAyah) in
                self?.bookByPageNumberModel = bookTafsirBySurahAndAyah
                
                for indexAya in 0..<(self?.bookByPageNumberModel?.page?.surahList!.count)! {
                    
                    for index in 0..<(self?.bookByPageNumberModel?.page?.surahList?[indexAya].ayat!.count)! {
                        self?.addNumbersAyatSpesficSuraName.append((self?.bookByPageNumberModel?.page?.surahList?[indexAya].ayat?[index])!)
                        
                    }
                }
            })
            self?.ayaNameList.reloadAllComponents()
            self?.numberOfAyaList.reloadAllComponents()
            self?.pageNumberContent.reloadAllComponents()
        })
        
        
    }
    
    @objc func getPreviousPagePressed(sender: UIButton) {
        if pageNumberSelected == false {
            self.pageNumber = Int(self.pageNumberTextField.text!)! - 1
            self.pageNumberTextField.text = "\(self.pageNumber)"
            
        } else {
            self.pageNumber -= self.CounterPageNumber[self.counter]  + self.counter
            self.pageNumberTextField.text = "\(self.pageNumber)"
            
        }
        self.counter -= 1
        self.addNumbersAyatSpesficSuraName.removeAll()
        viewModel?.detailtafserBookSelectApi(pageNumber: self.pageNumber, bookId: (delgateBook?.bookId)!, completionHandler: { [weak self ] (bookTafisrBookResult)  in
            self?.bookByPageNumberModel = bookTafisrBookResult
            if self?.bookByPageNumberModel?.previousPage == nil {
                self?.previousPageBtn.isHidden = true
                self?.pageContentLbl.text = self?.bookByPageNumberModel?.page?.pageContent
                self?.tafsirContentLbl.text = self?.bookByPageNumberModel?.page?.tafsir
            } else {
                self?.previousPageBtn.isHidden = false
                self?.pageContentLbl.text = self?.bookByPageNumberModel?.previousPage?.pageContent
                self?.tafsirContentLbl.text = self?.bookByPageNumberModel?.previousPage?.tafsir
            }
            self?.surahIdNumber =  self?.bookByPageNumberModel?.page?.id
            for index in 0..<(self?.bookByPageNumberModel?.page?.surahList!.count)! {
                
                KeyAndValue.SURA_NAME[0].name = self!.bookByPageNumberModel!.page!.surahList![index].name!
                
                self?.ayaNameTextField.text = self!.bookByPageNumberModel!.page!.surahList![index].name!
                for indexAya in 0..<KeyAndValue.SURA_NAME.count {
                    self?.suraNumberValue =  Int(KeyAndValue.SURA_NUMBER[indexAya].id)!
                    self?.suraNumberValue = self?.bookByPageNumberModel!.page!.surahList![index].id
                    if self?.suraNumberValue == self?.bookByPageNumberModel!.page!.surahList![index].id {
                        print("Id Sura Is Identical")
                        self?.ayahNumber = self?.bookByPageNumberModel!.page!.surahList![index].id
                        self?.surahIdNumber = self?.bookByPageNumberModel?.page?.id
                    } else {
                        print(KeyAndValue.SURA_NUMBER[indexAya].id)
                        print("Not Identical")
                        self?.ayahNumber = 1
                        self?.surahIdNumber = 1
                    }
                    
                }
                for indexAya in 0..<(self?.bookByPageNumberModel?.page?.surahList!.count)! {
                    
                    for index in 0..<(self?.bookByPageNumberModel?.page?.surahList?[indexAya].ayat!.count)! {
                        self?.addNumbersAyatSpesficSuraName.append((self?.bookByPageNumberModel?.page?.surahList?[indexAya].ayat?[index])!)
                        
                    }
                }
            }
            
            self?.ayaNameList.reloadAllComponents()
            self?.numberOfAyaList.reloadAllComponents()
            self?.pageNumberContent.reloadAllComponents()
        })
    }
    
}

