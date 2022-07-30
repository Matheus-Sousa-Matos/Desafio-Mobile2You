//
//  MovieDetail.swift
//  DesafioMobile2You
//
//  Created by Matheus de Sousa Matos on 29/07/22.
//

import Foundation

//MARK: - Data
struct Movie: Codable, Identifiable {
    var id: Int?
    var popularity: Double?
    var posterPath: String?
    var title: String?
    var voteCount: Int?
    var genres: [Genres]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case popularity
        case posterPath = "poster_path"
        case title
        case voteCount = "vote_count"
        case genres
    }
    
}

struct Genres: Codable, Identifiable{
    var id: Int
    var name: String
}
