//
//  InputView.swift
//  SwiftUIAuthTutorial
//
//  Created by Ejder Dağ on 25.03.2024.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            Text(title)
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundStyle(Color(.darkGray))
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
                    
            } else {
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
                    .textCase(.none)
                    
            }
            Divider()
        }
    }
}

#Preview {
    InputView(text: .constant(""), title: "Email Address", placeholder: "name@example.com")
}
