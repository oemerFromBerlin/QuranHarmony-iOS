//
//  ResponseAudio.swift
//  LearnTheQuran
//
//  Created by Ömer Tarakci on 28.06.23.
//


struct ResponseAudio: Codable {
    let code: Int
    let status: String
    let data: AudioData
}
