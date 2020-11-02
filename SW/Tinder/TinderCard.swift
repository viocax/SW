//
//  Card.swift
//  SW
//
//  Created by Jie liang Huang on 2020/11/2.
//

import SwiftUI

struct TinderCardView: View, Identifiable {
    let id: UUID = .init()
    let image: String
    let title: String


    var body: some View {
        Image(image)
            .resizable()
            .scaledToFill()
            .frame(minWidth: 0, maxWidth: .infinity)
            .cornerRadius(10)
            .padding(.horizontal, 15)
            .overlay(
                ZStack {
                    Text(title)
                        .font(.system(.headline, design: .rounded))
                        .fontWeight(.bold)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 15)
                        .background(Color.white)
                        .cornerRadius(5)
                }
                .padding([.bottom], 20),
                alignment: .bottom
            )
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        TinderCardView(image: "yosemite-usa", title: "Yosemite, USA")
    }
}
