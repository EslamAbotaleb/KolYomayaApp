//
//  ElsharawyTableViewCell.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/26/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit

class ElsharawyTableViewCell: UITableViewCell {

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
    
    func configure(viewModel: ProgramsList) {
        self.nameProgamText.text = viewModel.programName
        self.numberOfEpisodesLbl.text = "\(viewModel.mediaNumber)".convertToPersianNum()
    }
    
}
