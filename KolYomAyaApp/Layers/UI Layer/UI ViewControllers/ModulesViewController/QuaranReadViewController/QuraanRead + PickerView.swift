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

            return self.numberAyat.uniques.count
//            return self.numberAyat.count

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
//            return   "\(self.numberAyat[row])"

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
              self.ayaNameTextField.text = KeyAndValue.SURA_NAME[row].name
              
          } else if pickerView == pageNumberContent {
              self.pageNumber = row
//              self.pageNumberTextField.text = nil
              pageNumberSelected = true
            ayaNumberSelected = false
            ayaNameSelected = false
              self.pageNumberTextField.text = "\(self.CounterPageNumber[row])"
              
          } else if pickerView == numberOfAyaList {
            numberRowAya = row + 1
              pageNumberSelected = false
              ayaNameSelected = false
              ayaNumberSelected = true

            self.numberAyatTextField.text = "\(self.numberAyat.uniques[numberRowAya])"

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

        if pageNumberSelected == true {
            ayaNameSelected = false
            ayaNumberSelected = false
            self.pageNumber = CounterPageNumber[rowPageNumber]
            viewModel?.surahAyaByPageNumberApi(pageNumber: CounterPageNumber[rowPageNumber], completionHandler: { [weak self] (resultQuraanPageModel) in
                self?.quraanReadModel = resultQuraanPageModel
             
                if let numberPage = self?.CounterPageNumber[rowPageNumber] {
                    self?.pageNumberTextField.text = "\(numberPage)"
                   self?.suraImage.imageFromURL(urlString: (resultQuraanPageModel.quraanPage?.image)!)

                }
            
                self?.quraanReadModel?.quraanPage?.surahList?.forEach { surahObject in
                    print(surahObject.id!)
                    self?.ayaNameList.selectRow(surahObject.id! - 1, inComponent: 0, animated: true)
                    
                    self?.surahIdNumber = surahObject.id!
                    self?.ayaNameTextField.text = surahObject.name
                    if let numberAya = surahObject.ayat?[0] {
                        self?.numberAyatTextField.text = "\(numberAya)"
//                        print("numberAyayatbeforeayatnumberAyayatbeforeayat\(numberAya)")
//
                        self?.numberOfAyaList.selectRow(numberAya + 1, inComponent: 0, animated: true)

                    }
                }
                DispatchQueue.main.async {
                    self?.ayaNameList.reloadAllComponents()
                    self?.pageNumberContent.reloadAllComponents()
                    self?.numberOfAyaList.reloadAllComponents()

                }
              })
            
        } else if ayaNameSelected == true {
  
            pageNumberSelected  = false
            ayaNumberSelected = false
//|| ayaNumberSelected != true
            if pageNumberSelected != true  {
                if row == 0 {
                    self.surahIdNumber = 1
                    self.ayahNumber = 1
                } else {
                     self.surahIdNumber = row + 1

                }
            }
            self.viewModel?.quraanReadBySurahAndAyah(surahId: (self.surahIdNumber)!,ayah: 1, completionHandler: {[weak self] (resultQuraanPageModel) in
                self?.quraanReadModel = resultQuraanPageModel
                
                if let pageNum = self?.quraanReadModel?.quraanPage?.pageNumber {
                    if row == 0 {
                        self?.pageNumberTextField.text  = "\(pageNum)"
                        self?.pageNumberContent.selectRow(pageNum, inComponent: 0, animated: false)

                    } else {
                        self?.pageNumberTextField.text  = "\(pageNum - 1)"
                        self?.pageNumberContent.selectRow(pageNum - 1, inComponent: 0, animated: false)
                    }
                    
                    self?.suraImage.imageFromURL(urlString: (self?.quraanReadModel?.quraanPage?.image ?? ""))
                           }
                if let ayaNumber = self?.numberAyat[0] {
                    self?.numberAyatTextField.text = "\(ayaNumber)"

                }
                
                 for indexAya in 0..<(self?.quraanReadModel?.quraanPage?.surahList?.count ?? 0)  {
                     self?.surahIdNumber = self?.quraanReadModel?.quraanPage?.surahList?[indexAya].id
    
                    self?.quraanReadModel?.quraanPage?.surahList?.forEach { surahObject in
                        self?.ayaNameTextField.text = surahObject.name

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
//                if self?.ayaNumberSelected == false {
//                    //will call api retrieve all numbers ayat included spesfic surah & reload pickerview for surahNumber
//                    self?.viewModel?.quraanReadBySurahAndAyah(surahId: (self?.surahIdNumber!)!, ayah: self?.numberAyat[rowNumberAyat], completionHandler: { [weak self] (resultQuraanPageModel) in
//                        self?.quraanReadModel = resultQuraanPageModel
//
//                        self?.quraanReadModel?.quraanPage?.surahList?.forEach { surahObject in
//
////                            self?.numberAyat.append(contentsOf: surahObject.ayat!)
//
//                            if let numberAya = self?.numberAyat[0] {
//                                self?.numberAyatTextField.text = "\(numberAya)"
//
//                            }
//
//                        }
//                        DispatchQueue.main.async {
//                            self?.numberOfAyaList.reloadAllComponents()
//                        }
//                    })
//
//                }
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
           
            self.viewModel?.quraanReadBySurahAndAyah(surahId: self.surahIdNumber!, ayah: rowNumberAyat + 1, completionHandler: { [weak self] (resultQuraanPageModel) in
                self?.quraanReadModel = resultQuraanPageModel
                if self?.pageNumberSelected == false {
                    print((self?.quraanReadModel?.quraanPage?.image) ?? "")
                    self?.pageNumberContent.selectRow((self?.quraanReadModel?.quraanPage?.pageNumber)! - 1, inComponent: 0, animated: false)
                    if let pageNum = self?.quraanReadModel?.quraanPage?.pageNumber {
                        self?.pageNumberTextField.text  = "\(pageNum)"
                self?.suraImage.imageFromURL(urlString: (self?.quraanReadModel?.quraanPage?.image)!)
                    }
                } else {
                    print("pageNumberIsSelect")
                    self?.suraImage.imageFromURL(urlString: (self?.quraanReadModel?.quraanPage?.image)!)
                }
                if let ayaNumber = self?.numberAyat[rowNumberAyat] {
                    self?.numberAyatTextField.text = "\(ayaNumber)"

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
        self.ayaNameTextField.resignFirstResponder()
        self.numberAyatTextField.resignFirstResponder()
        self.pageNumberTextField.resignFirstResponder()
    }
}

//        if pageNumberSelected ==  false {
//            self.numberAyatTextField.text = "\(self.numberRowAya)"
//        }
 
//        self.viewModel?.quraanReadBySurahAndAyah(surahId: (self.surahIdNumber)!, ayah: self.numberAyat[rowNumberAyat], completionHandler: {[weak self] (resultQuraanPageModel) in
//            self?.quraanReadModel = resultQuraanPageModel
//
//
//            if self?.pageNumberSelected ==  false {
//
//             if let pageNum = self?.quraanReadModel?.quraanPage?.pageNumber {
//                           self?.pageNumberTextField.text  = "\(pageNum)"
//                   self?.suraImage.imageFromURL(urlString: (self?.quraanReadModel?.quraanPage?.image)!)
//                       }
//
//            }
//
//
//              //Mark:- in this will be add surah ayat
////            self?.suraImage.imageFromURL(urlString: (self?.quraanReadModel?.quraanPage?.image)!)
//             for indexAya in 0..<(self?.quraanReadModel?.quraanPage?.surahList?.count ?? 0)  {
//                 self?.surahIdNumber = self?.quraanReadModel?.quraanPage?.surahList?[indexAya].id
////                if (self?.numberAyat.count ?? 0 ) > 0 {
////                    self?.numberAyat.removeAll()
////                }
//                self?.numberAyat.append(contentsOf: (self?.quraanReadModel?.quraanPage?.surahList?[indexAya].ayat?.uniques)!)
////                self?.numberAyat = (self?.quraanReadModel?.quraanPage?.surahList?[indexAya].ayat)!
//                print(self?.numberAyat)
//             }
//             self?.ayaNameList.reloadAllComponents()
//             self?.numberOfAyaList.reloadAllComponents()
//             self?.pageNumberContent.reloadAllComponents()
//        })
//        self.pageNumber = CounterPageNumber[rowPageNumber]
//
//        if pageNumberSelected == true {
//            print("pageNumberselectedddd")
//            print("pageNUMUMUMU\(CounterPageNumber[rowPageNumber])")
//            viewModel?.surahAyaByPageNumberApi(pageNumber: CounterPageNumber[rowPageNumber], completionHandler: { [weak self] (resultQuraanPageModel) in
//                self?.quraanReadModel = resultQuraanPageModel
//                self?.suraImage.imageFromURL(urlString: (resultQuraanPageModel.quraanPage?.image)!)
//                if let numberPage = self?.CounterPageNumber[rowPageNumber] {
//                    self?.pageNumberTextField.text = "\(numberPage)"
//
//                }
//                self?.quraanReadModel?.quraanPage?.surahList?.forEach { surahObject in
//                    self?.numberAyat.removeAll()
//
//                    self?.numberAyat.append(contentsOf: surahObject.ayat!)
//
//                    self?.ayaNameTextField.text = surahObject.name
//                    if let numberAya = surahObject.ayat?[0] {
//                        self?.numberAyatTextField.text = "\(numberAya)"
//                    }
//                }
//                DispatchQueue.main.async {
//                    self?.ayaNameList.reloadAllComponents()
//                    self?.pageNumberContent.reloadAllComponents()
//                    self?.numberOfAyaList.reloadAllComponents()
//
//                          }
//                    })
//
//        }//        if ayaNumberSelected == true {
        //            print("ayaNumberSelectedTrue")
        //
        //        } else if ayaNameSelected == true {
        //            print("ayaNameSelectedTrue")
        //            print("ffewfewffweewfew\(self.numberAyat[rowNumberAyat])")
        //
        //            self.viewModel?.quraanReadBySurahAndAyah(surahId: (self.surahIdNumber)!, ayah: self.numberAyat[rowNumberAyat], completionHandler: {[weak self] (resultQuraanPageModel) in
        //                self?.quraanReadModel = resultQuraanPageModel
        //
        //                self?.suraImage.imageFromURL(urlString: (self?.quraanReadModel?.quraanPage?.image ?? ""))
        //
        ////                if self?.pageNumberSelected ==  false {
        ////
        //                 if let pageNum = self?.quraanReadModel?.quraanPage?.pageNumber {
        //                               self?.pageNumberTextField.text  = "\(pageNum)"
        ////                       self?.suraImage.imageFromURL(urlString: (self?.quraanReadModel?.quraanPage?.image)!)
        //                           }
        ////
        ////                }
        //
        //
        //                  //Mark:- in this will be add surah ayat
        //    //            self?.suraImage.imageFromURL(urlString: (self?.quraanReadModel?.quraanPage?.image)!)
        //                 for indexAya in 0..<(self?.quraanReadModel?.quraanPage?.surahList?.count ?? 0)  {
        //                     self?.surahIdNumber = self?.quraanReadModel?.quraanPage?.surahList?[indexAya].id
        //    //                if (self?.numberAyat.count ?? 0 ) > 0 {
        //    //                    self?.numberAyat.removeAll()
        //    //                }
        //                    self?.numberAyat.append(contentsOf: (self?.quraanReadModel?.quraanPage?.surahList?[indexAya].ayat?.uniques)!)
        //    //                self?.numberAyat = (self?.quraanReadModel?.quraanPage?.surahList?[indexAya].ayat)!
        //
        //                    self?.quraanReadModel?.quraanPage?.surahList?.forEach { surahObject in
        //                        self?.numberAyat.removeAll()
        //                        self?.numberAyat.append(contentsOf: surahObject.ayat!)
        //
        //                        self?.ayaNameTextField.text = surahObject.name
        //                        if let numberAya = surahObject.ayat?[0] {
        //                            self?.numberAyatTextField.text = "\(numberAya)"
        //                        }
        //                    }
        //
        //
        //
        //                 }
        //                DispatchQueue.main.async {
        //                    self?.ayaNameList.reloadAllComponents()
        //                    self?.numberOfAyaList.reloadAllComponents()
        //                    self?.pageNumberContent.reloadAllComponents()
        //                }
        //
        //            })
        //        } else
