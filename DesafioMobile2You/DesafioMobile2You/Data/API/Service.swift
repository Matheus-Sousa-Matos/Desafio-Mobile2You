//
//  ServiceTheMovieDB​.swift
//  DesafioMobile2You
//
//  Created by Matheus de Sousa Matos on 29/07/22.
//

import Foundation

//Test Serialization JSON
//let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)

class Service {
    
    static let shared = Service()
    
    func getMovieDetail(callback: @escaping (Result<Any, ServiceError>) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/550?api_key=\(APIKey)&language=en-US") else {
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
}
