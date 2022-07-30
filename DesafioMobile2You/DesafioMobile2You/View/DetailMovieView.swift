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
                        Details()
                        ForEach(viewModel.similarMovies, id: \.self) { similarMovie in
                            Text(similarMovie.title ?? "")
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
    
    var body: some View {
        HStack(alignment:.top, spacing: 80) {
            Text(viewModel.titleMovie)
                .font(
                    .title
                    .bold()
                )
                .foregroundColor(.white)
                .padding(.trailing, 60)
            
            Button {
                viewModel.favorited.toggle()
            } label: {
                Image(systemName: viewModel.favorited ? "heart.fill" : "heart")
                    .foregroundColor(.white)
            }
        }
        
        HStack {
            Label {
                Text("\(viewModel.​voteCount) Likes")
                    .font(.caption)
                    .foregroundColor(Color(UIColor.lightGray))
            } icon: {
                Image(systemName: "heart.fill")
                    .foregroundColor(Color.white)
            }

            //Substituir o 32 pela quantidade de filmes similares...
            
            Label {
                Text("\(viewModel.popularity) of 32 Watched")
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
    var similarMovie: SimilarMovie
    
    var body: some View{
        HStack(alignment: .center, spacing: 15) {
            Image("cover")
                .resizable()
                .frame(width: 70, height: 90)
            
            VStack(alignment: .leading) {
                Text("title")
                    .foregroundColor(.white)
                HStack {
                    Text("1990")
                        .font(.caption)
                        .foregroundColor(.white)
                    Text("Romance")
                        .font(.caption)
                        .foregroundColor(Color(UIColor.lightGray))
                }
            }
            
            Spacer()
            
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.white)
                .padding(.bottom, 50)
        }
    }
}
