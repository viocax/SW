//
//  CardView.swift
//  SW
//
//  Created by Jie liang Huang on 2020/9/7.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack {
                    VStack(alignment: .leading, spacing: 2, content: {
                        Text("MONDAY, AUG, 20")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("Your reading")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.bold)
                    })
                    .padding(.leading)
                    Spacer()
                }
                HStack {
                    Cell(image: "swiftui-button", category: "SwiftUI", heading: "Drawing a Border with Rounded Corners", author: "Simon Ng")
                        .frame(width: 300)
                    Cell(image: "macos-programming", category: "macOS", heading: "Building a Complex Layout with Flutter", author: "Lawrance Tan")
                        .frame(width: 300)
                    Cell(image: "flutter-app", category: "Flutter", heading: "Building a simple Editing App", author: "Gabriel Ak")
                        .frame(width: 300)
                    Cell(image: "natural-language-api", category: "iOS", heading: "what's New in Natural Language API", author: "Sam Kambampati")
                        .frame(width: 300)
                }
            })
            Spacer()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}

struct Cell: View {
    var image: String
    var category: String
    var heading: String
    var author: String
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            HStack {
                VStack(alignment: .leading, spacing: 2, content: {
                    Text(category)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(heading)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                    Text(author.uppercased())
                        .font(.caption)
                        .foregroundColor(.secondary)
                })
                Spacer()
            }
            .padding()
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        ).padding(.horizontal)
    }
}
