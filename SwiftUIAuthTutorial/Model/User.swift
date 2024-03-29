//
//  User.swift
//  SwiftUIAuthTutorial
//
//  Created by Ejder Dağ on 26.03.2024.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    
    // Kişinin ad ve soyadının baş harflerini initials değişkenine atama
    var initals: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "Kobe Bryant", email:"test@gmail.com") // static-> tüm User objeleri tarafından erişilebilir yapıyor.
}

