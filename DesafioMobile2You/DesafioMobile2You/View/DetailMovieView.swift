//
//  DetailMovieView.swift
//  DesafioMobile2You
//
//  Created by Matheus de Sousa Matos on 29/07/22.
//

import SwiftUI

let widthScreen = UIScreen.main.bounds.width
let heightScreen = UIScreen.main.bounds.height

struct DetailMovieView: View {
    @EnvironmentObject var viewModel: DetailMovieViewModel

    var body: some View {
        ZStack {
            Background()
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    CoverImage()
                    VStack(alignment: .leading, spacing: 10){
                        Details(movie: viewModel.movie)
                        ForEach(viewModel.movies, id: \.self){ movie in
                            Card(similarMovie: movie)
                        }
                    }
                    .padding(.leading, 2)
                    .padding(.trailing, 2)
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct Background: View {
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct CoverImage: View{
    @EnvironmentObject var viewModel: DetailMovieViewModel
    @State var data: Data?
    
    var body: some View{
        if let data = data, let uiImage = UIImage(data: data){
            Image(uiImage: uiImage)
                .resizable()
                .frame(width: widthScreen, height: heightScreen*0.45)
                .edgesIgnoringSafeArea([.top, .leading, .trailing])
        }else{
            Image("cover")
                .resizable()
                .frame(width: widthScreen, height: heightScreen*0.45)
                .edgesIgnoringSafeArea([.top, .leading, .trailing])
                .onAppear {
                    DispatchQueue.main.async {
                        fetchData()
                    }
                }
        }
    }
    
    private func fetchData(){
        guard let url = URL(string: viewModel.imgURLMovie) else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data
        }
        task.resume()
    }
    
}

struct Details: View {
    @EnvironmentObject var viewModel: DetailMovieViewModel
    var movie: Movie
    
    var body: some View {
        HStack(alignment:.top, spacing: 80) {
            Text(movie.title ?? "")
                .font(
                    .title
                    .bold()
                )
                .foregroundColor(.white)
            
            Spacer()
            
            Button {
                viewModel.favorited.toggle()
            } label: {
                Image(systemName: viewModel.favorited ? "heart.fill" : "heart")
                    .foregroundColor(.white)
            }
        }
        
        HStack {
            Label {
                Text("\(movie.voteCount ?? 0) Likes")
                    .font(.caption)
                    .foregroundColor(Color(UIColor.lightGray))
            } icon: {
                Image(systemName: "heart.fill")
                    .foregroundColor(Color.white)
            }
            
            Label {
                Text("\(movie.popularity ?? 0)")
                    .font(.caption)
                    .foregroundColor(Color(UIColor.lightGray))
            } icon: {
                Image(systemName: "sleep")
                    .foregroundColor(.white)
            }
            .padding(.leading, 20)
        }
    }
}

struct Card: View{
    var similarMovie: Movie
    
    var body: some View{
        HStack(alignment: .center, spacing: 15) {
            CardImage(pathImage: similarMovie.posterPath ?? "")
            
            VStack(alignment: .leading) {
                Text(similarMovie.title ?? "")
                    .foregroundColor(.white)
                HStack {
                    Text(similarMovie.releaseDate ?? "")
                        .font(.caption)
                        .foregroundColor(.white)
                    
                    if similarMovie.genres?.count != 0 && similarMovie.genres?.count == 1{
                        Text(" \(similarMovie.genres?[0].name ?? "") ")
                            .font(.caption)
                            .foregroundColor(Color(UIColor.lightGray))
                    }
                    else if similarMovie.genres?.count != 0 && similarMovie.genres?.count ?? 0 >= 1{
                        Text(" \(similarMovie.genres?[0].name ?? "") , \(similarMovie.genres?[1].name ?? "") ")
                            .font(.caption)
                            .foregroundColor(Color(UIColor.lightGray))
                    }
                    
                  
                }
            }
            
            Spacer()
            
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.white)
                .padding(.bottom, 50)
        }
    }
}

struct CardImage: View{
    @EnvironmentObject var viewModel: DetailMovieViewModel
    @State var pathImage: String
    @State var data: Data?
    
    var body: some View{
        if let data = data, let uiImage = UIImage(data: data){
            Image(uiImage: uiImage)
                .resizable()
                .frame(width: 70, height: 90)
        }else{
            Image("cover")
                .resizable()
                .frame(width: 70, height: 90)
                .onAppear {
                    DispatchQueue.main.async {
                        viewModel.imgURLSimilarMovie = "https://image.tmdb.org/t/p/w300" + pathImage
                        fetchData()
                    }
                }
        }
    }
    
    private func fetchData(){
        guard let url = URL(string: viewModel.imgURLSimilarMovie) else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data
        }
        task.resume()
    }
    
}
