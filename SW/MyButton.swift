//
//  MyButton.swift
//  SW
//
//  Created by Jie liang Huang on 2020/9/9.
//

import SwiftUI

struct MyButton: View {
    var body: some View {
        Button(action: {

        }, label: {
            HStack {
                Image(systemName: "trash")
                Text("1234")
            }
        }).buttonStyle(MyStyle())
    }
}

struct MyButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MyButton()
        }
    }
}

struct MyStyle: PrimitiveButtonStyle {
    typealias Body = Button

    func makeBody(configuration: Configuration) -> some View {
        return configuration.label
            .frame(minWidth: 0.0, maxWidth: .infinity)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
            .cornerRadius(40)
            .padding(.horizontal, 20)
    }
}

struct MyButtonModifier: ViewModifier {
    func body(content: _ViewModifier_Content<MyButtonModifier>) -> some View {
        return content
            .padding()
            .background(Color.yellow)
            .cornerRadius(20)
    }
}
