//
//  ContentView.swift
//  SwiftUIList
//
//  Created by Simon Ng on 9/9/2019.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import SwiftUI

struct ScrollDeleteContentView: View {
    
    @State var restaurants = [ Restaurant(name: "Cafe Deadend", image: "cafedeadend"),
                   Restaurant(name: "Homei", image: "homei"),
                   Restaurant(name: "Teakha", image: "teakha"),
                   Restaurant(name: "Cafe Loisl", image: "cafeloisl"),
                   Restaurant(name: "Petite Oyster", image: "petiteoyster"),
                   Restaurant(name: "For Kee Restaurant", image: "forkeerestaurant"),
                   Restaurant(name: "Po's Atelier", image: "posatelier"),
                   Restaurant(name: "Bourke Street Bakery", image: "bourkestreetbakery"),
                   Restaurant(name: "Haigh's Chocolate", image: "haighschocolate"),
                   Restaurant(name: "Palomino Espresso", image: "palominoespresso"),
                   Restaurant(name: "Homei", image: "upstate"),
                   Restaurant(name: "Traif", image: "traif"),
                   Restaurant(name: "Graham Avenue Meats And Deli", image: "grahamavenuemeats"),
                   Restaurant(name: "Waffle & Wolf", image: "wafflewolf"),
                   Restaurant(name: "Five Leaves", image: "fiveleaves"),
                   Restaurant(name: "Cafe Lore", image: "cafelore"),
                   Restaurant(name: "Confessional", image: "confessional"),
                   Restaurant(name: "Barrafina", image: "barrafina"),
                   Restaurant(name: "Donostia", image: "donostia"),
                   Restaurant(name: "Royal Oak", image: "royaloak"),
                   Restaurant(name: "CASK Pub and Kitchen", image: "caskpubkitchen")
    ]

    @State private var showActionSheet = false
    @State private var selectedRestaurant: Restaurant?
    
    var body: some View {
        List {
            ForEach(restaurants) { restaurant in
                BasicImageRow(restaurant: restaurant)
                    .contextMenu {
                        Button(action: {
                            delete(at: restaurant)
                        }) {
                            HStack {
                                Text("Delete")
                                Image(systemName: "trash")
                            }
                        }
                        Button(action: {
                            setFavorite(at: restaurant)
                        }) {
                            HStack {
                                Text("Favorite")
                                Image(systemName: "star")
                            }
                        }
                        Button(action: {
                            setCheckIn(at: restaurant)
                        }) {
                            HStack {
                                Text("check-in")
                                Image(systemName: "checkmark.seal.fill")
                            }
                        }
                    }
                    .onTapGesture {
                        showActionSheet.toggle()
                        selectedRestaurant = restaurant
                    }
                    .actionSheet(isPresented: $showActionSheet, content: {
                        ActionSheet(title: Text("What do yoy want to do?"), message: nil, buttons: [
                            .default(Text("Mark as Favorite"), action: {
                                if let selected = selectedRestaurant {
                                    setFavorite(at: selected)
                                }
                            }),
                            .default(Text("check-in"), action: {
                                if let selected = selectedRestaurant {
                                    setCheckIn(at: selected)
                                }
                            }),
                            .destructive(Text("Delete"), action: {
                                if let selected = selectedRestaurant {
                                    delete(at: selected)
                                }
                            }),
                            .cancel()
                        ])
                    })
            }.onDelete { indexSet in
                self.restaurants.remove(atOffsets: indexSet)
            }
        }
    }
    func delete(at restaurant: Restaurant) {
        guard let index = restaurants.firstIndex(where: { $0.id == restaurant.id }) else {
            return
        }
        self.restaurants.remove(at: index)
    }
    func setFavorite(at restaurant: Restaurant) {
        guard let index = restaurants.firstIndex(where: { $0.id == restaurant.id
        }) else {
            return
        }
        self.restaurants[index].isFavorite.toggle()
    }
    func setCheckIn(at restaurant: Restaurant) {
        guard let index = restaurants.firstIndex(where: { $0.id == restaurant.id
        }) else {
            return
        }
        self.restaurants[index].isCheckIn.toggle()
    }
}

struct ScrollDeleteContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollDeleteContentView()
    }
}

struct BasicImageRow: View {
    var restaurant: Restaurant
    
    var body: some View {
        HStack {
            Image(restaurant.image)
                .resizable()
                .frame(width: 40, height: 40)
                .cornerRadius(5)
            Text(restaurant.name)
            if restaurant.isCheckIn {
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(.red)
            }
            if restaurant.isFavorite {
                Spacer()
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
    }
}

