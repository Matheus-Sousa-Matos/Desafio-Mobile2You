//
//  ServiceTheMovieDBâ€‹.swift
//  DesafioMobile2You
//
//  Created by Matheus de Sousa Matos on 29/07/22.
//

import Foundation

class Service {
    
    static let shared = Service()
    private let APIKey = "e83c363f0e18ccc591a2bbb0dbd92261"
    private let baseURL = "https://api.themoviedb.org/3/movie/"
    
    //MARK: - URLs
    //Note: 550 is static movie case change movie use var value or pass another value. Ex: 501
    //https://api.themoviedb.org/3/movie/550?api_key=e83c363f0e18ccc591a2bbb0dbd92261&language=en-US
    //https://api.themoviedb.org/3/movie/550x/similar?api_key=e83c363f0e18ccc591a2bbb0dbd92261&language=en-US&page=1
    
    func getMovieDetail(idMovie: Int, callback: @escaping (Result<Movie, ServiceError>) -> ()) {
        guard let url = URL(string: "\(baseURL)\(idMovie)?api_key=\(APIKey)&language=en-US") else {
            callback(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                callback(.failure(.newtowrk(error)))
                return
            }
            do {
                let movie = try JSONDecoder().decode(Movie.self, from: data)
                callback(.success(movie))
            } catch {
                callback(.failure(.decodeFail(error)))
            }
        }
        task.resume()
    }
    
    func getSimilarMovies(idMovie: Int, callback: @escaping (Result<ResultSimilarMovie, ServiceError>) -> ()) {
        guard let url = URL(string: "\(baseURL)\(idMovie)x/similar?api_key=\(APIKey)&language=en-US&page=1") else {
            callback(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                callback(.failure(.newtowrk(error)))
                return
            }
            do {
                let responseSimilarMovies = try JSONDecoder().decode(ResultSimilarMovie.self, from: data)
                callback(.success(responseSimilarMovies))
            } catch {
                callback(.failure(.decodeFail(error)))
            }
        }
        task.resume()
    }
    
}
