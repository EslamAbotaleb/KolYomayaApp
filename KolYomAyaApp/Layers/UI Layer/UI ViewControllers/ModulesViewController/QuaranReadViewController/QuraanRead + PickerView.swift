//
//  QuraanRead + PickerView.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 8/9/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit

extension QuarnReadViewController: UIPickerViewDataSource, UIPickerViewDelegate {
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

//            return self.numberAyat.uniques.count
            return self.numberAyat.count

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
            print("numberOFAya\(self.numberAyat.count)")

//            return   "\(self.numberAyat.uniques[row])"
            return   "\(self.numberAyat[row])"

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
            print("numberofayaytPickerView\(numberAyat)")
            print("numberofayaytPickerViewuniquesuniques\(numberAyat.uniques)")

//              self.numberAyatTextField.text = "\(self.numberAyat.uniques[row])"
            self.numberAyatTextField.text = "\(self.numberAyat[row])"

          }
      }
}


extension QuarnReadViewController: ToolbarPickerViewDelegate {

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
        
//        if row == 0 {
//            print("rowequalzero")
//            self.surahIdNumber = 1
//            self.ayahNumber = 1
//        } else {
//            print("rownotzeroo")
//            self.surahIdNumber = row + 1
//            print("surahIdNumber\(self.surahIdNumber)")
//        }
        self.surahIdNumber! +=  1
//        if row == 0 {
//            print("rowequalzero")
//            self.surahIdNumber = 1
//            self.ayahNumber = 1
//        } else {
//            print("rownotzeroo")
////            self.surahIdNumber = row + 1
//            self.surahIdNumber +=  1
//
//            print("surahIdNumber\(self.surahIdNumber)")
//        }
//        self.numberRowAya = self.numberAyat.uniques[rowNumberAyat]
        self.numberRowAya = self.numberAyat[rowNumberAyat]

        if pageNumberSelected ==  false {
            self.numberAyatTextField.text = "\(self.numberRowAya)"
        }
        
//        self.numberAyat.uniques
        self.viewModel?.quraanReadBySurahAndAyah(surahId: (self.surahIdNumber)!, ayah: self.numberAyat[rowNumberAyat], completionHandler: {[weak self] (resultQuraanPageModel) in
            self?.quraanReadModel = resultQuraanPageModel
            
            
            if self?.pageNumberSelected ==  false {
                                 if let pageNum = self?.quraanReadModel?.quraanPage?.pageNumber {
                                               self?.pageNumberTextField.text  = "\(pageNum)"
                                       self?.suraImage.imageFromURL(urlString: (self?.quraanReadModel?.quraanPage?.image)!)
                                           }
                          
                      }
            
//            if let pageNum = self?.quraanReadModel?.quraanPage?.pageNumber {
//                 self?.pageNumberTextField.text  = "\(pageNum)"
//
//             }
              //Mark:- in this will be add surah ayat
//            self?.suraImage.imageFromURL(urlString: (self?.quraanReadModel?.quraanPage?.image)!)
             for indexAya in 0..<(self?.quraanReadModel?.quraanPage?.surahList?.count ?? 0)  {
                 self?.surahIdNumber = self?.quraanReadModel?.quraanPage?.surahList?[indexAya].id

//                 self?.numberAyat.append(contentsOf: (self?.quraanReadModel?.quraanPage?.surahList?[indexAya].ayat)!)
                self?.numberAyat = (self?.quraanReadModel?.quraanPage?.surahList?[indexAya].ayat)!
             }
             self?.ayaNameList.reloadAllComponents()
             self?.numberOfAyaList.reloadAllComponents()
             self?.pageNumberContent.reloadAllComponents()
        })
        self.pageNumber = CounterPageNumber[rowPageNumber]

        if pageNumberSelected == true {
       
            viewModel?.surahAyaByPageNumberApi(pageNumber: CounterPageNumber[rowPageNumber], completionHandler: { [weak self] (resultQuraanPageModel) in
                self?.quraanReadModel = resultQuraanPageModel
                self?.suraImage.imageFromURL(urlString: (resultQuraanPageModel.quraanPage?.image)!)
                if let numberPage = self?.CounterPageNumber[rowPageNumber] {
                    self?.pageNumberTextField.text = "\(numberPage)"
                    
                }
                self?.quraanReadModel?.quraanPage?.surahList?.forEach { surahObject in
                    
                    self?.ayaNameTextField.text = surahObject.name
                    if let numberAya = surahObject.ayat?[0] {
                        self?.numberAyatTextField.text = "\(numberAya)"
                    }
                }

                    })
            
        }

    }

    func didTapCancel() {
//        self.ayaNameTextField.text = ""
        self.ayaNameTextField.resignFirstResponder()
//        self.numberAyatTextField.text = ""
        self.numberAyatTextField.resignFirstResponder()
//        self.pageNumberTextField.text = ""
        self.pageNumberTextField.resignFirstResponder()
    }
}
