//
//  Extension + TextField.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 2/15/21.
//  Copyright © 2021 Islam Abotaleb. All rights reserved.
//

import UIKit
extension UITextField {


    func set(bgColor: UIColor, placeholderTxt: String, placeholderColor: UIColor, txtColor: UIColor) {

        backgroundColor = bgColor
        attributedPlaceholder = NSAttributedString(string: placeholderTxt, attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        textColor = txtColor

        layoutSubviews()
    }
}
