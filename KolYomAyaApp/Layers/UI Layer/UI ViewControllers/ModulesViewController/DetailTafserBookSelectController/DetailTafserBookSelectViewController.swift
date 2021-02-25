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
    var ayaNumberSelected: Bool = false
    var pageNumberSelected: Bool = false
    var ayaNameSelected: Bool = false
    var surahIdNumber: Int? = 1
    var ayahNumber: Int?
    /*
      1. ScrollView
      2. dynamic label
      3. static view
      
      . footor section include of :-
     /*
       1.stackView horizontal direction
       2. numberaya  -  nameaya  - pagenumber
     */
     */
    var delgateBook: DelegateDetailTafserBookSelect?
    var viewModelAllSurah: GetAllSurahAyatViewModel?
    var allSurahModel: AllSurahModel?
    
    var numberOfAyaList = ToolbarPickerView()
     var ayaNameList = ToolbarPickerView()
     var pageNumberContent = ToolbarPickerView()
    
    let scrollView = UIScrollView()
       let contentView = UIView()
    static var ayaView: UIView = UIView()
    static var previousPageBtn = UIButton()
    static var nextPageBtn = UIButton()
    
    static var pageNumberTextField = UITextField()
    static var ayaNameTextField = UITextField()
    static var numberAyatTextField = UITextField()
   
    static var pageContentLbl = UILabel()
    static var tafsirContentLbl = UILabel()
    static var titleQuranLbl = UILabel()
    var pageNumber: Int = 1
    var viewModel: DetialTafserBookSelectViewModel?
    var bookByPageNumberModel: TafsirBookPageByPageNumber?
    var suraNumberValue: Int?
    
//    //MARK:- Programmtically autolayout

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //(self.delgateBook?.bookName!)!
        self.initializeNavigationBarAppearanceWithBack(viewController: TafserBookViewController(), titleHeader: (self.delgateBook?.bookName!)!)
    }

    var CounterPageNumber:[Int] = []
    var addNumbersAyatSpesficSuraName:[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.5215686275, blue: 0.4666666667, alpha: 1)
        
        KeyAndValue.getSuraName()
        KeyAndValue.getSuraNumber()
        

        viewModel = DetialTafserBookSelectViewModel()
        viewModelAllSurah = GetAllSurahAyatViewModel()

        DetailTafserBookSelectViewController.pageNumberTextField.text = "1"
        DetailTafserBookSelectViewController.pageNumberTextField.textAlignment = .center
        DetailTafserBookSelectViewController.ayaNameTextField.text = "الفاتحة"
        DetailTafserBookSelectViewController.ayaNameTextField.textAlignment = .center
        DetailTafserBookSelectViewController.numberAyatTextField.text = "1"
        DetailTafserBookSelectViewController.pageNumberTextField.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        DetailTafserBookSelectViewController.numberAyatTextField.textAlignment = .center
        DetailTafserBookSelectViewController.ayaNameTextField.inputView = self.ayaNameList
        DetailTafserBookSelectViewController.ayaNameTextField.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        DetailTafserBookSelectViewController.ayaNameTextField.inputAccessoryView = self.ayaNameList.toolbar
        DetailTafserBookSelectViewController.numberAyatTextField.inputView = self.numberOfAyaList
        DetailTafserBookSelectViewController.numberAyatTextField.inputAccessoryView = self.numberOfAyaList.toolbar
        DetailTafserBookSelectViewController.pageNumberTextField.inputView = self.pageNumberContent
        DetailTafserBookSelectViewController.numberAyatTextField.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        DetailTafserBookSelectViewController.pageNumberTextField.inputAccessoryView = self.pageNumberContent.toolbar
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

                self?.bookByPageNumberModel = bookTafisrBookResult
                if self?.bookByPageNumberModel?.previousPage == nil {
                    DetailTafserBookSelectViewController.previousPageBtn.isHidden = true
                } else {
                    DetailTafserBookSelectViewController.previousPageBtn.isHidden = false
                }
