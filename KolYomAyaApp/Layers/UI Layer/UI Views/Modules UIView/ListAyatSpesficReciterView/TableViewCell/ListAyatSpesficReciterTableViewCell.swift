//
//  ListAyatSpesficReciterTableViewCell.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/27/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit

class ListAyatSpesficReciterTableViewCell: UITableViewCell {

    @IBOutlet weak var suraNameLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(viewModel: AudioList) {
     
        self.suraNameLabel.text = viewModel.name
    }
}
