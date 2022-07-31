//
//  MovieDetail.swift
//  DesafioMobile2You
//
//  Created by Matheus de Sousa Matos on 29/07/22.
//

struct Movie: Codable, Identifiable, Hashable {
    var id: Int?
    var popularity: Double?
    var posterPath: String?
    var title: String?
    var voteCount: Int?
    var releaseDate: String?
    var genres: [Genres]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case popularity
        case posterPath = "poster_path"
        case title
        case releaseDate = "release_date"
        case voteCount = "vote_count"
        case genres
    }
    
}

struct Genres: Codable, Identifiable, Hashable {
    var id: Int
    var name: String
}
