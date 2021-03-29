//
//  DetailTafserBook + Pickerview.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 8/9/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit
extension DetailTafserBookSelectViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == ayaNameList {
            return 1
        } else if pickerView == numberOfAyaList {
            return 1
        } else if pickerView == pageNumberContent {
            return 1
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == ayaNameList {

                return KeyAndValue.SURA_NAME.count

        } else if pickerView == numberOfAyaList {
            

            return self.numberAyat.uniques.count
        } else if pickerView == pageNumberContent {
            return CounterPageNumber.count

            
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == ayaNameList {
   
                return KeyAndValue.SURA_NAME[row].name

           
        } else if pickerView == numberOfAyaList {
                
            return "\(self.numberAyat.uniques[row])"

        } else if pickerView == pageNumberContent {
                return "\(self.CounterPageNumber[row])"
                   
        } else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if pickerView == ayaNameList {
            pageNumberSelected = false
              ayaNameSelected = true
            ayaNumberSelected = false
            DetailTafserBookSelectViewController.ayaNameTextField.text = KeyAndValue.SURA_NAME[row].name
            
        } else if pickerView == pageNumberContent {
            self.pageNumber = row
            pageNumberSelected = true
          ayaNumberSelected = false
          ayaNameSelected = false
//            DetailTafserBookSelectViewController.pageNumberTextField.text = nil
  
            DetailTafserBookSelectViewController.pageNumberTextField.text = "\(self.CounterPageNumber[row])"
            
        } else if pickerView == numberOfAyaList {
            numberRowAya = row + 1
              pageNumberSelected = false
              ayaNameSelected = false
              ayaNumberSelected = true
            DetailTafserBookSelectViewController.numberAyatTextField.text = "\(self.numberAyat.uniques[numberRowAya])"

        }
    }
}
     

extension DetailTafserBookSelectViewController: ToolbarPickerViewDelegate {

