//
//  ContentView.swift
//  SW
//
//  Created by Jie liang Huang on 2020/9/7.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                HeaderView()
                Spacer()
            }.padding(5)
            HStack {
                PricingView(title: "Basic", price: "$9",
                            textColor: .white, bgColor: .purple, isTagNeeded: false)
                PricingView(title: "Pro", price: "$19",
                            textColor: .black, bgColor: Color.gray.opacity(0.1), isTagNeeded: true)
            }
            .padding(5)
            VStack {
                Image(systemName: "wand.and.rays")
                    .renderingMode(.template)
                    .frame(width: 60, height: 30)
                    .foregroundColor(.white)
                Text("Team")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("$299")
                    .font(.system(size: 30, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)
                Text("per month")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .frame(width: 300, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .padding(5)
            .background(Color.black.opacity(0.8))
            .cornerRadius(10)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct ImageViewR6: View {
    var body: some View {
        Image("1234")
            .resizable()
            .scaledToFit()
            .frame(width: 400)
            .clipShape(Capsule())
            .opacity(0.8)
            .overlay(
                Rectangle()
                    .foregroundColor(.black)
                    .opacity(0.3)
                    .overlay(
                        Text("YZF-R6")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    )
            )
    }
}

struct HeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 2, content: {
            Text("Choose ")
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.black)
            Text("Your plan")
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.black)
        })
    }
}

struct PricingView: View {
    var title: String
    var price: String
    var textColor: Color
    var bgColor: Color

    var isTagNeeded: Bool

    var body: some View {
        ZStack {
            VStack {
                Text(title)
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.black)
                    .foregroundColor(textColor)
                    .fixedSize()
                Text(price)
                    .font(.system(size: 40, weight: .heavy, design: .rounded))
                    .foregroundColor(textColor)
                    .fixedSize()
                Text("per month")
                    .font(.headline)
                    .foregroundColor(textColor)
                    .fixedSize()
            }
            .frame(width: 70, height: 90, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .padding(40)
            .background(bgColor)
            .cornerRadius(10)

            if isTagNeeded {
                Text("Best for designer")
                    .font(.system(.caption, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color.yellow)
                    .offset(x: 0, y: 80)
                    .frame(width: 120, height: 30, alignment: .center)
            }
        }
    }
}
