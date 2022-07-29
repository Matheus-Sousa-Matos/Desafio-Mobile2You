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
            VStack {
                CoverImage()
                Spacer()
                VStack(alignment: .leading, spacing: 10) {
                    Details()
                }
                Spacer()
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
    var body: some View {
        ZStack(alignment: .top) {
            Image("cover")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: 250, alignment: .top)
                .edgesIgnoringSafeArea([.top, .leading, .trailing])
        }
    }
}

struct Details: View {
    var body: some View {
        HStack(alignment:.top, spacing: 80) {
            Text("The Very Best Of Jonhnny Depp")
                .font(
                    .title
                    .bold()
                )
                .foregroundColor(.white)
           
            Button {
                print("Tapped Heart Button")
            } label: {
                Image(systemName: "heart.fill")
                    .foregroundColor(.white)
            }
        }
        HStack {
            Label {
                Text("1.2K Likes")
                    .foregroundColor(.white)
            } icon: {
                Image(systemName: "heart.fill")
                    .foregroundColor(Color.white)
            }

            Label {
                Text("3 of 10 Watched")
                    .foregroundColor(.white)

            } icon: {
                Image(systemName: "sleep")
                    .foregroundColor(.white)
            }
            .padding(.leading, 20)
        }
    }
}
