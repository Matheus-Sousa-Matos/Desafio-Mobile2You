//
//  DetailViewModel.swift
//  DesafioMobile2You
//
//  Created by Matheus de Sousa Matos on 29/07/22.
//

import Foundation

class DetailMovieViewModel: ObservableObject {
    var movie = Movie()
    var movies: [Movie] = []
    
    private var similarMovies: [SimilarMovie] = []
    private var imgPath: String = "cover"
    private var idMovie: Int = 502
    
    @Published var imgURLMovie: String = "https://image.tmdb.org/t/p/w300"
    @Published var favorited: Bool = false
    @Published var imgURLSimilarMovie: String = "https://image.tmdb.org/t/p/w300"

    //MARK: - Image Formatter  [Base Url + size + path]
    //https://image.tmdb.org/t/p/w300/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg
    
    init() {
        fetchMovieDetail(idMovie: self.idMovie)
        fetchSimilarMovies()
    }

    func fetchMovieDetail(idMovie: Int) {
        Service.shared.getMovieDetail(idMovie: idMovie) { result in
            DispatchQueue.main.async {
                switch result {
                case let .failure(error):
                    print(error)
                case let .success(data):
                    print(data)
                    do {
                        self.movie =  try result.get()
                        //MARK: - Formatter url image
                        self.imgPath = try result.get().posterPath!
                        self.imgURLMovie = self.imgURLMovie + self.imgPath
                        self.movies.append(self.movie)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func fetchSimilarMovies() {
        Service.shared.getSimilarMovies(idMovie: self.idMovie) { movies in
            DispatchQueue.main.async {
                switch movies {
                case let .failure(error):
                    print(error)
                case let .success(data):
                    print(data)
                    do {
                        self.similarMovies = try movies.get().results
                        for similarMovie in self.similarMovies {
                            self.fetchMovieDetail(idMovie: similarMovie.id ?? 0)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
}
