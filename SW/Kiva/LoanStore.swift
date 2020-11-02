//
//  LoanStore.swift
//  SW
//
//  Created by Jie liang Huang on 2020/11/2.
//

import Foundation
import Combine

class LoanStoreViewModel: ObservableObject {
    struct LoanStore: Decodable {
        var loan: [Loan]
        enum Keys: String, CodingKey {
            case loans
        }
        init(from decoder: Decoder) throws {
            let value = try decoder.container(keyedBy: Keys.self)
            loan = try value.decode([Loan].self, forKey: .loans)
        }
    }

    @Published
    var loans: [Loan] = []

    private var cachedLoans: [Loan] = []

    private let kivaLoanURL = "https://api.kivaws.org/v1/loans/newest.json"
    private var anyCancel: Set<AnyCancellable> = .init()


    func fetch() {
        let request = URLRequest(url: URL(string: kivaLoanURL)!)
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: LoanStore.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink { (state) in
            } receiveValue: { (loaStore) in
                self.loans = loaStore.loan
                self.cachedLoans = loaStore.loan
            }.store(in: &anyCancel)
    }

    func filterLoans(maxAmount: Int) {
        self.loans = self.cachedLoans.filter { $0.amount < maxAmount }
    }
}

import SwiftUI

struct LoanCellView: View {
    var loan: Loan
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(loan.name)
                    .font(.system(.headline, design: .rounded))
                    .bold()
                Text(loan.country)
                    .font(.system(.subheadline, design: .rounded))
                Text(loan.use)
                    .font(.system(.body, design: .rounded))
            }
            Spacer()
            VStack {
                Text("$ \(loan.amount)")
                    .font(.system(.title, design: .rounded))
                    .bold()
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

struct KivaContentView: View {
    @ObservedObject var viewModel: LoanStoreViewModel = .init()

    @State private var filterEnable: Bool = false
    @State private var maximumLoanAmount: Double = 10000.0

    var body: some View {
        NavigationView {
            VStack {
                if filterEnable {
                    LoanFilterView(amount: $maximumLoanAmount)
                        .transition(.opacity)
                }
                List(viewModel.loans) { loan in
                    LoanCellView(loan: loan)
                        .padding(.vertical, 5)
                }
                .navigationBarTitle("Kiva loan")
                .navigationBarItems(trailing:
                                        Button(action: {
                                            withAnimation(.linear) {
                                                filterEnable.toggle()
                                                viewModel.filterLoans(maxAmount: Int(maximumLoanAmount))
                                            }
                                        }) {
                                            Text("Filter")
                                                .font(.subheadline)
                                                .foregroundColor(.primary)
                                        }
                )
            }
            
        }
        .onAppear() {
            viewModel.fetch()
        }
    }
}

struct LoanFilterView: View {
    @Binding var amount: Double
    var minAmount: Double = 0.0
    var maxAmount: Double = 10000.0

    var body: some View {
        VStack(alignment: .leading) {
            Text("Show loan amount below $\(Int(amount))")
                .font(.system(.headline, design: .rounded))
            HStack {
                Slider(value: $amount, in: minAmount...maxAmount, step: 100)
            }
            HStack {
                Text("\(Int(minAmount))")
                    .font(.system(.footnote, design: .rounded))
                Spacer()
                Text("\(Int(maxAmount))")
                    .font(.system(.footnote, design: .rounded))
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
}


struct LoanPreView_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            LoanCellView(loan: Loan(name: "Ivan", country: "Uganda", use: "To buy a plot of land", amount: 575))
                .previewLayout(.sizeThatFits)
            KivaContentView()
            LoanFilterView(amount: .constant(10000)).previewLayout(.sizeThatFits)
        }
    }
}