//        : self?.bookByPageNumberModel?.page?.title
        self?.setupViews(tafisr: self?.bookByPageNumberModel?.page?.tafsir ?? "", pageContent: self?.bookByPageNumberModel?.page?.pageContent ?? "", baseTitle: (self?.bookByPageNumberModel?.page?.title ?? "" )!)

                        self?.surahIdNumber =  self?.bookByPageNumberModel?.page?.id

                        self?.bookByPageNumberModel?.page?.surahList?.forEach { surahObject in
                            self?.surahIdNumber = surahObject.id
//                            self?.numberAyat.uniques.app
                            self?.numberAyat.append(contentsOf: (surahObject.ayat)!)
                            surahObject.ayat?.forEach { ayatObjects in
                                self?.ayahNumber = ayatObjects
                            }

                        }
                DetailTafserBookSelectViewController.nextPageBtn.addTarget(self, action: #selector(DetailTafserBookSelectViewController.getNextPagePressed(sender:)), for: .touchUpInside)
                DetailTafserBookSelectViewController.previousPageBtn.addTarget(self, action: #selector(DetailTafserBookSelectViewController.getPreviousPagePressed(sender:)), for: .touchUpInside)
                
                       self?.viewModel?.detailTafserBookBySurahAndAyah(bookId: (self?.delgateBook?.bookId)!, surahId: (self?.surahIdNumber)!, ayah: (self?.ayahNumber)!, completionHandler: { [weak self] (bookTafsirBySurahAndAyah) in
                                          self?.bookByPageNumberModel = bookTafsirBySurahAndAyah
                                          for indexAya in 0..<(self?.bookByPageNumberModel?.page?.surahList!.count)! {
//                                            DetailTafserBookSelectViewController.numberAyatTextField.text = "\(self?.bookByPageNumberModel!.page!.surahList![indexAya].ayat![0])"
//
//                                            self?.numberAyat.append(contentsOf: (self?.bookByPageNumberModel!.page!.surahList![indexAya].ayat!.uniques)!)
//                                              for index in 0..<(self?.bookByPageNumberModel?.page?.surahList?[indexAya].ayat!.count ?? 0) {
//
//                                              }
                                          }
                                      })
        DispatchQueue.main.async {
            self?.ayaNameList.reloadAllComponents()
            self?.numberOfAyaList.reloadAllComponents()
            self?.pageNumberContent.reloadAllComponents()
        }
                       

    })
        viewModelAllSurah?.getAllSurahApi(completionHandler: { [weak self] (resultGetAllSurahModel) in
            self?.allSurahModel = resultGetAllSurahModel
            self?.allSurahModel?.results.forEach {
                surahObject in
                if self?.surahIdNumber == surahObject.id {
                    self?.numberAyat.append(contentsOf: (surahObject.ayat)!)
                }
            }
            DispatchQueue.main.async {
                self?.numberOfAyaList.reloadAllComponents()
                }
        })
        
        let numPages: Int! = delgateBook?.numberOfPages!
               for indexPageNumber in 1..<numPages {
                   CounterPageNumber.append(indexPageNumber)
               }
        setupScrollView()
    }
