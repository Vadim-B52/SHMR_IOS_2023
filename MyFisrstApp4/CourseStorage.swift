//
//  CourseStorage.swift
//  MyFisrstApp4
//
//  Created by Vadim Belotitskiy on 22.05.2023.
//

import Foundation

struct CourseStorage {


    func load() -> Course {
        let url = Bundle.main.url(forResource: "course", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        return try! jsonDecoder.decode(Course.self, from: data)
    }
}
