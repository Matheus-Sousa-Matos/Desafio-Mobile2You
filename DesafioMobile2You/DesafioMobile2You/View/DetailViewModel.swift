//
//  DetailViewModel.swift
//  DesafioMobile2You
//
//  Created by Matheus de Sousa Matos on 29/07/22.
//

import Foundation

let APIKey = "e83c363f0e18ccc591a2bbb0dbd92261"

@MainActor class DetailMovieViewModel: ObservableObject {
    //MARK: - Top Details
    @Published var favorited: Bool = false
    @Published var imageSection: String = "cover"
    @Published var titleSection: String = "The Very Best Of Jonhnny Depp"
    @Published var ​voteCount: String = "1.2K Likes"
    @Published var popularity: String = "3 of 10 Watched"
   
    //MARK: - Card
    @Published var imageMovie: String = "cover"
    @Published var titleMovie: String = "Edward Scissorhands"
    @Published var data: String = "1990"
    @Published var gender: String = "Drama, Fantasy"

    func fetchMovieDetail(){
        
    }
    
    
    
}
