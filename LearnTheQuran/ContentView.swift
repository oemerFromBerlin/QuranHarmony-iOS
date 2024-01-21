//
//  ContentView.swift
//  LearnTheQuran
//
//  Created by Ömer Tarakci on 28.06.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var textRepository = TextRepository()

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            HomeScreen()
        }
        .environmentObject(textRepository)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
