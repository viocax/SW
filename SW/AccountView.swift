//
//  AccountView.swift
//  SW
//
//  Created by Jie liang Huang on 2020/9/22.
//

import SwiftUI

struct AccountView: View {
    @ObservedObject private var viewModel = UserRegistrationViewModel()
    var body: some View {
        VStack(alignment: .leading) {
            Text("Create an account")
                .font(.system(size: 35, design: .rounded))
                .fontWeight(.bold)
                .lineLimit(1)
                .fixedSize()
                .padding(.bottom, 40)
                .padding()
            CustomTextFiled(text: $viewModel.userName, type: .normal(placeHolder: "UserName"))
            RequireText(iconName: "xmark.square", text: "A minimum of 4 characters", strikethrough: viewModel.isUserNameLengthValid)
                .padding(.vertical)
            CustomTextFiled(text: $viewModel.password, type: .secure(placeHolder: "Password"))
            RequireText(iconName: "lock.open", text: "A minimum of 8 characters", strikethrough: viewModel.isPasswordLengthValid)
                .padding(.top)
                .padding(.bottom, 5)
            RequireText(iconName: "lock.open", text: "One uppercase letter", strikethrough: viewModel.isPasswordCaptialLetter)
                .padding(.bottom)
            CustomTextFiled(text: $viewModel.passwordComfirm, type: .secure(placeHolder: "Confirm password"))
            RequireText(iconName: "xmark.square", text: "Your confirm password should be the same as password", strikethrough: viewModel.isPasswordConfirmValid)
                .padding(.top)
            
            Button(action: {
                
            }) {
                Text("Sign Up")
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(red: 251/255, green: 128/255, blue: 128/255), Color(red: 253/255, green: 193/255, blue: 104/255)]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(30)
                    .padding(.top, 40)
                    .padding(.vertical)
            }
            VStack {
                HStack {
                    Text("Already have an account?")
                        .font(.system(size: 14, design: .rounded))
                        .fontWeight(.bold)
                    Button(action: {
                        
                    }, label: {
                        Text("Sign in")
                            .font(.system(size: 16, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(Color.orange.opacity(0.7))
                    })
                }.padding(.leading, 40)
                Spacer()
            }
        }.padding(.horizontal, 25)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}

struct CustomTextFiled: View {
    enum TextFieldType {
        case normal(placeHolder: String), secure(placeHolder: String)
    }
    var text: Binding<String>
    let type: TextFieldType
    var body: some View {
        Group {
            createTextView
                .font(.system(size: 20, weight: .semibold, design: .rounded))
            Divider()
                .frame(height: 3)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(2)
        }
    }
    var createTextView: some View {
        switch type {
        case let .normal(placeHolder):
            return AnyView(TextField(placeHolder, text: text))
        case let .secure(placeHolder):
            return AnyView(SecureField(placeHolder, text: text))
        }
    }
}


struct RequireText: View {
    let iconName: String
    let text: String
    var strikethrough: Bool
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(Color.red.opacity(0.5))
            Text(text)
                .font(.system(size: 16, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(Color.gray.opacity(0.6))
                .strikethrough(strikethrough)
            
        }
    }
}