//        let numPages: Int! = delgateBook?.numberOfPages!
//        for indexPageNumber in 1..<numPages {
//            CounterPageNumber.append(indexPageNumber)
//        }
//
//
//    }
    @objc func getNextPagePressed(sender: UIButton) {
        if pageNumberSelected == false {
            self.pageNumber = Int(DetailTafserBookSelectViewController.pageNumberTextField.text!)! + 1
            DetailTafserBookSelectViewController.pageNumberTextField.text = "\(self.pageNumber)"

        } else {
            self.pageNumber += self.CounterPageNumber[self.counter]  - self.counter
            DetailTafserBookSelectViewController.pageNumberTextField.text = "\(self.pageNumber)"
        }
        self.counter += 1
        self.addNumbersAyatSpesficSuraName.removeAll()
        viewModel?.detailtafserBookSelectApi(pageNumber: self.pageNumber , bookId: (delgateBook?.bookId)!, completionHandler: { [weak self ] (bookTafisrBookResult)  in
            self?.bookByPageNumberModel = bookTafisrBookResult
            if self?.bookByPageNumberModel?.previousPage == nil {
                DetailTafserBookSelectViewController.previousPageBtn.isHidden = true
            } else {
                DetailTafserBookSelectViewController.previousPageBtn.isHidden = false
            }


            if self?.bookByPageNumberModel?.page?.pageNumber == nil {

            } else {
                for index in 0..<(self?.bookByPageNumberModel?.page?.surahList!.count)! {

                    KeyAndValue.SURA_NAME[0].name = self!.bookByPageNumberModel!.page!.surahList![index].name!

                    DetailTafserBookSelectViewController.ayaNameTextField.text = self!.bookByPageNumberModel!.page!.surahList![index].name!
                    DetailTafserBookSelectViewController.numberAyatTextField.text = "\(self!.bookByPageNumberModel!.page!.surahList![index].ayat?[0] ?? 0)"
//                    if self?.numberAyat.count ?? 0 > 0 {
//                        self?.numberAyat.removeAll()
//                    }
//                    self?.numberAyat.append(contentsOf: self!.bookByPageNumberModel!.page!.surahList![index].ayat!.uniques)
                    for indexAya in 0..<KeyAndValue.SURA_NAME.count {
                        self?.suraNumberValue =  Int(KeyAndValue.SURA_NUMBER[indexAya].id)!
                        self?.suraNumberValue = self?.bookByPageNumberModel!.page!.surahList![index].id
                        if self?.suraNumberValue == self?.bookByPageNumberModel!.page!.surahList![index].id {
                            self?.ayahNumber = self?.bookByPageNumberModel!.page!.surahList![index].id
                            self?.surahIdNumber = self?.bookByPageNumberModel?.page?.id
                        } else {
                        print(KeyAndValue.SURA_NUMBER[indexAya].id)
                            self?.ayahNumber = 1
                           self?.surahIdNumber = 1
                        }

                    }

              }
            }

//
//            DetailTafserBookSelectViewController.pageContentLbl.text = self?.bookByPageNumberModel?.nextPage?.pageContent
//            DetailTafserBookSelectViewController.tafsirContentLbl.text = self?.bookByPageNumberModel?.nextPage?.tafsir: self?.bookByPageNumberModel?.page?.title
            self?.setupViews(tafisr: self?.bookByPageNumberModel?.page?.tafsir ?? "", pageContent: self?.bookByPageNumberModel?.page?.pageContent ?? "", baseTitle: (self?.bookByPageNumberModel?.page?.title ?? "" )!)

            self?.viewModel?.detailTafserBookBySurahAndAyah(bookId: (self?.delgateBook?.bookId)!, surahId: (self?.surahIdNumber)!, ayah: (self?.ayahNumber)!, completionHandler: { [weak self] (bookTafsirBySurahAndAyah) in
                self?.bookByPageNumberModel = bookTafsirBySurahAndAyah

                for indexAya in 0..<(self?.bookByPageNumberModel?.page?.surahList!.count ?? 0) {

                    for index in 0..<(self?.bookByPageNumberModel?.page?.surahList?[indexAya].ayat!.count ?? 0) {
                        self?.addNumbersAyatSpesficSuraName.append((self?.bookByPageNumberModel?.page?.surahList?[indexAya].ayat?[index])!)

                    }
                }
            })
            DispatchQueue.main.async {
                self?.ayaNameList.reloadAllComponents()
//                self?.numberOfAyaList.reloadAllComponents()
                self?.pageNumberContent.reloadAllComponents()
            }
       
        })
        viewModelAllSurah?.getAllSurahApi(completionHandler: { [weak self] (resultGetAllSurahModel) in
            self?.allSurahModel = resultGetAllSurahModel
            self?.allSurahModel?.results.forEach {
                
                surahObject in
                print("surahId\(surahObject.id)")
                if self?.surahIdNumber == surahObject.id {
                    self?.numberAyat.append(contentsOf: (surahObject.ayat)!)
                    print("surahObject.ayat\(surahObject.ayat)")
                }
            }
            DispatchQueue.main.async {
                self?.numberOfAyaList.reloadAllComponents()
                }
        })

    }

    @objc func getPreviousPagePressed(sender: UIButton) {
        if pageNumberSelected == false {
            self.pageNumber = Int(DetailTafserBookSelectViewController.pageNumberTextField.text!)! - 1
            print("self.pageNumber\(self.pageNumber)")
            DetailTafserBookSelectViewController.pageNumberTextField.text = "\(self.pageNumber)"

             } else {
                 self.pageNumber -= self.CounterPageNumber[self.counter]  + self.counter
                DetailTafserBookSelectViewController.pageNumberTextField.text = "\(self.pageNumber)"

             }
        self.counter -= 1
//        self.addNumbersAyatSpesficSuraName.removeAll()
        viewModel?.detailtafserBookSelectApi(pageNumber: self.pageNumber, bookId: (delgateBook?.bookId)!, completionHandler: { [weak self ] (bookTafisrBookResult)  in
            self?.bookByPageNumberModel = bookTafisrBookResult
            if self?.bookByPageNumberModel?.previousPage == nil {
                print("previousPageNotEmpty")
                DetailTafserBookSelectViewController.previousPageBtn.isHidden = true
            } else {
                print("previousempty")
                DetailTafserBookSelectViewController.previousPageBtn.isHidden = false
            }
            DetailTafserBookSelectViewController.pageContentLbl.text = self?.bookByPageNumberModel?.page?.pageContent
            DetailTafserBookSelectViewController.tafsirContentLbl.text = self?.bookByPageNumberModel?.page?.tafsir
            self?.surahIdNumber =  self?.bookByPageNumberModel?.page?.id
              for index in 0..<(self?.bookByPageNumberModel?.page?.surahList!.count ?? 0) {

                KeyAndValue.SURA_NAME[0].name = self!.bookByPageNumberModel!.page!.surahList![index].name!
               
                DetailTafserBookSelectViewController.numberAyatTextField.text = "\(self!.bookByPageNumberModel!.page!.surahList![index].ayat?[0] ?? 0)"
//                if self?.numberAyat.count ?? 0 > 0 {
//                    self?.numberAyat.removeAll()
//                }
//                self?.numberAyat.append(contentsOf: self!.bookByPageNumberModel!.page!.surahList![index].ayat!.uniques)
                DetailTafserBookSelectViewController.ayaNameTextField.text = self!.bookByPageNumberModel!.page!.surahList![index].name!
                    for indexAya in 0..<KeyAndValue.SURA_NAME.count {
                     self?.suraNumberValue =  Int(KeyAndValue.SURA_NUMBER[indexAya].id)!
                     self?.suraNumberValue = self?.bookByPageNumberModel!.page!.surahList![index].id
                     if self?.suraNumberValue == self?.bookByPageNumberModel!.page!.surahList![index].id {
                   self?.ayahNumber = self?.bookByPageNumberModel!.page!.surahList![index].id
                   self?.surahIdNumber = self?.bookByPageNumberModel?.page?.id
             
               } else {
               print(KeyAndValue.SURA_NUMBER[indexAya].id)
                   self?.ayahNumber = 1
                  self?.surahIdNumber = 1
               }

                           }
//                   for indexAya in 0..<(self?.bookByPageNumberModel?.page?.surahList!.count ?? 0) {
//
//                      for index in 0..<(self?.bookByPageNumberModel?.page?.surahList?[indexAya].ayat!.count)! {
//                        self?.addNumbersAyatSpesficSuraName.append((self?.bookByPageNumberModel?.page?.surahList?[indexAya].ayat?[index])!)
//
//                      }
//                  }
                 }

            DispatchQueue.main.async {
                self?.ayaNameList.reloadAllComponents()
//                self?.numberOfAyaList.reloadAllComponents()
                self?.pageNumberContent.reloadAllComponents()
            }
        })
        viewModelAllSurah?.getAllSurahApi(completionHandler: { [weak self] (resultGetAllSurahModel) in
            self?.allSurahModel = resultGetAllSurahModel
            self?.allSurahModel?.results.forEach {
                
                surahObject in
                print("surahId\(surahObject.id)")
                if self?.surahIdNumber == surahObject.id {
                    self?.numberAyat.append(contentsOf: (surahObject.ayat)!)
                    print("surahObject.ayat\(surahObject.ayat)")
                }
            }
            DispatchQueue.main.async {
                self?.numberOfAyaList.reloadAllComponents()
                }
        })
//        setupScrollView()

    }
    func roundCornerMask(with CACornerMask: CACornerMask, radius: CGFloat) {
        DetailTafserBookSelectViewController.ayaView.layer.cornerRadius = radius
        DetailTafserBookSelectViewController.ayaView.layer.maskedCorners = [CACornerMask]
    }
    func setupScrollView(){
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
       
    func setupViews(tafisr: String, pageContent: String, baseTitle: String){
     
        
        labelTitle.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        labelTitle.font = UIFont(name: "barselona", size: 40)
        labelTitle.text = baseTitle
        contentView.addSubview(labelTitle)
        labelTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        labelTitle.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        labelTitle.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.95).isActive = true
       //MARK:- PageContent
       label1.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
       label1.font = UIFont(name: "barselona", size: 40)
       label1.text = pageContent
       contentView.addSubview(label1)
       label1.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
       label1.topAnchor.constraint(equalTo: labelTitle.bottomAnchor).isActive = true
       label1.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.95).isActive = true
       //Mark:- will add view contain tafisr
        DetailTafserBookSelectViewController.ayaView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(DetailTafserBookSelectViewController.ayaView)
        DetailTafserBookSelectViewController.ayaView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        DetailTafserBookSelectViewController.ayaView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        DetailTafserBookSelectViewController.ayaView.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 10.0).isActive = true
        DetailTafserBookSelectViewController.ayaView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        DetailTafserBookSelectViewController.ayaView.layer.cornerRadius = 25
        DetailTafserBookSelectViewController.ayaView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        DetailTafserBookSelectViewController.ayaView.addSubview(label2)
        label2.font = UIFont(name: "gs_ss_two_light", size: 25)
        //MARK:- tafsir
        label2.text = tafisr
        contentView.addSubview(label2)
        label2.centerXAnchor.constraint(equalTo:  DetailTafserBookSelectViewController.ayaView.centerXAnchor).isActive = true
        label2.topAnchor.constraint(equalTo:  DetailTafserBookSelectViewController.ayaView.topAnchor, constant: 15.0).isActive = true
       
        label2.widthAnchor.constraint(equalTo:  DetailTafserBookSelectViewController.ayaView.widthAnchor, multiplier: 1.0).isActive = true
        label2.bottomAnchor.constraint(equalTo:  DetailTafserBookSelectViewController.ayaView.bottomAnchor, constant: 0).isActive = true

        
        label2.trailingAnchor.constraint(equalTo: DetailTafserBookSelectViewController.ayaView.trailingAnchor, constant: 4.0).isActive = true
