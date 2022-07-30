//
//  SimilarMovies.swift
//  DesafioMobile2You
//
//  Created by Matheus de Sousa Matos on 30/07/22.
//

import Foundation

struct ResultSimilarMovie: Codable {
    var page: Int?
    var results: [SimilarMovie]
}

struct SimilarMovie: Hashable, Codable{
    var title: String?
    var posterPath: String?
    var releaseDate: String?
    var genreIds: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
    }
    
}
