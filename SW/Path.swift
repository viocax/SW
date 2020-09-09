//
//  Path.swift
//  SW
//
//  Created by Jie liang Huang on 2020/9/9.
//

import SwiftUI

private struct PreView: View {
    var body: some View {
        PathView()
    }
}

private struct PathView: View {
    var body: some View {
        Path() { path in
            path.move(to: .init(x: 20, y: 20))
            path.addLine(to: .init(x: 150, y: 20))
            path.addLine(to: .init(x: 150, y: 150))
            path.addLine(to: .init(x: 20, y: 150))
            path.closeSubpath()
        }
        .stroke(Color.green, lineWidth: 5)
    }
}
struct PreView_Previews: PreviewProvider {
    static var previews: some View {
        PreView()
    }
}
