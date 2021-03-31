//
//  PlayAudioTableViewCell.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 3/29/21.
//  Copyright © 2021 Islam Abotaleb. All rights reserved.
//

import UIKit

class PlayAudioTableViewCell: UITableViewCell {

    @IBOutlet weak var audioName: UILabel!
    @IBOutlet weak var removeAudio: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
