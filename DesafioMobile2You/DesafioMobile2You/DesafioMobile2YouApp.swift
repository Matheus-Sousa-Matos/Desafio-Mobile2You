//
//  DesafioMobile2YouApp.swift
//  DesafioMobile2You
//
//  Created by Matheus de Sousa Matos on 29/07/22.
//

import SwiftUI

@main
struct DesafioMobile2YouApp: App {
    var body: some Scene {
        WindowGroup {
            DetailMovieView()
                .environmentObject(DetailMovieViewModel())
        }
    }
}
