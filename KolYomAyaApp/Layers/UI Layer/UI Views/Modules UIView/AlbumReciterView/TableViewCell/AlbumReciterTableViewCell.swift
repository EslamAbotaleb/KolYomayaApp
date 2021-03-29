//
//  AlbumReciterTableViewCell.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/27/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit

class AlbumReciterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameProgamText: UILabel!
    @IBOutlet weak var numberOfEpisodesLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(viewModel: ResultAlbumReciter) {
        self.numberOfEpisodesLbl.text = "\(viewModel.itemsNumber!)".convertToPersianNum()
        self.nameProgamText.text =  "  " + viewModel.name! + "  "
        
    }
}
