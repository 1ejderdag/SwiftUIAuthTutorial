//
//  RegistrationView.swift
//  SwiftUIAuthTutorial
//
//  Created by Ejder Dağ on 25.03.2024.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var fullName = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            // image
            
            Image("firebase")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 120)
                .padding(.vertical, 32)
            
            // forms fields
            
            VStack(spacing: 15) {
                InputView(text: $email, title: "Email Address", placeholder: "name@example.com") // Email
                    .textInputAutocapitalization(.none)
                
                InputView(text: $fullName, title: "Full Name", placeholder: "name@example.com") // Full Name
                    .textInputAutocapitalization(.none)
                
                InputView(text: $password,
                          title: "Password",
                          placeholder: "Enter your password",
                          isSecureField: true) // password
                
                ZStack(alignment: .trailing) {
                    InputView(text: $confirmPassword,
                              title: "Confirm Password",
                              placeholder: "Confirm your password",
                              isSecureField: true) // confirm password
                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.systemGreen))
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.systemRed))
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            Button {
                Task {
                    try await viewModel.createUser(withEmail: email, password: password, fullname: fullName)
                }
            } label: {
                HStack {
                    Text("SIGN UP")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundStyle(Color(.white))
                .frame(width: (UIScreen.main.bounds.width) - 32, height: 48)
            }
            .background(Color(.systemBlue))
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.top, 24)
            
        }
        Spacer()
        
        Button {
            dismiss()
        } label: {
            HStack(spacing: 2) {
                Text("Already have an account?")
                Text("Sign In")
                    .fontWeight(.bold)
            }
            .font(.system(size: 15))
        }
    }
}

// MARK: -AuthenticationFormProtocol

extension RegistrationView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && !fullName.isEmpty
        && password == confirmPassword
    }
}

#Preview {
    RegistrationView()
}
