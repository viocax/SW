//
//  Loan.swift
//  SW
//
//  Created by Jie liang Huang on 2020/11/2.
//

import Foundation

struct Loan: Identifiable {
    var id: UUID = .init()
    var name: String
    var country: String
    var use: String
    var amount: Int
}

extension Loan: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case country = "location"
        case use
        case amount = "loan_amount"
    }
    enum LocationKeys: String, CodingKey {
        case country
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        let location = try values.nestedContainer(keyedBy: LocationKeys.self, forKey: .country)
        country = try location.decode(String.self, forKey: .country)
        use = try values.decode(String.self, forKey: .use)
        amount = try values.decode(Int.self, forKey: .amount)
    }
}
