//
//  AyahAudio.swift
//  LearnTheQuran
//
//  Created by Ömer Tarakci on 28.06.23.
//

import Foundation

struct AyahAudio: Codable, Identifiable, Hashable {
    var id: Int {number}
    var number : Int
    var audio : String //url
    var audioSecondary : [String]
    var text : String
    var numberInSurah : Int
    var juz : Int
    var manzil : Int
    var page : Int
    var ruku : Int
    var hizbQuarter : Int
//    var toggleFavorite : Bool = true
//    var sajda : Bool?
}

