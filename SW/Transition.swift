//
//  Transition.swift
//  SW
//
//  Created by Jie liang Huang on 2020/9/10.
//

import SwiftUI

private struct LoadingView: View {

    @State var isLoading: Bool = false

    var body: some View {
        VStack {
            Text("Loading")
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(maxWidth: 250, maxHeight: 12)
                    .foregroundColor(Color.gray.opacity(0.1))

                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 40, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.green)
                    .offset(x: isLoading ? 100 : -100, y: 0)
                    .animation(Animation.easeInOut(duration: 0.7).repeatForever(autoreverses: true))
            }
            .onAppear(perform: {
                isLoading.toggle()
            })
        }

        // MARK: circle View
//        ZStack {
//            Circle()
//                .stroke(Color.gray.opacity(0.2), lineWidth: 14)
//                .frame(width: 100, height: 100, alignment: .center)
//
//            Circle()
//                .trim(from: 0, to: 0.7)
//                .stroke(Color.green, lineWidth: 8)
//                .frame(width: 100, height: 100, alignment: .center)
//                .rotationEffect(Angle(degrees: !isLoading ? 0.0 : 360))
//                .animation(Animation.easeOut(duration: 0.7).repeatForever(autoreverses: false))
//                .onAppear(perform: {
//                    isLoading = true
//                })
//        }
    }
}

private struct Transition_ContentView: View {

    @State private var circleColorChanged = false
    @State private var heartColorChanged = false
    @State private var heartSizeChanged = false

    var body: some View {
        ZStack {
            Circle()
                .frame(width: 200, height: 200, alignment: .center)
                .foregroundColor(circleColorChanged ? Color(.systemGray5) : .red)
                .animation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3))
            Image(systemName: "heart.fill")
                .foregroundColor(heartColorChanged ? .red : .white)
                .font(.system(size: 100))
                .animation(nil)
                .scaleEffect(heartSizeChanged ? 1 : 0.5)
                .animation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3))
        }
//        .animation(.default)
        .onTapGesture(count: 1, perform: {
//            withAnimation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3), {
            circleColorChanged.toggle()
            heartColorChanged.toggle()
            heartSizeChanged.toggle()
//            })
        })
    }
}

struct Transition_ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
