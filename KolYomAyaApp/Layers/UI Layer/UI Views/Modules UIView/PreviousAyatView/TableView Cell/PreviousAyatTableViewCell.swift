//
//  PreviousAyatTableViewCell.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/24/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit

final class PreviousAyatTableViewCell: UITableViewCell {

    @IBOutlet weak var surNameLabel: UILabel!
    @IBOutlet weak var ayaNumberLabel: UILabel!
    @IBOutlet weak var ayaLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(viewModel: AyaObjectViewModel) {
        
        self.surNameLabel.text = "سورة:" + viewModel.suraName
        self.ayaNumberLabel.text =  "آية:" + "\(viewModel.ayaNumber)".convertToPersianNum()
        self.ayaLabel.font = UIFont(name: "kitab_b", size: 30)

        self.ayaLabel.text = viewModel.aya
    }
}