    func didTapDone() {
        let row = self.ayaNameList.selectedRow(inComponent: 0)
        let rowNumberAyat = self.numberOfAyaList.selectedRow(inComponent: 0)
        let rowPageNumber = self.pageNumberContent.selectedRow(inComponent: 0)
        self.ayaNameList.selectRow(row, inComponent: 0, animated: false)
        self.numberOfAyaList.selectRow(rowNumberAyat, inComponent: 0, animated: false)
        self.pageNumberContent.selectRow(rowPageNumber, inComponent: 0, animated: false)
        DetailTafserBookSelectViewController.ayaNameTextField.text = KeyAndValue.SURA_NAME[row].name
        DetailTafserBookSelectViewController.numberAyatTextField.resignFirstResponder()
        DetailTafserBookSelectViewController.ayaNameTextField.resignFirstResponder()
        DetailTafserBookSelectViewController.pageNumberTextField.resignFirstResponder()
//        if row == 0 {
//            self.surahIdNumber = 1
//            self.ayahNumber = 1
//        } else {
//            self.surahIdNumber = row + 1
//        }
        
//        self.numberRowAya = self.numberAyat[rowNumberAyat]
       
//        if pageNumberSelected ==  false {
//            DetailTafserBookSelectViewController.numberAyatTextField.text = "\(self.numberRowAya)"
//        }
//        self.viewModel?.detailTafserBookBySurahAndAyah(bookId: (self.delgateBook?.bookId)!, surahId: (self.surahIdNumber)!, ayah: self.numberAyat[rowNumberAyat], completionHandler: { [weak self] (bookTafsirBySurahAndAyah) in
//            self?.bookByPageNumberModel = bookTafsirBySurahAndAyah
//            if self?.pageNumberSelected ==  false {
//                       if let pageNum = self?.bookByPageNumberModel?.page?.pageNumber {
//                        DetailTafserBookSelectViewController.pageNumberTextField.text  = "\(pageNum)"
//                                 }
//
//            }
//
//                    if self?.bookByPageNumberModel?.previousPage == nil {
//                        DetailTafserBookSelectViewController.previousPageBtn.isHidden = true
//                    } else {
//                        DetailTafserBookSelectViewController.previousPageBtn.isHidden = false
//            }
//            DetailTafserBookSelectViewController.pageContentLbl.text = self?.bookByPageNumberModel?.page?.pageContent
//            DetailTafserBookSelectViewController.tafsirContentLbl.text = self?.bookByPageNumberModel?.page?.tafsir
//
//            for indexAya in 0..<(self?.bookByPageNumberModel?.page?.surahList!.count ?? 0) {
//                self?.surahIdNumber = self?.bookByPageNumberModel?.page?.surahList?[indexAya].id
//                self?.numberAyat.append(contentsOf: (self?.bookByPageNumberModel?.page?.surahList?[indexAya].ayat?.uniques)!)
//            }
//            self?.ayaNameList.reloadAllComponents()
//            self?.numberOfAyaList.reloadAllComponents()
//            self?.pageNumberContent.reloadAllComponents()
//        })
//        self.pageNumber = CounterPageNumber[rowPageNumber]

        if pageNumberSelected == true {
            ayaNameSelected = false
            ayaNumberSelected = false
            self.pageNumber = CounterPageNumber[rowPageNumber]
                    self.viewModel?.detailtafserBookSelectApi(pageNumber: CounterPageNumber[rowPageNumber], bookId: (self.delgateBook?.bookId)!, completionHandler: { [weak self] (resultTafsirBookPageByPageNumber) in
                        self?.bookByPageNumberModel = resultTafsirBookPageByPageNumber

                        DetailTafserBookSelectViewController.pageContentLbl.text = self?.bookByPageNumberModel?.page?.pageContent
                        DetailTafserBookSelectViewController.titleQuranLbl.text =
                            self?.bookByPageNumberModel?.page?.title ?? ""
//                           self?.bookByPageNumberModel?.page?.title =  nil ? "" : self?.bookByPageNumberModel?.page?.title
                        DetailTafserBookSelectViewController.tafsirContentLbl.text = self?.bookByPageNumberModel?.page?.tafsir
                        if let numberPage = self?.CounterPageNumber[rowPageNumber] {
                            DetailTafserBookSelectViewController.pageNumberTextField.text = "\(numberPage)"

                        }
                        self?.bookByPageNumberModel?.page?.surahList?.forEach { surahObject in
                            self?.ayaNameList.selectRow(surahObject.id! - 1, inComponent: 0, animated: true)
                            self?.surahIdNumber = surahObject.id!

                            DetailTafserBookSelectViewController.ayaNameTextField.text = surahObject.name
                            if let numberAya = surahObject.ayat?[0] {
                                DetailTafserBookSelectViewController.numberAyatTextField.text = "\(numberAya)"
                                self?.numberOfAyaList.selectRow(numberAya + 1, inComponent: 0, animated: true)
                            }
                        }
                        DispatchQueue.main.async {
                        self?.ayaNameList.reloadAllComponents()
                        self?.numberOfAyaList.reloadAllComponents()
                        self?.pageNumberContent.reloadAllComponents()
                        }
                    })
        }
        else if ayaNameSelected == true {
            pageNumberSelected  = false
            ayaNumberSelected = false
            if pageNumberSelected != true  {
                if row == 0 {
                    self.surahIdNumber = 1
                    self.ayahNumber = 1
                } else {
                     self.surahIdNumber = row + 1

                }
            }
            
            
            self.viewModel?.detailTafserBookBySurahAndAyah(bookId: (delgateBook?.bookId)!, surahId: self.surahIdNumber!, ayah: 1, completionHandler: { [weak self] (resultTafsirBookPageByPageNumber) in
                self?.bookByPageNumberModel = resultTafsirBookPageByPageNumber
                
                if self?.bookByPageNumberModel?.previousPage == nil {
                    DetailTafserBookSelectViewController.previousPageBtn.isHidden = true
                } else {
                    DetailTafserBookSelectViewController.previousPageBtn.isHidden = false
                }
                
                
                if let pageNum = self?.bookByPageNumberModel?.page?.pageNumber {
                    if row == 0 {
                        DetailTafserBookSelectViewController.pageNumberTextField.text  = "\(pageNum)"
                        self?.pageNumberContent.selectRow(pageNum, inComponent: 0, animated: false)

                    } else {
                        DetailTafserBookSelectViewController.pageNumberTextField.text  = "\(pageNum )"
                        self?.pageNumberContent.selectRow(pageNum , inComponent: 0, animated: false)
                    }
                    DetailTafserBookSelectViewController.pageContentLbl.text = self?.bookByPageNumberModel?.page?.pageContent
                    DetailTafserBookSelectViewController.tafsirContentLbl.text = self?.bookByPageNumberModel?.page?.tafsir
                    DetailTafserBookSelectViewController.titleQuranLbl.text = self?.bookByPageNumberModel?.page?.title
                    
                    if let ayaNumber = self?.numberAyat[0] {
                        DetailTafserBookSelectViewController.numberAyatTextField.text = "\(ayaNumber)"

                    }
                    
                    for indexAya in 0..<(self?.bookByPageNumberModel?.page?.surahList?.count ?? 0) {
                        self?.surahIdNumber = self?.bookByPageNumberModel?.page?.surahList?[indexAya].id
                        
                        self?.bookByPageNumberModel?.page?.surahList?.forEach {
                            surahObject in
                            DetailTafserBookSelectViewController.ayaNameTextField.text = surahObject.name
                        }
                    }
                    self?.viewModelAllSurah?.getAllSurahApi(completionHandler: { [weak self] (resultGetAllSurahModel) in
                        self?.allSurahModel = resultGetAllSurahModel
                        self?.allSurahModel?.results.forEach {
                            
                        surahObject in
                        if self?.surahIdNumber == surahObject.id {
                            if (self?.numberAyat.count ?? 0 > 0) {self?.numberAyat.removeAll()}
                            self?.numberAyat.append(contentsOf: (surahObject.ayat)!)
                        }
                        }
                        DispatchQueue.main.async {
                            self?.numberOfAyaList.reloadAllComponents()
                            }
                    })
                }
                DispatchQueue.main.async {
                    self?.ayaNameList.reloadAllComponents()
//                    self?.numberOfAyaList.reloadAllComponents()
                    self?.pageNumberContent.reloadAllComponents()
                }
            })
            
        } else if ayaNumberSelected == true {
            ayaNameSelected = false
            pageNumberSelected = false

            if row == 0 {
                self.surahIdNumber = 1
                self.ayahNumber = 1
                
            } else {
                 self.surahIdNumber = row + 1

            }
            
            self.viewModel?.detailTafserBookBySurahAndAyah(bookId: (delgateBook?.bookId)!, surahId: self.surahIdNumber!, ayah: rowNumberAyat + 1, completionHandler: { [weak self] (resultTafsirBookPageByPageNumber) in
                self?.bookByPageNumberModel = resultTafsirBookPageByPageNumber
              
                if self?.pageNumberSelected == false {
                    self?.pageNumberContent.selectRow((self?.bookByPageNumberModel?.page?.pageNumber)! - 1, inComponent: 0, animated: false)
                    
                    if let pageNum = self?.bookByPageNumberModel?.page?.pageNumber {
                        DetailTafserBookSelectViewController.pageNumberTextField.text = "\(pageNum)"
                        DetailTafserBookSelectViewController.pageContentLbl.text = self?.bookByPageNumberModel?.page?.pageContent
                        DetailTafserBookSelectViewController.tafsirContentLbl.text = self?.bookByPageNumberModel?.page?.tafsir
                        DetailTafserBookSelectViewController.titleQuranLbl.text = self?.bookByPageNumberModel?.page?.title
                    }
                } else {
                    DetailTafserBookSelectViewController.pageContentLbl.text = self?.bookByPageNumberModel?.page?.pageContent
                    DetailTafserBookSelectViewController.tafsirContentLbl.text = self?.bookByPageNumberModel?.page?.tafsir
                    DetailTafserBookSelectViewController.titleQuranLbl.text = self?.bookByPageNumberModel?.page?.title
                }
                
                if let ayaNumber = self?.numberAyat[rowNumberAyat] {
                    DetailTafserBookSelectViewController.numberAyatTextField.text = "\(ayaNumber)"

                }
                DispatchQueue.main.async {
                    self?.ayaNameList.reloadAllComponents()
                    self?.numberOfAyaList.reloadAllComponents()
                    self?.pageNumberContent.reloadAllComponents()
                }
            })
        }
    }

    func didTapCancel() {
//        self.ayaNameTextField.text = nil
        DetailTafserBookSelectViewController.ayaNameTextField.resignFirstResponder()
//        self.numberAyatTextField.text = nil
        DetailTafserBookSelectViewController.numberAyatTextField.resignFirstResponder()
//        self.pageNumberTextField.text = nil
        DetailTafserBookSelectViewController.pageNumberTextField.resignFirstResponder()
    }
}