//        label2.leadingAnchor.constraint(equalTo: DetailTafserBookSelectViewController.ayaView.leadingAnchor, constant: 5.0).isActive = true
        contentView.addSubview(stackViewButton)
        stackViewButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        stackViewButton.topAnchor.constraint(equalTo: DetailTafserBookSelectViewController.ayaView.bottomAnchor, constant: 15).isActive = true
        stackViewButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.90).isActive = true
//        stackViewButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        contentView.addSubview(stackViewTextField)
        stackViewTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        stackViewTextField.topAnchor.constraint(equalTo: stackViewButton.bottomAnchor, constant: 15).isActive = true
        stackViewTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.95).isActive = true
        stackViewTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        stackViewTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
       }
 

       let label1: UILabel = {

        DetailTafserBookSelectViewController.pageContentLbl.numberOfLines = 0
        DetailTafserBookSelectViewController.pageContentLbl.textAlignment = .natural
        DetailTafserBookSelectViewController.pageContentLbl.sizeToFit()
        DetailTafserBookSelectViewController.pageContentLbl.textColor = UIColor.black
        DetailTafserBookSelectViewController.pageContentLbl.translatesAutoresizingMaskIntoConstraints = false
           return DetailTafserBookSelectViewController.pageContentLbl
       }()
     
    let labelTitle: UILabel = {
        DetailTafserBookSelectViewController.titleQuranLbl.text = ""
        DetailTafserBookSelectViewController.titleQuranLbl.textAlignment = .center
        DetailTafserBookSelectViewController.titleQuranLbl.numberOfLines = 0
        DetailTafserBookSelectViewController.titleQuranLbl.sizeToFit()
        DetailTafserBookSelectViewController.titleQuranLbl.textColor = UIColor.black
        DetailTafserBookSelectViewController.titleQuranLbl.translatesAutoresizingMaskIntoConstraints = false
        return DetailTafserBookSelectViewController.titleQuranLbl
    }()
       
       let label2: UILabel = {
        DetailTafserBookSelectViewController.tafsirContentLbl.numberOfLines = 0
        DetailTafserBookSelectViewController.tafsirContentLbl.sizeToFit()
        DetailTafserBookSelectViewController.tafsirContentLbl.textColor = UIColor.black
        DetailTafserBookSelectViewController.tafsirContentLbl.translatesAutoresizingMaskIntoConstraints = false
           return DetailTafserBookSelectViewController.tafsirContentLbl
       }()
    
    let stackViewButton: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill // .Leading .FirstBaseline .Center .Trailing .LastBaseline
        stackView.distribution = .fillEqually // .FillEqually .FillProportionally .EqualSpacing .EqualCentering
        
        stackView.spacing = 8.0
        
        DetailTafserBookSelectViewController.previousPageBtn.setTitle("السابق", for: .normal)
        DetailTafserBookSelectViewController.previousPageBtn.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.5215686275, blue: 0.4666666667, alpha: 1)
