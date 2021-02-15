//
//  TafserBookCollectionViewCell.swift
//  KolYoumAya
//
//  Created by Islam Abotaleb on 7/23/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit

final class TafserBookCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewTafserBook: UIView!
    @IBOutlet weak var imageBook: UIImageView!
    @IBOutlet weak var subTitleBookTafserLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        imageBook.layer.shadowRadius = 6.0
        imageBook.layer.cornerRadius = 7.0
        
    }
        func configure(viewModel: Result) {
    
            self.subTitleBookTafserLbl.text = viewModel.title

//            imageBook.imageFromURL(urlString:viewModel.cover!)
            
            ImageService.downloadImage(withURL: URL(string: viewModel.cover!)!) { (image) in
                self.imageBook.image = image
            }
        }
}
