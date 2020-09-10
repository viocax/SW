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
        List(restaurantNames, id: \.id) { restaurant in
            Row(restaurant: restaurant)
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
