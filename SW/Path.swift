//
//  Path.swift
//  SW
//
//  Created by Jie liang Huang on 2020/9/9.
//

import SwiftUI

private struct PreView: View {
    var body: some View {
        VStack {
            PathView()
            RedButton {
                print("ok")
            }.offset(x: 0, y: 40)
        }
    }
}

private struct PathView: View {
    private let purpleGradient: LinearGradient = .init(gradient: Gradient(colors: [Color(red: 207/255, green: 150/255, blue: 207/255), Color(red: 107/255, green: 116/255, blue: 179/255)]), startPoint: .trailing, endPoint:  .leading)
    var body: some View {
//        Path() { path in
//            path.move(to: .init(x: 200, y: 200))
//            path.addArc(center: .init(x: 200, y: 200), radius: 100, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
//        }
//        .fill(Color.purple)

//        RedButton(action: {
//            print("ok")ii
//        })
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.15), lineWidth: 20)
                .frame(width: 300, height: 300, alignment: .center)
            Circle()
                .trim(from: 0, to: 0.85)
                .stroke(purpleGradient, lineWidth: 20)
                .frame(width: 300, height: 300, alignment: .center)
                .overlay(
                    VStack {
                        Text("\(85) %")
                            .font(.system(size: 80, weight: .bold, design: .rounded))
                            .foregroundColor(Color(.systemGray))
                        Text("Complete")
                            .font(.system(.body, design: .rounded))
                            .bold()
                            .foregroundColor(Color(.systemGray))
                    }
                )
        }

    }
}

struct PreView_Previews: PreviewProvider {
    static var previews: some View {
        PreView()
    }
}

struct RedButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: action, label: {
            Text("Test")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 250, height: 50, alignment: .center)
                .background(Demo().fill(Color.red))
        })
    }
}

struct Demo: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .init(x: 0, y: 0))
        path.addQuadCurve(to: .init(x: rect.size.width, y: 0), control: .init(x: rect.size.width/2, y: -(rect.size.width*0.1)))
        path.addRect(CGRect(origin: .zero, size: rect.size))
        return path
    }
}
