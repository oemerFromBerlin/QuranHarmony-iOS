//
//  AyahTexte.swift
//  LearnTheQuran
//
//  Created by Ömer Tarakci on 28.06.23.
//

import Foundation

struct AyahText: Codable, Identifiable, Hashable {
    var id : Int { number }
    let number: Int
    let text: String
    let numberInSurah: Int
    let juz: Int
    let manzil: Int
    let page: Int
    let ruku: Int
    let hizbQuarter: Int
//    let sajda: Bool?
}
