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
                
            return   "\(self.numberAyat.uniques[row])"

        } else if pickerView == pageNumberContent {
                return "\(self.CounterPageNumber[row])"
            

                      
        } else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if pickerView == ayaNameList {

            self.ayaNameTextField.text = KeyAndValue.SURA_NAME[row].name
            
        } else if pickerView == pageNumberContent {
            self.pageNumber = row
            self.pageNumberTextField.text = nil
            pageNumberSelected = true
  
            self.pageNumberTextField.text = "\(self.CounterPageNumber[row])"
            
        } else if pickerView == numberOfAyaList {
            pageNumberSelected = false
            self.numberAyatTextField.text = "\(self.numberAyat.uniques[row])"

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
        self.ayaNameTextField.text = KeyAndValue.SURA_NAME[row].name
        self.numberAyatTextField.resignFirstResponder()
        self.ayaNameTextField.resignFirstResponder()
        self.pageNumberTextField.resignFirstResponder()
        if row == 0 {
            self.surahIdNumber = 1
            self.ayahNumber = 1
        } else {
            self.surahIdNumber = row + 1
        }
        
        self.numberRowAya = self.numberAyat.uniques[rowNumberAyat]
       
        if pageNumberSelected ==  false {
            self.numberAyatTextField.text = "\(self.numberRowAya)"
        }
        self.viewModel?.detailTafserBookBySurahAndAyah(bookId: (self.delgateBook?.bookId)!, surahId: (self.surahIdNumber)!, ayah: self.numberAyat.uniques[rowNumberAyat], completionHandler: { [weak self] (bookTafsirBySurahAndAyah) in
            self?.bookByPageNumberModel = bookTafsirBySurahAndAyah
            if self?.pageNumberSelected ==  false {
                       if let pageNum = self?.bookByPageNumberModel?.page?.pageNumber {
                                     self?.pageNumberTextField.text  = "\(pageNum)"
                                 }
                
            }
          
                    if self?.bookByPageNumberModel?.previousPage == nil {
                        self?.previousPageBtn.isHidden = true
                    } else {
                        self?.previousPageBtn.isHidden = false
            }
            self?.pageContentLbl.text = self?.bookByPageNumberModel?.page?.pageContent
            self?.tafsirContentLbl.text = self?.bookByPageNumberModel?.page?.tafsir
            
            for indexAya in 0..<(self?.bookByPageNumberModel?.page?.surahList!.count)! {
                self?.surahIdNumber = self?.bookByPageNumberModel?.page?.surahList?[indexAya].id
                self?.numberAyat.append(contentsOf: (self?.bookByPageNumberModel?.page?.surahList?[indexAya].ayat)!)
            }
            self?.ayaNameList.reloadAllComponents()
            self?.numberOfAyaList.reloadAllComponents()
            self?.pageNumberContent.reloadAllComponents()
        })
        self.pageNumber = CounterPageNumber[rowPageNumber]

        if pageNumberSelected == true {
                    self.viewModel?.detailtafserBookSelectApi(pageNumber: CounterPageNumber[rowPageNumber], bookId: (self.delgateBook?.bookId)!, completionHandler: { [weak self] (resultTafsirBookPageByPageNumber) in
                        self?.bookByPageNumberModel = resultTafsirBookPageByPageNumber
                        self?.pageContentLbl.text = self?.bookByPageNumberModel?.page?.pageContent
                        self?.tafsirContentLbl.text = self?.bookByPageNumberModel?.page?.tafsir
                        if let numberPage = self?.CounterPageNumber[rowPageNumber] {
                            self?.pageNumberTextField.text = "\(numberPage)"

                        }
                        self?.bookByPageNumberModel?.page?.surahList?.forEach { surahObject in
                            
                            self?.ayaNameTextField.text = surahObject.name
                            if let numberAya = surahObject.ayat?[0] {
                                self?.numberAyatTextField.text = "\(numberAya)"
                            }
                        }
                        self?.ayaNameList.reloadAllComponents()
                        self?.numberOfAyaList.reloadAllComponents()
                        self?.pageNumberContent.reloadAllComponents()
                    })
        }

    }

    func didTapCancel() {
//        self.ayaNameTextField.text = nil
        self.ayaNameTextField.resignFirstResponder()
//        self.numberAyatTextField.text = nil
        self.numberAyatTextField.resignFirstResponder()
//        self.pageNumberTextField.text = nil
        self.pageNumberTextField.resignFirstResponder()
    }
}