//            UIColor(displayP3Red: 33, green: 133, blue: 119, alpha: 1.0)
        
        DetailTafserBookSelectViewController.previousPageBtn.translatesAutoresizingMaskIntoConstraints = false
        

//
//        let nextPageBtn = UIButton()
        DetailTafserBookSelectViewController.nextPageBtn.setTitle("التالي", for: .normal)
        DetailTafserBookSelectViewController.nextPageBtn.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.5215686275, blue: 0.4666666667, alpha: 1)
//            UIColor(displayP3Red: 33, green: 133, blue: 119, alpha: 1.0)
        DetailTafserBookSelectViewController.nextPageBtn.translatesAutoresizingMaskIntoConstraints = false
//        let label = UILabel()
//        label.text = "feffndkjdh"
//        label.numberOfLines = 0
//        label.sizeToFit()
//        label.textColor = UIColor.black
//        nextPageBtn.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(previousPageBtn)
        stackView.addArrangedSubview(nextPageBtn)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    
    let stackViewTextField: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill // .Leading .FirstBaseline .Center .Trailing .LastBaseline
        stackView.distribution = .fillEqually // .FillEqually .FillProportionally .EqualSpacing .EqualCentering
        
        stackView.spacing = 8.0
        

        
        DetailTafserBookSelectViewController.numberAyatTextField.translatesAutoresizingMaskIntoConstraints = false
        
        DetailTafserBookSelectViewController.ayaNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        DetailTafserBookSelectViewController.pageNumberTextField.translatesAutoresizingMaskIntoConstraints = false
       
        stackView.addArrangedSubview(DetailTafserBookSelectViewController.pageNumberTextField)
        stackView.addArrangedSubview(DetailTafserBookSelectViewController.ayaNameTextField)
        stackView.addArrangedSubview(DetailTafserBookSelectViewController.numberAyatTextField)

        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
//    let previousPageBtn: UIButton = {
//        let previousButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
//
////        label.numberOfLines = 0
////        label.sizeToFit()
////        label.textColor = UIColor.black
//        previousButton.translatesAutoresizingMaskIntoConstraints = false
//        return previousButton
//    }()
    
}

