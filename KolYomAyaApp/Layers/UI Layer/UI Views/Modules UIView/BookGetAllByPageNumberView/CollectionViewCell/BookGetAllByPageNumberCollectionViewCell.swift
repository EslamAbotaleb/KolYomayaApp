//
//  BookGetAllByPageNumberCollectionViewCell.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/28/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit

class BookGetAllByPageNumberCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageBook: UIImageView!
       @IBOutlet weak var nameBookLabel: UILabel!
    @IBOutlet weak var  cardViewItem: UIView!
       @IBOutlet weak var playButton: UIButton!
       override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
           imageBook.layer.shadowRadius = 6.0
               imageBook.layer.cornerRadius = 7.0
        
        cardViewItem.layer.cornerRadius = 10.0
        cardViewItem.layer.shadowColor = UIColor.gray.cgColor
        cardViewItem.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cardViewItem.layer.shadowRadius = 2.5
        cardViewItem.layer.shadowOpacity = 0.7
       }
   
    func configure(viewModel: ResultReciter) {
//        self.imageBook.imageFromURL(urlString: viewModel.cover!)
//        self.nameBookLabel.text = viewModel.title
        self.nameBookLabel.text = viewModel.name
        self.imageBook.imageFromURL(urlString: viewModel.image!)
    }
}
