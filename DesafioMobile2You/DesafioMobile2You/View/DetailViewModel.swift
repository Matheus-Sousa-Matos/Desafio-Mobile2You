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
    
    private var imgPath: String = "cover"
    private var idMovie: Int = 502
    @Published var genres: [String] = []
    var concat = ""
    
    var similarMovies: [SimilarMovie] = []
    
    var idSimilarMovie: Int = 0
    
    @Published var imgURLMovie: String = "https://image.tmdb.org/t/p/w300"
    @Published var titleMovie: String = "The Very Best Of Jonhnny Depp"
    @Published var ​voteCount: Int = 0
    @Published var popularity: Double = 0.0
    
    //MARK: - Buttons
    @Published var favorited: Bool = false
    @Published var gender: String = "Drama, Fantasy"
    @Published var imgURLSimilarMovie: String = "https://image.tmdb.org/t/p/w300"


    //MARK: - Image Formatter  [Base Url + size + path]
    //https://image.tmdb.org/t/p/w300/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg
    
    init(){
        fetchMovieDetail(idMovie: self.idMovie)
        fetchSimilarMovies()
    }

    func fetchMovieDetail(idMovie: Int){
        Service.shared.getMovieDetail(idMovie: idMovie) { result in
            DispatchQueue.main.async {
                switch result {
                case let .failure(error):
                    print(error)
                case let .success(data):
                    print(data)
                    do {
                        self.movie =  try result.get()
                        self.titleMovie = try result.get().title!
                        self.​voteCount = try result.get().voteCount!
                        self.popularity = try result.get().popularity!
                        
                        //MARK: - Image
                        self.imgPath = try result.get().posterPath!
                        self.imgURLMovie = self.imgURLMovie + self.imgPath
                        print("imgURLMovie: \(self.imgURLMovie)")
                        
                        self.movies.append(self.movie)
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func fetchSimilarMovies(){
        Service.shared.getSimilarMovies(idMovie: self.idMovie) { movies in
            DispatchQueue.main.async {
                switch movies {
                case let .failure(error):
                    print(error)
                case let .success(data):
                    print(data)
                    do {
                        //Pegar somente o id...
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

//    func fetchMovieDetailGenres(currentMovieId: Int){
//        Service.shared.getMovieDetail(idMovie: currentMovieId) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case let .failure(error):
//                    print(error)
//                case let .success(data):
//                    print(data)
//                    do {
//
//                        if try result.get().genres?.count != 0 {
//                            let genre1 = try result.get().genres![0].name
//                            self.concat = genre1
//                            if try result.get().genres!.count > 1 {
//                                let genre2 = try result.get().genres![1].name
//                                self.concat = genre1 + genre2
//                            }
//                        }
//                        self.genres.append(self.concat)
//
//                        for genres in self.genres{
//                            print("GENRESSSS:   \(genres) ")
//                        }
//
//
//                    } catch {
//                        print(error.localizedDescription)
//                    }
//                }
//            }
//        }
//    }
    
}
