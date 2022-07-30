//
//  DetailViewModel.swift
//  DesafioMobile2You
//
//  Created by Matheus de Sousa Matos on 29/07/22.
//

import Foundation

class DetailMovieViewModel: ObservableObject {
    var movie = Movie()
    var imgPath: String = "cover"
    
    //MARK: - Top Details
    @Published var favorited: Bool = false
    @Published var titleSection: String = "The Very Best Of Jonhnny Depp"
    @Published var ​voteCount: Int = 0
    @Published var popularity: Double = 0.0
    
    @Published var imgURL: String = "https://image.tmdb.org/t/p/w300"
       
    //MARK: - Card
    @Published var imageMovie: String = "cover"
    @Published var titleMovie: String = "Edward Scissorhands"
    @Published var data: String = "1990"
    @Published var gender: String = "Drama, Fantasy"

    //MARK: - Image Formatter  [Base Url + size + path]
    //https://image.tmdb.org/t/p/w300/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg
    
    init(){
        fetchMovieDetail()
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
                        self.titleSection = try result.get().title!
                        self.​voteCount = try result.get().voteCount!
                        self.popularity = try result.get().popularity!
                        
                        //MARK: - Image
                        self.imgPath = try result.get().posterPath!
                        self.imgURL = self.imgURL + self.imgPath
                        print("imgURL: \(self.imgURL)")
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
}
