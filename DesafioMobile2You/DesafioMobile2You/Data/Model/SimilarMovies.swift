//
//  SimilarMovies.swift
//  DesafioMobile2You
//
//  Created by Matheus de Sousa Matos on 30/07/22.
//

struct ResultSimilarMovie: Codable {
    var page: Int?
    var results: [SimilarMovie]
}

struct SimilarMovie: Codable{
    var id: Int?
}
