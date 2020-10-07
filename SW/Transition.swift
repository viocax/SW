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
//        HStack {
//            ForEach(0...4, id: \.self) { index in
//                Circle()
//                    .frame(width: 10, height: 10)
//                    .foregroundColor(.green)
//                    .scaleEffect(isLoading ? 0 : 1)
//                    .animation(
//                        Animation
//                            .linear(duration: 0.6)
//                            .repeatForever()
//                            .delay(0.2 * Double(index))
//                    )
//            }
//            .onAppear() {
//                self.isLoading = true
//            }
//        }
        //MARK: loadingview
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

private struct View1: View {
    @State var recordBegin: Bool = false
    @State var recording: Bool = false
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: recordBegin ? 30 : 5)
                .frame(width: recordBegin ? 60 : 250, height: 60)
                .foregroundColor(recordBegin ? .red : .green)
                .overlay(
                    Image(systemName: "mic.fill")
                        .font(.system(.title))
                        .foregroundColor(.white)
                        .scaleEffect(recording ? 0.7 : 1)
                )
            RoundedRectangle(cornerRadius: recordBegin ? 30 : 5)
                .trim(from: 0, to: recordBegin ? 0 : 1)
                .stroke(lineWidth: 5)
                .frame(width: recordBegin ? 70 : 260, height: 70)
                .foregroundColor(.green)
        }
        .onTapGesture {
            withAnimation(.spring()) {
                self.recordBegin.toggle()
            }
            withAnimation(Animation.spring().repeatForever().delay(0.5)) {
                recording.toggle()
            }
        }
    }
}

private struct View2: View {
    @State var isShow: Bool = false
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 300, height: 300)
                .foregroundColor(.green)
                .overlay(
                    Text("Show details")
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                        .foregroundColor(.white)
                )
            if isShow {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 300, height: 300)
                    .foregroundColor(.purple)
                    .overlay(
                        Text("Well, here is the details")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                    )
                    .transition(
                        AnyTransition
                            .offset(x: -600, y: 0)
                            .combined(with: .scale)
                            .combined(with: .opacity)
//                        .asymmetric(insertion: .scale(scale: 0, anchor: .bottom), removal: .offset(x: -600, y: 0))
                    )
            }
        }
        .onTapGesture {
            withAnimation(.spring()) {
                isShow.toggle()
            }
        }
    }
}

struct Transition_ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        View1()
        View2()
    }
}
