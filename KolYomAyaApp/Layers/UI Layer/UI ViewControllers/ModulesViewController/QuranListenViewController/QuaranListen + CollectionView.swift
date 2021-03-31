//
//  QuaranListen + CollectionView.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/27/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit

extension QuarnListenViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recitersListViewModel?.numberOfRows() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuarnListenCollectionViewCell.reuseIdentifier, for: indexPath) as? QuarnListenCollectionViewCell else {
            fatalError("Not found QuarnListen cell ")
        }
        if indexPath.row < self.recitersModel?.results.count ?? 0 {
            cell.configure(viewModel: (self.recitersModel?.results[indexPath.row])!)

        } else if self.recitersModel?.results.count ?? 0 < 0 {
            
        } else {
            
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
         coordinator?.statusListen = "QuranListen"
        coordinator?.reciterId = self.recitersModel?.results[indexPath.row].id
        coordinator?.imageReciter = self.recitersModel?.results[indexPath.row].image
        coordinator?.nameReciter = self.recitersModel?.results[indexPath.row].name
            
        coordinator?.start()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
          if isDataLoading {
              return CGSize.zero
          }
          return CGSize(width: collectionView.bounds.size.width, height: 30)
      }
      
      func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
          if kind == UICollectionView.elementKindSectionFooter {
              let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerViewReuseIdentifier, for: indexPath) as! CustomFooterView
              self.footerView = aFooterView
              self.footerView?.backgroundColor = UIColor.clear
              return aFooterView
          } else {
              let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerViewReuseIdentifier, for: indexPath)
              return headerView
          }
      }
      func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
          if elementKind == UICollectionView.elementKindSectionFooter {
              
              self.footerView?.prepareInitialAnimation()
              
          }
      }
      func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
          if elementKind == UICollectionView.elementKindSectionFooter {
              self.footerView?.stopAnimate()
              //                self.footerView?.isHidden = true
          }
      }
}

extension QuarnListenViewController: UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWith()
        return CGSize(width: width  , height: width + 30.0)
    }
    func calculateWith() -> CGFloat {
             let estimatedWidth = CGFloat(estimateWidth)
             let cellCount = floor(CGFloat(self.view.frame.size.width / estimatedWidth))
             
             let margin = CGFloat(cellMarginSize * 2)
             let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
             
             return width
         }
       
}
