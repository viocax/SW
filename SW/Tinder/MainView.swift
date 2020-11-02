//
//  MainView.swift
//  SW
//
//  Created by Jie liang Huang on 2020/11/2.
//

import SwiftUI

struct MainView: View {

    @GestureState
    private var dragState: DragState = .inactive

    private let dragThreshold: CGFloat = 80

    @State
    private var removalTransition: AnyTransition = .trailingBottom

    @State
    var cardViews: [TinderCardView] = {
        var views = [TinderCardView]()
        for index in 0..<2 {
            views.append(TinderCardView(image: trips[index].image, title: trips[index].destination))
        }
        return views
    }()

    @State private var lastIndex = 1

    var body: some View {
        VStack {
            TopBarMenu()
            ZStack {
                ForEach(cardViews) { cardview in
                    cardview
                        .zIndex(isTop(cardview) ? 1 : 0)
                        .overlay(
                            ZStack {
                                Image(systemName: "x.circle")
                                    .foregroundColor(.white)
                                    .font(.system(size: 100))
                                    .opacity(dragState.translation.width < -dragThreshold && isTop(cardview) ? 1 : 0)
                                Image(systemName: "heart.circle")
                                    .foregroundColor(.white)
                                    .font(.system(size: 100))
                                    .opacity(dragState.translation.width > dragThreshold && isTop(cardview) ? 1 : 0)
                            }
                        )
                        .offset(isTop(cardview) ? dragState.translation : .zero)
                        .scaleEffect(dragState.isDragging && isTop(cardview) ? 0.95 : 1.0)
                        .rotationEffect(Angle(degrees: isTop(cardview) ?  Double(dragState.translation.width/10) : 0))
                        .animation(.interpolatingSpring(stiffness: 180, damping: 100))
                        .transition(removalTransition)
                        .gesture(
                            LongPressGesture(minimumDuration: 0.01)
                                .sequenced(before: DragGesture())
                                .updating($dragState, body: { (value, state, tansaction) in
                                    print("updating")
                                    switch value {
                                    case .first(true):
                                        state = .pressing
                                    case .second(true, let drag):
                                        state = .dragging(translation: drag?.translation ?? .zero)
                                    default:
                                        break
                                    }
                                })
                                .onChanged { value in
                                    print("onChanged")
                                    guard case .second(true, let drag?) = value else  {
                                        return
                                    }
                                    if drag.translation.width < -dragThreshold {
                                        removalTransition = .leadingBottom
                                    }
                                    if drag.translation.width > dragThreshold {
                                        removalTransition = .trailingBottom
                                    }
                                }
                                .onEnded { value in
                                    print("onEnded")
                                    print("==============")
                                    guard case .second(true, let drag?) = value else {
                                        return
                                    }
                                    if drag.translation.width < -dragThreshold || drag.translation.width > dragThreshold {
                                        moveCard()
                                    }
                                }
                        )
                }
            }
            Spacer(minLength: 20)
            BottomBarMenu()
                .opacity(dragState.isDragging ? 0 : 1)
                .animation(.default)
        }
    }
    func isTop(_ cardView: TinderCardView) -> Bool {
        guard let index = cardViews.firstIndex(where: { $0.id == cardView.id }) else {
            return false
        }
        return index == 0
    }
    func moveCard() {
        cardViews.removeFirst()
        lastIndex += 1
        let trip = trips[lastIndex % trips.count]
        let newCardView = TinderCardView(image: trip.image, title: trip.destination)
        cardViews.append(newCardView)
    }
}

struct TopBarMenu: View {
    var body: some View {
        HStack {
            Image(systemName: "line.horizontal.3")
                .font(.system(size: 30))
            Spacer()
            Image(systemName: "mappin.and.ellipse")
                .font(.system(size: 35))
            Spacer()
            Image(systemName: "heart.circle.fill")
                .font(.system(size: 30))
        }
        .padding()
    }
}

struct BottomBarMenu: View {
    var body: some View {
        HStack {
            Image(systemName: "xmark")
                .font(.system(size: 30))
                .foregroundColor(.black)
            Button(action: {
                
            }) {
                Text("Book it now")
                    .font(.system(.subheadline, design: .rounded))
                    .bold()
                    .foregroundColor(.white)
                    .padding(.horizontal, 35)
                    .padding(.vertical, 15)
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            Image(systemName: "heart")
                .font(.system(size: 30))
                .foregroundColor(.black)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension AnyTransition {
    static var trailingBottom: AnyTransition {
        AnyTransition.asymmetric(insertion: .identity, removal: AnyTransition.move(edge: .trailing).combined(with: .move(edge: .bottom)))
    }
    static var leadingBottom: AnyTransition {
        AnyTransition.asymmetric(insertion: .identity, removal: AnyTransition.move(edge: .leading).combined(with: .move(edge: .bottom)))
    }
}
