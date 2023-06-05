//
//  Course.swift
//  MyFisrstApp4
//
//  Created by Vadim Belotitskiy on 22.05.2023.
//

import Foundation

struct Course: Codable {
    var name: String
    var lectures: [Lecture]
}
