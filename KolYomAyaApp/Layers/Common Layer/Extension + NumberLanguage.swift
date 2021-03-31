//
//  Extension + NumberLanguage.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 2/28/21.
//  Copyright © 2021 Islam Abotaleb. All rights reserved.
//

import Foundation

extension String {

    func convertToPersianNum() -> String {
        let numbers:[Character : Character] = ["1":"۱","2":"۲","3":"۳","4":"٤","5":"٥","6":"٦","7":"۷","8":"۸","9":"۹","0":"۰"]

        let converted = String(self.compactMap{numbers[$0]})

        return converted

    }

}

