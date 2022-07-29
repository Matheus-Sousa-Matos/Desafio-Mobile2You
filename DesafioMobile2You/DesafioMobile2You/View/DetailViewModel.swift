//
//  DetailViewModel.swift
//  DesafioMobile2You
//
//  Created by Matheus de Sousa Matos on 29/07/22.
//

import Foundation

let APIKey = "e83c363f0e18ccc591a2bbb0dbd92261"

//MARK: - Data
struct MovieDetail: Codable, Identifiable{
    var id: Int?
    var imdb_id: String?
    var original_title: String?
    var popularity: Double?
    var poster_path: String?
    var release_date: String?
    var title: String?
    var vote_count: Int?
}

@MainActor class DetailViewModel: ObservableObject {
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

    
}

class Service {
    
    static let shared = Service()
    
    func fetchMovieDetail(callback: @escaping (Result<Any, ServiceError>) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/550?api_key=\(APIKey)&language=en-US") else {
            callback(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                callback(.failure(.newtowrk(error)))
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            callback(.success(json))
                
        }
        task.resume()
        
    }
    
}


