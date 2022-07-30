//
//  DetailViewModel.swift
//  DesafioMobile2You
//
//  Created by Matheus de Sousa Matos on 29/07/22.
//

import Foundation

class DetailMovieViewModel: ObservableObject {
    var movie = Movie()
    private var imgPath: String = "cover"
    
    @Published var similarMovies: [SimilarMovie] = []
    
    @Published var imgURLMovie: String = "https://image.tmdb.org/t/p/w300"
    @Published var titleMovie: String = "The Very Best Of Jonhnny Depp"
    @Published var ​voteCount: Int = 0
    @Published var popularity: Double = 0.0
    
    //MARK: - Buttons
    @Published var favorited: Bool = false
    
    //MARK: - Card
    @Published var imageSimilarMovie: String = "cover"
    @Published var titleSimilarMovie: String = "Edward Scissorhands"
    @Published var data: String = "1990"
    @Published var gender: String = "Drama, Fantasy"

    //MARK: - Image Formatter  [Base Url + size + path]
    //https://image.tmdb.org/t/p/w300/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg
    
    init(){
        fetchMovieDetail()
        fetchSimilarMovies()
    }

    func fetchMovieDetail(){
        Service.shared.getMovieDetail { result in
            DispatchQueue.main.async {
                switch result {
                case let .failure(error):
                    print(error)
                case let .success(data):
                    print(data)
                    do{
                        self.movie =  try result.get()
                        self.titleMovie = try result.get().title!
                        self.​voteCount = try result.get().voteCount!
                        self.popularity = try result.get().popularity!
                        
                        //MARK: - Image
                        self.imgPath = try result.get().posterPath!
                        self.imgURLMovie = self.imgURLMovie + self.imgPath
                        print("imgURLMovie: \(self.imgURLMovie)")
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func fetchSimilarMovies(){
        Service.shared.getSimilarMovies { movies in
            DispatchQueue.main.async {
                switch movies {
                case let .failure(error):
                    print(error)
                case let .success(data):
                    print(data)
                    do{
                        self.similarMovies = try movies.get().results
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
}
