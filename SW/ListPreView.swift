//
//  ListPreView.swift
//  SW
//
//  Created by Jie liang Huang on 2020/9/10.
//

import SwiftUI


private var restaurantImages: [String] {
    return ["cafedeadend", "homei", "teakha", "cafeloisl", "petite oyster", "forkeerestaurant", "posatelier", "bourkestreetbakery", "haighschocolate" , "palominoespresso", "upstate", "traif", "grahamavenuemeats", "wafflewolf", "five leaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "caskpub kitchen"]
}

struct ListPreView: View {

    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petit e Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats And Deli" , "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donos tia", "Royal Oak", "CASK Pub and Kitchen"].enumerated().map { index, value in
        Restaurant(name: value, image: restaurantImages[index])
    }

    var body: some View {
        NavigationView {
            List(restaurantNames.indices) { index in
                if (0...1).contains(index) {
                    BigRow(restaurant: restaurantNames[index])
                } else {
                    Row(restaurant: restaurantNames[index])
                }
            }
            .navigationBarTitle("Restaurants")
            .foregroundColor(.black)
        }
    }
}

struct ListPreView_Previews: PreviewProvider {
    static var previews: some View {
        ListPreView()
    }
}

struct Restaurant: Identifiable {
    var id: UUID = UUID()
    var name: String
    var image: String
}

private struct Row: View {
    var restaurant: Restaurant
    var body: some View {
        HStack {
            Image(restaurant.image)
                .resizable()
                .frame(width: 40, height: 40)
                .cornerRadius(5)
            Text(restaurant.name)
        }
    }
}

private struct BigRow: View {
    var restaurant: Restaurant
    var body: some View {
        ZStack {
            Image(restaurant.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .cornerRadius(10)
                .overlay(
                    Rectangle()
                        .foregroundColor(.black)
                        .contrast(20)
                        .opacity(0.1)
                )

            Text(restaurant.name)
                .font(.system(.title, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(.white)
        }
    }
}

/// MARK: 1

