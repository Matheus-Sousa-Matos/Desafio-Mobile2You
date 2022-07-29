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
            VStack(spacing: 2) {
                CoverImage()
                VStack(alignment: .leading, spacing: 10) {
                    Details()
                    ScrollView(showsIndicators: false) {
                        ForEach(0..<4) { item in
                            Card()
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width)
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
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.5, alignment: .top)
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
                .padding(.trailing, 35)
           
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
                    .font(.caption)
                    .foregroundColor(Color(UIColor.lightGray))
            } icon: {
                Image(systemName: "heart.fill")
                    .foregroundColor(Color.white)
            }

            Label {
                Text("3 of 10 Watched")
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
    var body: some View{
        HStack(alignment: .center) {
            Image("cover")
                .resizable()
                .frame(width: 70, height: 90)
            
            VStack(alignment: .leading) {
                Text("Edward Scissorhands")
                    .foregroundColor(.white)
                HStack {
                    Text("1990")
                        .font(.caption)
                        .foregroundColor(.white)
                    Text("Drama, Fantasy")
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
