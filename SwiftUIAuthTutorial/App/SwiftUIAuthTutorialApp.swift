//
//  SwiftUIAuthTutorialApp.swift
//  SwiftUIAuthTutorial
//
//  Created by Ejder Dağ on 25.03.2024.
//

import SwiftUI
import Firebase

@main
struct SwiftUIAuthTutorialApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    @StateObject var viewModel = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

