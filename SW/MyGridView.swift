//
//  MyGridView.swift
//  SW
//
//  Created by Jie liang Huang on 2020/11/12.
//

import SwiftUI

struct MyGridView: View {
    let data = (1...100)
    let colums = [GridItem(.fixed(200))]

    var body: some View {
        ScrollView {
            GridStackView(rows: 2, colums: 6) { (row, colum) in
                Text("R \(row), C: \(colum)")
                    .background(Color.red)
            }
        }
    }
}

struct MyGridView_Previews: PreviewProvider {
    static var previews: some View {
        MyGridView()
    }
}


struct GridStackView<Content: View>: View {
    typealias Row = Int
    typealias Colum = Int
    let rows: Row
    let colums: Colum
    let content: (Row, Colum) -> Content
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0...colums, id: \.self) { colum in
                        content(row, colum)
                    }
                }
            }
        }
    }
    init(rows: Row, colums: Colum, @ViewBuilder content: @escaping (Row, Colum) -> Content) {
        self.rows = rows
        self.colums = colums
        self.content = content
    }
}
