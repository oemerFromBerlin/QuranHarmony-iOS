//
//  ResponseTexte.swift
//  LearnTheQuran
//
//  Created by Ömer Tarakci on 28.06.23.
//

import Foundation

struct ResponseText: Codable {
    let code: Int
    let status: String
    let data: SurahData
}
