//
//  ArrayExtenstion.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 8/8/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import Foundation
extension Array where Element: Hashable {
    var uniques: Array {
        var buffer = Array()
        var added = Set<Element>()
        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}
