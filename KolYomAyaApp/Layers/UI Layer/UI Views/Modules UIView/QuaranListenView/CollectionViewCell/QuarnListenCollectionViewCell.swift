//
//  QuarnListenCollectionViewCell.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/27/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit

class QuarnListenCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageReciter: UIImageView!
    @IBOutlet weak var nameReciterLabel: UILabel!
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var playButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageReciter.layer.shadowRadius = 6.0
        imageReciter.layer.cornerRadius = 7.0
        //
        cardView.layer.cornerRadius = 10.0
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cardView.layer.shadowRadius = 2.5
        cardView.layer.shadowOpacity = 0.7
    }
    func configure(viewModel: ResultReciter) {
        
        //        imageReciter.imageFromURL(urlString: viewModel.image!)
        
        ImageService.downloadImage(withURL: URL(string: viewModel.image!)!) { (image) in
            self.imageReciter.image = image
        }
        //        imageReciter.imageFromURL(urlString: viewModel.image!)
        nameReciterLabel.text = viewModel.name
    }
}
