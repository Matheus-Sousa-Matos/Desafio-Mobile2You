//
//  DetailMovieView.swift
//  DesafioMobile2You
//
//  Created by Matheus de Sousa Matos on 29/07/22.
//

import SwiftUI

struct DetailMovieView: View {
    var body: some View {
        ZStack {
            Background()
            VStack(alignment: .leading, spacing: 10) {
                CoverImage()
                VStack(alignment: .leading, spacing: 10){
                    Details()
                    ScrollView(showsIndicators: false) {
                        ForEach(0..<4) { item in
                            Card()
                        }
                    }
                }
                .padding(.leading, 2)
                .padding(.trailing, 2)
            }
        }
        .onAppear{
            Service.shared.getMovieDetail { result in
                DispatchQueue.main.async {
                    switch result {
                    case let .failure(error):
                        print(error)
                    case let .success(data):
                        print(data)
                    }
                }
            }
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

struct CoverImage: View {
    @EnvironmentObject var viewModel: DetailViewModel
    
    var body: some View {
        ZStack {
            Image(viewModel.imageSection)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.43)
                .edgesIgnoringSafeArea([.top, .leading, .trailing])
        }
    }
}

struct Details: View {
    @EnvironmentObject var viewModel: DetailViewModel
    @State var favorited = true
    
    var body: some View {
        HStack(alignment:.top, spacing: 80) {
            Text(viewModel.titleSection)
                .font(
                    .title
                    .bold()
                )
                .foregroundColor(.white)
                .padding(.trailing, 60)
            
            Button {
                print("Tapped Heart Button")
                favorited.toggle()
            } label: {
                Image(systemName: !favorited ? "heart" : "heart.fill")
                    .foregroundColor(.white)
            }
        }
        HStack {
            Label {
                Text(viewModel.​voteCount)
                    .font(.caption)
                    .foregroundColor(Color(UIColor.lightGray))
            } icon: {
                Image(systemName: "heart.fill")
                    .foregroundColor(Color.white)
            }

            Label {
                Text(viewModel.popularity)
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
    @EnvironmentObject var viewModel: DetailViewModel
    
    var body: some View{
        HStack(alignment: .center, spacing: 15) {
            Image(viewModel.imageMovie)
                .resizable()
                .frame(width: 70, height: 90)
            
            VStack(alignment: .leading) {
                Text(viewModel.titleMovie)
                    .foregroundColor(.white)
                HStack {
                    Text(viewModel.data)
                        .font(.caption)
                        .foregroundColor(.white)
                    Text(viewModel.gender)
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
