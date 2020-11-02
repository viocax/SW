//
//  WalletViewq.swift
//  SW
//
//  Created by Jie liang Huang on 2020/11/2.
//

import SwiftUI

struct WalletView: View {
    @State var isCardPresented = false
    @State var isCardPressed: Bool = false
    @State var selectedCard: Card?
    @GestureState private var dragState: DragState = .inactive

    @State var cards: [Card] = testCards
    private var cardOffset: CGFloat = 50.0
    var body: some View {
        VStack {
            TopNavBar()
                .padding(.bottom)
            Spacer()
            ZStack {
                if isCardPresented {
                    ForEach(cards) { card in
                        CreditCardView(card: card)
                            .offset(offset(card))
                            .animation(.default)
                            .scaleEffect(1.0)
                            .padding(.horizontal, 25)
                            .zIndex(zIndex(card))
                            .transition(AnyTransition.slide.combined(with: .move(edge: .leading)).combined(with: .opacity))
                            .animation(animation(card))
                            .gesture(
                                TapGesture()
                                    .onEnded({
                                        withAnimation {
                                            isCardPressed.toggle()
                                            self.selectedCard = self.isCardPressed ? card : nil
                                        }
                                    })
                                    .exclusively(before: LongPressGesture(minimumDuration: 0.05)
                                                    .sequenced(before: DragGesture())
                                                    .updating($dragState, body: { (value, state, transaction) in
                                                        switch value {
                                                        case .first(true):
                                                            state = .pressing(index: cards.firstIndex(where: { $0.id == card.id }))
                                                        case .second(true, let drag):
                                                            state = .dragging(index: cards.firstIndex(where: { $0.id == card.id }), translation: drag?.translation ?? .zero)
                                                        default:
                                                            break
                                                        }
                                                    })
                                                    .onEnded { value in
                                                        guard case .second(true, let drag?) = value else {
                                                            return
                                                        }
                                                        rearrangeCards(with: card, dragOffset: drag.translation)
                                                    }
                                    )

                            )
                    }
                }
            }
            .onAppear {
                isCardPresented.toggle()
            }
            Spacer()
            if isCardPressed {
                TransactionHistoryView(transactions: testTransactions)
                    .padding(.top, 10)
                    .transition(.move(edge: .bottom))
                    .animation(Animation.easeOut(duration: 0.15).delay(0.1))
            }
        }
    }
    private func rearrangeCards(with card: Card, dragOffset: CGSize) {
        guard let draggingCardIndex = cards.firstIndex(where: { $0.id == card.id }) else {
            return
        }
        
        var newIndex = draggingCardIndex + Int(-dragOffset.height / cardOffset)
        newIndex = newIndex >= cards.count ? cards.count - 1 : newIndex
        newIndex = newIndex < 0 ? 0 : newIndex
                
        let removedCard = cards.remove(at: draggingCardIndex)
        cards.insert(removedCard, at: newIndex)
        
    }
    private func zIndex(_ card: Card) -> Double {
        guard let cardIndex = cards.firstIndex(where: { $0.id == card.id }) else {
            return 0.0
        }
        return -Double(cardIndex)
    }
    private func offset(_ card: Card) -> CGSize {
        guard let cardIndex = cards.firstIndex(where: { $0.id == card.id }) else {
            return .zero
        }
        if isCardPressed {
            guard let selectedCard = self.selectedCard,
                  let selectedCardIndex = cards.firstIndex(where: { $0.id == selectedCard.id }) else { return .zero
            }
            if cardIndex >= selectedCardIndex {
                return .zero
            }
            let offset = CGSize(width: 0, height: 1400)
            return offset
        }
    
        // Handle gesture
        var pressedOffset = CGSize.zero
        var dragOffsetY: CGFloat = 0.0

        if let draggingIndex = dragState.index, cardIndex == draggingIndex {
            pressedOffset.height = dragState.isPressing ? -20 : 0
            switch dragState.translation.width {
                case let width where width < -10:
                    pressedOffset.width = -20
                case let width where width > 10:
                    pressedOffset.width = 20
                default:
                    break
            }
            dragOffsetY = dragState.translation.height
        }
            
        return CGSize(width: 0 + pressedOffset.width, height: -cardOffset * CGFloat(cardIndex) + pressedOffset.height + dragOffsetY)

    }
    private func animation(_ card: Card) -> Animation {
        var delay = 0.0
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(cards.count - index) * 0.1
        }
        return Animation.spring(response: 0.1, dampingFraction: 0.8, blendDuration: 0.02).delay(delay)
    }
}

struct TopNavBar: View {

    var body: some View {
        HStack {
            Text("Wallet")
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.heavy)
            Spacer()
            Image(systemName: "plus.circle.fill")
                .font(.system(.title))
        }
        .padding(.horizontal)
        .padding(.top, 20)
    }
}

struct WalletViewq_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}
