//
//  Guesture.swift
//  SW
//
//  Created by Jie liang Huang on 2020/10/30.
//

import SwiftUI

private struct EntryView: View {
    var body: some View {
//        Guesture()
//        DragView()
        SimultaneousView()
    }
}

struct Guesture: View {
    @State private var isPressed = false
    @GestureState private var longPressTap = false
    var body: some View {
        Image(systemName: "star.circle.fill")
            .font(.system(size: 200))
            .opacity(longPressTap ? 0.4 : 1)
            .scaleEffect(isPressed ? 0.5 : 1)
            .animation(.easeInOut)
            .gesture(
                LongPressGesture(minimumDuration: 1)
                    .updating($longPressTap, body: { (currentState, state, transaction) in
                        state = currentState
                    })
                    .onEnded({ _ in
                        isPressed.toggle()
                    })
            )
    }
}

struct DragView: View {
    @GestureState private var dragOffset: CGSize = .zero
    @State private var position: CGSize = .zero
    var body: some View {
        Image(systemName: "star.circle.fill")
            .font(.system(size: 100))
            .offset(x: position.width + dragOffset.width, y: position.height + dragOffset.height)
            .animation(.easeInOut)
            .foregroundColor(.green)
            .gesture(
                DragGesture()
                    .updating($dragOffset, body: { (value, state, transaction) in
                        state = value.translation
                    })
                    .onEnded { value in
                        position.width += value.translation.width
                        position.height += value.translation.height
                    }
            )
    }
}

struct SimultaneousView: View {
//    @GestureState private var isPressed: Bool = false
//    @GestureState private var dragOffset: CGSize = .zero
    @GestureState private var dragState: DragState = .inactive
    @State private var position: CGSize = .zero
    var body: some View {
        Image(systemName: "star.circle.fill")
            .font(.system(size: 100))
            .opacity(dragState.isPressing ? 0.5 : 1.0)
            .offset(x: position.width + dragState.translation.width, y: position.height + dragState.translation.height)
            .foregroundColor(.green)
            .animation(.easeInOut)
            .gesture(
                LongPressGesture(minimumDuration: 1)
                    .sequenced(before: DragGesture())
                    .updating($dragState, body: { (value, state, transaction) in
                        switch value {
                        case .first(true):
                            state = .pressing
                        case .second(true, let drag):
                            state = .dragging(translation: drag?.translation ?? .zero)
                        default:
                            break
                        }
                    })
                    .onEnded { value in
                        guard case .second(true, let drag?) = value else {
                            return
                        }
                        position.height += drag.translation.height
                        position.width += drag.translation.width
                    }
            )
    }
}

struct Guesture_Previews: PreviewProvider {
    static var previews: some View {
        EntryView()
    }
}

enum DragState {
    case inactive, pressing, dragging(translation: CGSize)
    var translation: CGSize {
        switch self {
        case .inactive, .pressing:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    var isPressing: Bool {
        switch self {
        case .pressing, .dragging:
            return true
        case .inactive:
            return false
        }
    }
}
