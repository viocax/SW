//
//  CreditCardView.swift
//  SW
//
//  Created by Jie liang Huang on 2020/11/2.
//

import SwiftUI

struct CreditCardView: View {
    var card: Card
    var body: some View {
        Image(card.image)
            .resizable()
            .scaledToFit()
            .overlay(
                VStack(alignment: .leading) {
                    Text(card.number)
                        .bold()
                    HStack {
                        Text(card.name)
                            .bold()
                        Text("Valid Thru")
                            .font(.footnote)
                        Text(card.expiryDate)
                            .font(.footnote)
                    }
                }
                .foregroundColor(.white)
                .padding(.leading, 25)
                .padding(.bottom, 20)
                , alignment: .bottomLeading)
            .shadow(color: .gray, radius: 1, x: 0, y: 1)
    }
}

struct CreditCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(testCards) {
                CreditCardView(card: $0).previewLayout(.sizeThatFits)
            }
        }
    }
}
