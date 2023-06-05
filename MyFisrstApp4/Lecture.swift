//
//  Lecture.swift
//  MyFisrstApp4
//
//  Created by Vadim Belotitskiy on 22.05.2023.
//

import Foundation

struct Lecture: Codable {
    var name: String
    var description: String
    var date: Date
    var duration: TimeInterval
}
