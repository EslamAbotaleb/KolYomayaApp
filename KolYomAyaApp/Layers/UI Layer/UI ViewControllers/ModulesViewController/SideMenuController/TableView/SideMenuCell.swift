//
//  SideMenuCell.swift
//  KolYoumAya
//
//  Created by Islam Abotaleb on 7/21/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit
 class SideMenuCell: UITableViewCell {
    
    @IBOutlet weak var imageItem: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
    }
//    func configureCell(name: String, thumbnail: String) {
//        self.titleLabel.text = name
//        self.imageItem.image = UIImage(named: thumbnail)
//    }

    func configure(_ viewModel: SideMenuItemPresentable) -> (Void) {
        imageItem.image = viewModel.imagename
        titleLabel.font = UIFont(name: "ge_ss_two_medium", size: 40)

        titleLabel.text = viewModel.name
    }
}
