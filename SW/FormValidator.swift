//
//  FormValidator.swift
//  SW
//
//  Created by Jie liang Huang on 2020/9/23.
//

import SwiftUI
import Combine

class FormValidator: ObservableObject {
    @Published var isReadySubmit: Bool = false
}

class UserRegistrationViewModel: ObservableObject {

    // MARK: Input
    @Published var userName: String = "123"
    @Published var password: String = "123"
    @Published var passwordComfirm: String = ""

    // MARK: Output
    @Published var isUserNameLengthValid = false
    @Published var isPasswordLengthValid = false
    @Published var isPasswordCaptialLetter = false
    @Published var isPasswordConfirmValid = false

    private var cancellable: Set<AnyCancellable> = .init()

    init() {
        $userName
            .receive(on: RunLoop.main)
            .map { $0.count >= 4 }
            .assign(to: \.isUserNameLengthValid, on: self)
            .store(in: &cancellable)

        $password
            .receive(on: RunLoop.main)
            .map { $0.count >= 8 }
            .assign(to: \.isPasswordLengthValid, on: self)
            .store(in: &cancellable)

        $password
            .receive(on: RunLoop.main)
            .map { $0.range(of: "[A-Z]", options: .regularExpression) != nil }
            .assign(to: \.isPasswordCaptialLetter, on: self)
            .store(in: &cancellable)

        Publishers
            .CombineLatest($password, $passwordComfirm)
            .receive(on: RunLoop.main)
            .map { !$1.isEmpty && $0 == $1 }
            .assign(to: \.isPasswordConfirmValid, on: self)
            .store(in: &cancellable)
    }
    
}
