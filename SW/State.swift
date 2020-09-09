//
//  State.swift
//  SW
//
//  Created by Jie liang Huang on 2020/9/9.
//

import SwiftUI

struct StateView: View {
    @State private var counter1: Int = 0
    @State private var counter2: Int = 0
    @State private var counter3: Int = 0

    var body: some View {
        VStack {
            Text("\(counter1 + counter2 + counter3)")
            HStack {
                CounterButton(counter: $counter1, color: .red)
                CounterButton(counter: $counter2, color: .green)
                CounterButton(counter: $counter3, color: .blue)
            }
        }
    }
}

struct CounterButton: View {
    @Binding var counter: Int
    var color: Color
    var body: some View {
        Button(action: {
            counter += 1
        }, label: {
            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor(color)
                .overlay(
                    Text("\(counter)")
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                )
        })
    }
}
struct State_Previews: PreviewProvider {
    static var previews: some View {
        StateView()
    }
}
